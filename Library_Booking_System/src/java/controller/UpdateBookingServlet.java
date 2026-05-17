/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

/**
 *
 * @author ASUS
 */
public class UpdateBookingServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateBookingServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateBookingServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int bookingId = Integer.parseInt(request.getParameter("booking_id"));
        String status = request.getParameter("status");
        String notes = request.getParameter("admin_notes");

        Connection conn = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3307/librarydb",
                    "root",
                    ""
            );

            // ==========================
            // GET BOOKING INFO (ONLY ONCE)
            // ==========================
            String getSql = "SELECT matric_no, facility_name FROM booking WHERE booking_id=?";
            PreparedStatement getPs = conn.prepareStatement(getSql);
            getPs.setInt(1, bookingId);

            ResultSet rs = getPs.executeQuery();

            String matric = "";
            String facility = "";

            if (rs.next()) {
                matric = rs.getString("matric_no");
                facility = rs.getString("facility_name");
            }

            // ==========================
            // UPDATE BOOKING
            // ==========================
            String updateSql
                    = "UPDATE booking SET status=?, admin_notes=? WHERE booking_id=?";

            PreparedStatement ps = conn.prepareStatement(updateSql);
            ps.setString(1, status);
            ps.setString(2, notes);
            ps.setInt(3, bookingId);
            ps.executeUpdate();

            // ==========================
            // CREATE USER NOTIFICATION
            // ==========================
            String message;

            if ("APPROVED".equals(status)) {
                message = "Your booking for " + facility + " has been APPROVED.";
            } else if ("REJECTED".equals(status)) {
                message = "Your booking for " + facility + " has been REJECTED.";
            } else {
                message = "Your booking is under review.";
            }

            String notifSql
                    = "INSERT INTO notification (user_id, message, status) VALUES (?, ?, 'UNREAD')";

            PreparedStatement notifPs = conn.prepareStatement(notifSql);
            notifPs.setString(1, matric); // ✅ FIXED (was matricNo)
            notifPs.setString(2, message);
            notifPs.executeUpdate();

            // ==========================
            // CLEAN ADMIN NOTIFICATION (OPTIONAL)
            // ==========================
            String cleanSql
                    = "UPDATE notification SET status='READ' WHERE user_id='ADMIN' AND message LIKE ?";

            PreparedStatement cleanPs = conn.prepareStatement(cleanSql);
            cleanPs.setString(1, "%booking request from " + matric + "%");
            cleanPs.executeUpdate();

            response.sendRedirect("adminBooking.jsp?success=1");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
