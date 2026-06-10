package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Facility;
import util.DBConnection;

public class FacilityServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Facility> list = new ArrayList<>();

        String type = request.getParameter("facilityType");
        String date = request.getParameter("date");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");

        boolean isSearch
                = (date != null && !date.isEmpty())
                && (startTime != null && !startTime.isEmpty())
                && (endTime != null && !endTime.isEmpty());

        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps;

            if (!isSearch) {
                String sql = "SELECT f.*, "
                        + "(SELECT m.description FROM maintenance m "
                        + "WHERE m.maintenance_status <> 'Done' "
                        + "AND (m.facility_id = CAST(f.facility_id AS CHAR) OR m.facility_id = f.unit_name) "
                        + "ORDER BY m.maintenance_id DESC LIMIT 1) AS unavailable_reason "
                        + "FROM facility f "
                        + "ORDER BY f.facility_name, f.unit_name";

                ps = conn.prepareStatement(sql);
            } else {
                String sql = "SELECT f.*, NULL AS unavailable_reason FROM facility f "
                        + "WHERE (? = '' OR f.facility_name = ?) "
                        + "AND UPPER(f.status) = 'AVAILABLE' "
                        + "AND f.unit_name NOT IN ("
                        + "SELECT b.facility_name FROM booking b "
                        + "WHERE b.booking_date = ? "
                        + "AND b.status != 'REJECTED' "
                        + "AND (b.start_time < ? AND b.end_time > ?)) "
                        + "ORDER BY f.facility_name, f.unit_name";

                ps = conn.prepareStatement(sql);
                ps.setString(1, type == null ? "" : type);
                ps.setString(2, type == null ? "" : type);
                ps.setString(3, date);
                ps.setString(4, endTime);
                ps.setString(5, startTime);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Facility facility = new Facility();

                    facility.setFacilityId(rs.getInt("facility_id"));
                    facility.setFacilityName(rs.getString("facility_name"));
                    facility.setUnitName(rs.getString("unit_name"));
                    facility.setDescription(rs.getString("description"));
                    facility.setCapacity(rs.getInt("capacity"));
                    facility.setImageUrl(rs.getString("image_url"));
                    facility.setStatus(rs.getString("status"));
                    facility.setUnavailableReason(rs.getString("unavailable_reason"));

                    list.add(facility);
                }
            }

            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
        }

        request.setAttribute("facilities", list);
        request.setAttribute("mode", isSearch ? "search" : "all");
        request.getRequestDispatcher("facility.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Facility list and search";
    }
}
