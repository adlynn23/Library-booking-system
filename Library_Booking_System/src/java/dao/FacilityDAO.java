/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import java.util.*;
import model.Facility;
import util.DBConnection;

/**
 *
 * @author ASUS
 */
public class FacilityDAO {

    public List<Facility> getAllFacilities() {
        List<Facility> facilities = new ArrayList<>();

        String sql = "SELECT f.*, "
                + "(SELECT m.description FROM maintenance m "
                + "WHERE m.maintenance_status <> 'Done' "
                + "AND (m.facility_id = CAST(f.facility_id AS CHAR) OR m.facility_id = f.unit_name) "
                + "ORDER BY m.maintenance_id DESC LIMIT 1) AS unavailable_reason "
                + "FROM facility f "
                + "ORDER BY f.facility_name, f.unit_name";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                facilities.add(mapFacility(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return facilities;
    }

    public List<String> getFacilityTypes() {
        List<String> types = new ArrayList<>();

        String sql = "SELECT DISTINCT facility_name FROM facility ORDER BY facility_name";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                types.add(rs.getString("facility_name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return types;
    }

    public boolean addFacility(Facility facility) {
        String sql = "INSERT INTO facility "
                + "(facility_name, unit_name, description, capacity, status, image_url) "
                + "VALUES (?, ?, ?, ?, 'AVAILABLE', ?)";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, facility.getFacilityName());
            ps.setString(2, facility.getUnitName());
            ps.setString(3, facility.getDescription());
            ps.setInt(4, facility.getCapacity());
            ps.setString(5, facility.getImageUrl());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateFacility(Facility facility, boolean updateImage) {
        String sql = updateImage
                ? "UPDATE facility SET facility_name=?, unit_name=?, description=?, capacity=?, image_url=? WHERE facility_id=?"
                : "UPDATE facility SET facility_name=?, unit_name=?, description=?, capacity=? WHERE facility_id=?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, facility.getFacilityName());
            ps.setString(2, facility.getUnitName());
            ps.setString(3, facility.getDescription());
            ps.setInt(4, facility.getCapacity());

            if (updateImage) {
                ps.setString(5, facility.getImageUrl());
                ps.setInt(6, facility.getFacilityId());
            } else {
                ps.setInt(5, facility.getFacilityId());
            }

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateFacilityStatus(int facilityId, String status) {
        String sql = "UPDATE facility SET status=? WHERE facility_id=?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, facilityId);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteFacility(int facilityId) {
        String sql = "DELETE FROM facility WHERE facility_id=?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, facilityId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Facility mapFacility(ResultSet rs) throws SQLException {
        Facility facility = new Facility();

        facility.setFacilityId(rs.getInt("facility_id"));
        facility.setFacilityName(rs.getString("facility_name"));
        facility.setUnitName(rs.getString("unit_name"));
        facility.setDescription(rs.getString("description"));
        facility.setCapacity(rs.getInt("capacity"));
        facility.setStatus(rs.getString("status"));
        facility.setImageUrl(rs.getString("image_url"));

        try {
            facility.setUnavailableReason(rs.getString("unavailable_reason"));
        } catch (SQLException e) {
            facility.setUnavailableReason(null);
        }

        return facility;
    }
}
