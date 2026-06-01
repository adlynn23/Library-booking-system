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
import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.net.URLEncoder;
import java.time.LocalTime;

public class BookingServlet extends HttpServlet {

    // DATABASE CONFIG
    private final String dbURL = "jdbc:mysql://localhost:3307/librarydb";
    private final String dbUser = "root";
    private final String dbPass = "";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet BookingServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BookingServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");

        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        processRequest(request, response);

    }

      @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("matricNo") == null) {
            response.sendRedirect("login.jsp?error=session");
            return;
        }

        String matricNo = (String) session.getAttribute("matricNo");

        String facility = request.getParameter("unit");
        String date = request.getParameter("bookingDate");
        String start = request.getParameter("startTime");
        String end = request.getParameter("endTime");
        String purpose = request.getParameter("purpose");

        if (facility == null) facility = "";

        String safeFacility = URLEncoder.encode(facility, "UTF-8");

        Connection conn = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            // ===================== DATE =====================
            LocalDate bookingDate = LocalDate.parse(date);
            LocalDate today = LocalDate.now();

            if (bookingDate.isBefore(today)) {
                response.sendRedirect("booking.jsp?unit=" + safeFacility + "&error=pastdate");
                return;
            }

            // ===================== TIME =====================
            LocalTime startTime = LocalTime.parse(start);
            LocalTime endTime = LocalTime.parse(end);

            if (!endTime.isAfter(startTime)) {
                response.sendRedirect("booking.jsp?unit=" + safeFacility + "&error=invalidtime");
                return;
            }

            // max 2 hours
            long duration = java.time.Duration.between(startTime, endTime).toMinutes();
            if (duration > 120) {
                response.sendRedirect("booking.jsp?unit=" + safeFacility + "&error=maxduration");
                return;
            }

            // ===================== SLOT CONFLICT FIXED =====================
            String checkSql =
                    "SELECT * FROM booking " +
                    "WHERE facility_name = ? " +
                    "AND booking_date = ? " +
                    "AND status != 'REJECTED' " +
                    "AND NOT (end_time <= ? OR start_time >= ?)";

            PreparedStatement checkPs = conn.prepareStatement(checkSql);
            checkPs.setString(1, facility);
            checkPs.setString(2, date);
            checkPs.setString(3, start);
            checkPs.setString(4, end);

            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                response.sendRedirect("booking.jsp?unit=" + safeFacility + "&error=conflict");
                return;
            }

            // ===================== INSERT BOOKING =====================
            String insertSql =
                    "INSERT INTO booking " +
                    "(matric_no, facility_name, booking_date, start_time, end_time, purpose, status) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = conn.prepareStatement(insertSql);
            ps.setString(1, matricNo);
            ps.setString(2, facility);
            ps.setString(3, date);
            ps.setString(4, start);
            ps.setString(5, end);
            ps.setString(6, purpose);
            ps.setString(7, "PENDING");

            ps.executeUpdate();

            // ===================== NOTIFICATION =====================
            String notifySql =
                    "INSERT INTO notification (user_id, message, status) VALUES (?, ?, ?)";

            PreparedStatement nps = conn.prepareStatement(notifySql);
            nps.setString(1, "ADMIN");
            nps.setString(2, "New booking from " + matricNo + " for " + facility);
            nps.setString(3, "UNREAD");

            nps.executeUpdate();

            // ===================== SUCCESS =====================
            response.sendRedirect("myBooking.jsp?success=1");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("booking.jsp?unit=" + safeFacility + "&error=db");

        } finally {
            try {
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }


    @Override
    public String getServletInfo() {

        return "Booking Servlet - handles facility reservation";

    }
}
