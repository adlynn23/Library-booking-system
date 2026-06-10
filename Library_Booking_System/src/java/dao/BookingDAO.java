package dao;

import model.Facility;
import java.sql.*;
import java.util.*;
import util.DBConnection;

public class BookingDAO {

    public List<Facility> searchAvailableFacilities(
            String type, String date, String startTime, String endTime) {

        List<Facility> list = new ArrayList<>();

        try {
            Connection conn = DBConnection.getConnection();

            String sql
                   
                    = "SELECT * FROM facility f "
                    + "WHERE (? = '' OR f.facility_name = ?) "
                    + "AND UPPER(f.status) = 'AVAILABLE' "
                    + "AND f.unit_name NOT IN ("
                    + "SELECT b.facility_name FROM booking b "
                    + "WHERE b.booking_date = ? "
                    + "AND b.status != 'REJECTED' "
                    + "AND NOT (b.end_time <= ? OR b.start_time >= ?))";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, type);
            ps.setString(2, type);
            ps.setString(3, date);
            ps.setString(4, startTime);
            ps.setString(5, endTime);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Facility f = new Facility();

                f.setFacilityId(rs.getInt("facility_id"));
                f.setFacilityName(rs.getString("facility_name"));
                f.setUnitName(rs.getString("unit_name"));
                f.setDescription(rs.getString("description"));
                f.setCapacity(rs.getInt("capacity"));
                f.setImageUrl(rs.getString("image_url"));
                f.setStatus(rs.getString("status"));

                list.add(f);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
