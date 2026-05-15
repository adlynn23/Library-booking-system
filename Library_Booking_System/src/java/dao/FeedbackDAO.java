package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Feedback;
import util.DBConnection; // Ensure you have this utility class [cite: 1824]

public class FeedbackDAO {

    // Saves student feedback from custCare.jsp [cite: 1159, 1782]
    public static int insertFeedback(Feedback f) {
        int status = 0;
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO feedback (matric_no, subject, message) VALUES (?, ?, ?)");
            ps.setString(1, f.getMatric_no());
            ps.setString(2, f.getSubject());
            ps.setString(3, f.getMessage());
            status = ps.executeUpdate();
            con.close();
        } catch (Exception e) { e.printStackTrace(); }
        return status;
    }

    // Fetches all feedback for the admin dashboard 
    public static List<Feedback> getAllFeedback() {
        List<Feedback> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM student_feedback ORDER BY id DESC");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Feedback f = new Feedback();
                f.setMatric_no(rs.getString("matric_no"));
                f.setSubject(rs.getString("subject"));
                f.setMessage(rs.getString("message"));
                list.add(f);
            }
            con.close();
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}