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

    // 1. Handles KEY IN NEW REPAIR (Form Submission)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String facilityId = request.getParameter("facilityId");
        String description = request.getParameter("description");

        try {
            Connection con = DBConnection.getConnection();
            con.setAutoCommit(false);

            try {
                String sql = "INSERT INTO maintenance (facility_id, description, maintenance_status, start_date) VALUES (?, ?, 'In Process', CURRENT_DATE)";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, facilityId);
                ps.setString(2, description);
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
            
            // Redirect back to refresh the dashboard view instantly
            response.sendRedirect("viewMaintenance.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("Database Error: " + e.getMessage());
        }
    }

    // 2. Handles MARK DONE (Action Link Click)
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

                // Updates status to Done and logs the current date as the end_date
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
            
            // Redirect back to dashboard to see updated status
            response.sendRedirect("viewMaintenance.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("Database Error: " + e.getMessage());
        }
    }

    private void updateFacilityStatus(Connection con, String facilityId, String status)
            throws Exception {

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
