package controller;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import model.Facility;
import util.DBConnection;
import java.sql.ResultSet;

public class FacilityServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String type = request.getParameter("facilityType");

        List<Facility> list = new ArrayList<>();
        Map<String, List<String>> bookedMap = new HashMap<>();

        try (Connection conn = DBConnection.getConnection()) {

            // =========================
            // FACILITY DATA
            // =========================
            String sql = "SELECT * FROM facility";

            if (type != null && !type.trim().isEmpty()) {
                sql += " WHERE facility_name = ?";
            }

            PreparedStatement ps = conn.prepareStatement(sql);

            if (type != null && !type.trim().isEmpty()) {
                ps.setString(1, type);
            }

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

            // =========================
            // BOOKING DATA
            // =========================
            String sql2
                    = "SELECT unit_name, start_time "
                    + "FROM booking "
                    + "WHERE booking_date = CURRENT_DATE";

            PreparedStatement ps2 = conn.prepareStatement(sql2);
            ResultSet rs2 = ps2.executeQuery();

            while (rs2.next()) {

                String unitName = rs2.getString("unit_name");
                String time = rs2.getString("start_time").substring(0, 5);

                bookedMap
                        .computeIfAbsent(unitName,
                                k -> new ArrayList<>())
                        .add(time);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("facilities", list);
        request.setAttribute("bookedMap", bookedMap);

        request.getRequestDispatcher("facility.jsp")
                .forward(request, response);
    }
}
