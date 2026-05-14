package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Date;
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
            String sql = "INSERT INTO maintenance (facility_id, description, maintenance_status, start_date) VALUES (?, ?, 'In Process', CURRENT_DATE)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, facilityId);
            ps.setString(2, description);
            
            ps.executeUpdate();
            con.close();
            
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
            // Updates status to Done and logs the current date as the end_date
            String sql = "UPDATE maintenance SET maintenance_status = 'Done', end_date = CURRENT_DATE WHERE maintenance_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, maintenanceId);
            
            ps.executeUpdate();
            con.close();
            
            // Redirect back to dashboard to see updated status
            response.sendRedirect("viewMaintenance.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("Database Error: " + e.getMessage());
        }
    }
}