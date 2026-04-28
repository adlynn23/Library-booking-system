/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */package dao;

import java.sql.*;
import java.util.*;
import model.Feedback; // You will need a simple Feedback model class too

public class FeedbackDAO {
    // Method to save student submission
    public boolean insertFeedback(String subject, String message) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO feedback (subject, message) VALUES (?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, subject);
            ps.setString(2, message);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    // Method for Admin to fetch all feedback
    public static List<Map<String, String>> getAllFeedback() {
        List<Map<String, String>> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM feedback ORDER BY created_at DESC";
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                Map<String, String> f = new HashMap<>();
                f.put("subject", rs.getString("subject"));
                f.put("message", rs.getString("message"));
                f.put("date", rs.getString("created_at"));
                list.add(f);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}