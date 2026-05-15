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
import java.sql.Connection;

/**
 *
 * @author ASUS
 */
public class CheckAvailabilityServlet extends HttpServlet {

    private final String dbURL = "jdbc:mysql://localhost:3307/librarydb";
    private final String dbUser = "root";
    private final String dbPass = "";

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
            out.println("<title>Servlet CheckAvailabilityServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckAvailabilityServlet at " + request.getContextPath() + "</h1>");
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

        response.setContentType("application/json");

        String facility = request.getParameter("facility");
        String date = request.getParameter("date");
        String start = request.getParameter("start");
        String end = request.getParameter("end");

        boolean available = true;

        Connection conn = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            String sql =
                    "SELECT * FROM booking " +
                    "WHERE facility_name = ? " +
                    "AND booking_date = ? " +
                    "AND status != 'REJECTED' " +
                    "AND NOT (end_time <= ? OR start_time >= ?)";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, facility);
            ps.setString(2, date);
            ps.setString(3, start);
            ps.setString(4, end);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                available = false;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        PrintWriter out = response.getWriter();

        out.print("{\"available\":" + available + "}");

        out.flush();

        try {
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
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
