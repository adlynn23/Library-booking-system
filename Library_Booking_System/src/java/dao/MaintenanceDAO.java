package dao;

import model.Maintenance;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MaintenanceDAO {
    
    // Replace with your actual database connection details
    private static final String URL = "jdbc:mysql://localhost:3306/library_db";
    private static final String USER = "root";
    private static final String PASS = "password";

    // Method to get a connection
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return DriverManager.getConnection(URL, USER, PASS);
    }

    // Fetches all maintenance records for the dashboard 
    public static List<Maintenance> getAllMaintenance() {
        List<Maintenance> list = new ArrayList<>();
        String query = "SELECT * FROM maintenance";
        
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Maintenance m = new Maintenance();
                m.setMaintenanceId(rs.getString("maintenance_id"));
                m.setFacilityId(rs.getString("facility_id"));
                m.setStartDate(rs.getDate("start_date"));
                m.setEndDate(rs.getDate("end_date"));
                m.setStatus(rs.getString("maintenance_status"));
                list.add(m);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Updates maintenance to 'Done' and restores facility to 'Available' [cite: 211, 393, 398]
    public boolean completeMaintenance(String maintenanceId, String facilityId) {
        String updateMaint = "UPDATE maintenance SET maintenance_status = 'Done' WHERE maintenance_id = ?";
        String updateFac = "UPDATE facility SET status = 'Available' WHERE facility_id = ?";
        
        try (Connection con = getConnection()) {
            con.setAutoCommit(false); // Start transaction
            
            try (PreparedStatement ps1 = con.prepareStatement(updateMaint);
                 PreparedStatement ps2 = con.prepareStatement(updateFac)) {
                
                ps1.setString(1, maintenanceId);
                ps1.executeUpdate();
                
                ps2.setString(1, facilityId);
                ps2.executeUpdate();
                
                con.commit(); // Save changes
                return true;
            } catch (SQLException e) {
                con.rollback();
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

 public boolean updateMaintenanceStatus(String maintenanceId, String facilityId, String status) {
    // SQL to update maintenance record and the facility availability
    String updateMaintSql = "UPDATE maintenance SET maintenance_status = 'Done' WHERE maintenance_id = ?";
    String updateFacilitySql = "UPDATE facility SET status = 'Available' WHERE facility_id = ?";
    
    try (Connection conn = getConnection()) {
        conn.setAutoCommit(false); // Start transaction for consistency [cite: 864]
        
        try (PreparedStatement psMaint = conn.prepareStatement(updateMaintSql);
             PreparedStatement psFac = conn.prepareStatement(updateFacilitySql)) {
            
            psMaint.setString(1, maintenanceId);
            psMaint.executeUpdate();
            
            psFac.setString(1, facilityId);
            psFac.executeUpdate();
            
            conn.commit(); // Save changes to both tables [cite: 864]
            return true;
        } catch (SQLException e) {
            conn.rollback(); // Undo changes if something fails [cite: 864]
            return false;
        }
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}
}
