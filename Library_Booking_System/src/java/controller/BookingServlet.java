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
import java.sql.Connection;
import java.time.LocalDate;

/**
 *
 * @author ASUS
 */
public class BookingServlet extends HttpServlet {

    // DATABASE CONFIG
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
            out.println("<title>Servlet BookingServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BookingServlet at " + request.getContextPath() + "</h1>");
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

     

    request.setCharacterEncoding("UTF-8");

    HttpSession session = request.getSession(false);

    if (session == null || session.getAttribute("matricNo") == null) {
        response.sendRedirect("login.jsp?error=session");
        return;
    }

    String matricNo = (String) session.getAttribute("matricNo");

    String facility = request.getParameter("facilityName");
    String date = request.getParameter("bookingDate");
    String start = request.getParameter("startTime");
    String end = request.getParameter("endTime");
    String purpose = request.getParameter("purpose");

    if (facility == null) {
        facility = "";
    }

    Connection conn = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // =========================
        // FIX 1: PAST DATE CHECK
        // =========================
        LocalDate bookingDate = LocalDate.parse(date);
        LocalDate today = LocalDate.now();

        if (bookingDate.isBefore(today)) {
            response.sendRedirect("booking.jsp?unit=" + facility + "&error=pastdate");
            return;
        }

        // =========================
        // FIX 2: SAME DAY PAST TIME CHECK
        // =========================
        if (bookingDate.isEqual(today)) {

            java.time.LocalTime nowTime = java.time.LocalTime.now();
            java.time.LocalTime startTime = java.time.LocalTime.parse(start);

            if (startTime.isBefore(nowTime)) {
                response.sendRedirect("booking.jsp?unit=" + facility + "&error=pasttime");
                return;
            }
        }

        // =========================
        // FIX 3: CORRECT OVERLAP CHECK
        // =========================
        String checkSql =
                "SELECT * FROM booking " +
                "WHERE facility_name = ? AND booking_date = ? " +
                "AND NOT (end_time <= ? OR start_time >= ?)";

        PreparedStatement checkPs = conn.prepareStatement(checkSql);
        checkPs.setString(1, facility);
        checkPs.setString(2, date);
        checkPs.setString(3, start);
        checkPs.setString(4, end);

        ResultSet rs = checkPs.executeQuery();

        if (rs.next()) {
            response.sendRedirect("booking.jsp?unit=" + facility + "&error=conflict");
            return;
        }

        // =========================
        // INSERT BOOKING
        // =========================
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

        response.sendRedirect("myBooking.jsp?unit=" + facility + "&success=1");

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("booking.jsp?unit=" + facility + "&error=db");

    } finally {
        try {
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
            }

        

        @Override
        public String getServletInfo () {
        return "Booking Servlet - handles facility reservation";
        }
    }
