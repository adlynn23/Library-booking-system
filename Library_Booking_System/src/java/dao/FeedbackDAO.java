package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Feedback;
import util.DBConnection;

public class FeedbackDAO {

    public static int insertFeedback(Feedback f) {
        int status = 0;
        try (Connection con = DBConnection.getConnection()) {
            String sql = "INSERT INTO student_feedback (matric_no, subject, message, status, priority, category) "
                       + "VALUES (?, ?, ?, 'Pending', 'Medium', 'General')";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, f.getMatric_no());
            ps.setString(2, f.getSubject());
            ps.setString(3, f.getMessage());
            status = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public static List<Feedback> getAllFeedback() {
        List<Feedback> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM student_feedback ORDER BY id DESC");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapFeedback(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static List<Feedback> getFeedbackByMatricNo(String matricNo) {
        List<Feedback> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM student_feedback WHERE matric_no = ? ORDER BY id DESC");
            ps.setString(1, matricNo);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapFeedback(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static int updateAdminReply(int id, String status, String adminReply,
                                       String priority, String category, String expectedCompletion) {
        int result = 0;
        try (Connection con = DBConnection.getConnection()) {
            String sql = "UPDATE student_feedback SET status=?, admin_reply=?, priority=?, category=?, expected_completion=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, status);
            ps.setString(2, adminReply);
            ps.setString(3, priority);
            ps.setString(4, category);

            if (expectedCompletion == null || expectedCompletion.trim().isEmpty()) {
                ps.setNull(5, java.sql.Types.DATE);
            } else {
                ps.setString(5, expectedCompletion);
            }

            ps.setInt(6, id);
            result = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    private static Feedback mapFeedback(ResultSet rs) throws SQLException {
        Feedback f = new Feedback();
        f.setFeedbackId(rs.getInt("id"));
        f.setMatric_no(rs.getString("matric_no"));
        f.setSubject(rs.getString("subject"));
        f.setMessage(rs.getString("message"));
        f.setDate(rs.getString("submission_date"));
        f.setStatus(rs.getString("status"));
        f.setAdminReply(rs.getString("admin_reply"));
        f.setPriority(rs.getString("priority"));
        f.setCategory(rs.getString("category"));
        f.setExpectedCompletion(rs.getString("expected_completion"));
        return f;
    }
}
