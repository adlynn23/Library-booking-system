package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import util.DBConnection;

@WebServlet(name = "Maintenance_Servlet", urlPatterns = {"/Maintenance_Servlet", "/UpdateStatusServlet"})
public class Maintenance_Servlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String facilityId = request.getParameter("facilityId");
        String description = request.getParameter("description");
        String priority = request.getParameter("priority");
        String category = request.getParameter("category");
        String expectedCompletion = request.getParameter("expectedCompletion");

        try {
            Connection con = DBConnection.getConnection();
            con.setAutoCommit(false);

            try {
                String sql = "INSERT INTO maintenance (facility_id, description, maintenance_status, start_date, priority, category, expected_completion) "
                           + "VALUES (?, ?, 'In Process', CURRENT_DATE, ?, ?, ?)";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, facilityId);
                ps.setString(2, description);
                ps.setString(3, priority);
                ps.setString(4, category);

                if (expectedCompletion == null || expectedCompletion.trim().isEmpty()) {
                    ps.setNull(5, java.sql.Types.DATE);
                } else {
                    ps.setString(5, expectedCompletion);
                }

                ps.executeUpdate();
                ps.close();

                updateFacilityStatus(con, facilityId, "NOT AVAILABLE");

                con.commit();
            } catch (Exception e) {
                con.rollback();
                throw e;
            } finally {
                con.close();
            }

            response.sendRedirect("viewMaintenance.jsp?maintenanceSuccess=true");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("Database Error: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String maintenanceId = request.getParameter("id");

        try {
            Connection con = DBConnection.getConnection();
            con.setAutoCommit(false);

            try {
                String facilityId = null;
                String findSql = "SELECT facility_id FROM maintenance WHERE maintenance_id = ?";
                PreparedStatement findPs = con.prepareStatement(findSql);
                findPs.setString(1, maintenanceId);
                ResultSet rs = findPs.executeQuery();

                if (rs.next()) {
                    facilityId = rs.getString("facility_id");
                }

                rs.close();
                findPs.close();

                String sql = "UPDATE maintenance SET maintenance_status = 'Done', end_date = CURRENT_DATE WHERE maintenance_id = ?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, maintenanceId);
                ps.executeUpdate();
                ps.close();

                if (facilityId != null) {
                    updateFacilityStatus(con, facilityId, "AVAILABLE");
                }

                con.commit();
            } catch (Exception e) {
                con.rollback();
                throw e;
            } finally {
                con.close();
            }

            response.sendRedirect("viewMaintenance.jsp?doneSuccess=true");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("Database Error: " + e.getMessage());
        }
    }

    private void updateFacilityStatus(Connection con, String facilityId, String status) throws Exception {
        String sql = isInteger(facilityId)
                ? "UPDATE facility SET status = ? WHERE facility_id = ?"
                : "UPDATE facility SET status = ? WHERE unit_name = ?";

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, status);
        ps.setString(2, facilityId);
        ps.executeUpdate();
        ps.close();
    }

    private boolean isInteger(String value) {
        if (value == null || value.trim().isEmpty()) {
            return false;
        }
        try {
            Integer.parseInt(value);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }
}
