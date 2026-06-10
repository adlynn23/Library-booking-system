/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import java.util.*;
import model.Maintenance;
import util.DBConnection; // Ensure you have a DBConnection utility class

public class MaintenanceDAO {

    // Method to fetch all maintenance records for the admin dashboard [cite: 655]
    public static List<Maintenance> getAllMaintenance() {
        List<Maintenance> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT m.*, COALESCE(CONCAT(f.unit_name, ' - ', f.facility_name), m.facility_id) AS facility_display_name "
                    + "FROM maintenance m "
                    + "LEFT JOIN facility f ON f.facility_id = CAST(m.facility_id AS UNSIGNED) "
                    + "OR f.unit_name = m.facility_id "
                    + "ORDER BY m.maintenance_id DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Maintenance m = new Maintenance();
                m.setMaintenanceId(rs.getInt("maintenance_id"));
                m.setDescription(rs.getString("description"));
                m.setFacilityId(rs.getString("facility_id"));
                m.setFacilityName(rs.getString("facility_display_name"));
                m.setStartDate(rs.getString("start_date"));
                m.setEndDate(rs.getString("end_date"));
                m.setStatus(rs.getString("maintenance_status"));
                list.add(m);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Method to update status and restore facility availability [cite: 656, 746]
    public boolean updateMaintenanceStatus(int maintenanceId, int facilityId, String status) {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Use transaction for data consistency 

            // 1. Update maintenance task status
            String sqlMaintenance = "UPDATE maintenance SET maintenance_status = ? WHERE maintenance_id = ?";
            PreparedStatement psM = conn.prepareStatement(sqlMaintenance);
            psM.setString(1, status);
            psM.setInt(2, maintenanceId);
            psM.executeUpdate();

            // 2. If status is "Done", set facility back to "Available" [cite: 651, 658, 739]
            if ("Done".equalsIgnoreCase(status)) {
                String sqlFacility = "UPDATE facility SET status = 'AVAILABLE' WHERE facility_id = ?";
                PreparedStatement psF = conn.prepareStatement(sqlFacility);
                psF.setInt(1, facilityId);
                psF.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (Exception e) {
            if (conn != null) try {
                conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
