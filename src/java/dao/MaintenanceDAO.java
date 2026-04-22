/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author DELL
 */
import java.sql.*;
import java.util.*;
import model.Maintenance;

public class MaintenanceDAO {

    public static void addMaintenance(Maintenance m) {
        try {
            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO maintenance(facility_id, start_date, end_date, status) VALUES(?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, m.getFacilityId());
            ps.setString(2, m.getStartDate());
            ps.setString(3, m.getEndDate());
            ps.setString(4, m.getStatus());
            ps.executeUpdate();

            // UPDATE facility status
            String update = "UPDATE facility SET status='Under Maintenance' WHERE facility_id=?";
            PreparedStatement ps2 = con.prepareStatement(update);
            ps2.setInt(1, m.getFacilityId());
            ps2.executeUpdate();

        } catch(Exception e){
            e.printStackTrace();
        }
    }

    public static List<Maintenance> getAllMaintenance() {
        List<Maintenance> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            ResultSet rs = con.createStatement().executeQuery("SELECT * FROM maintenance");
            while(rs.next()) {
                Maintenance m = new Maintenance();
                m.setMaintenanceId(rs.getInt("maintenance_id"));
                m.setFacilityId(rs.getInt("facility_id"));
                m.setStartDate(rs.getString("start_date"));
                m.setEndDate(rs.getString("end_date"));
                m.setStatus(rs.getString("status"));
                list.add(m);
            }
        } catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }
}