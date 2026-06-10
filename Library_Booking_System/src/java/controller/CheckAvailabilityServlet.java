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

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.DayOfWeek;

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

        PrintWriter out = response.getWriter();

        Connection conn = null;

        try {

            String facility =
                    request.getParameter("facility");

            String date =
                    request.getParameter("date");

            String start =
                    request.getParameter("start");

            String end =
                    request.getParameter("end");

            // ==========================
            // NULL CHECK
            // ==========================
            if (facility == null || date == null
                    || start == null || end == null
                    || facility.isEmpty()
                    || date.isEmpty()
                    || start.isEmpty()
                    || end.isEmpty()) {

                out.print("{\"available\":false}");
                return;
            }

            // ==========================
            // DATE + TIME
            // ==========================
            LocalDate bookingDate =
                    LocalDate.parse(date);

            LocalTime startTime =
                    LocalTime.parse(start);

            LocalTime endTime =
                    LocalTime.parse(end);

            LocalDateTime now =
                    LocalDateTime.now();

            LocalDateTime bookingDateTime =
                    LocalDateTime.of(
                            bookingDate,
                            startTime
                    );

            if (!endTime.isAfter(startTime)
                    || java.time.Duration.between(startTime, endTime).toMinutes() > 120) {

                out.print("{\"available\":false}");
                return;
            }

            // ==========================
            // PAST TIME
            // ==========================
            if (bookingDateTime.isBefore(now)) {

                out.print("{\"available\":false}");
                return;
            }

            // ==========================
            // 1 HOUR EARLY RULE
            // ==========================
            if (bookingDateTime.isBefore(now.plusHours(1))) {

                out.print("{\"available\":false}");
                return;
            }

            // ==========================
            // OPERATING HOURS
            // ==========================
            DayOfWeek day =
                    bookingDate.getDayOfWeek();

            boolean weekend =
                    day == DayOfWeek.SATURDAY
                    || day == DayOfWeek.SUNDAY;

            int startHour =
                    startTime.getHour();

            int endHour =
                    endTime.getHour();

            if (!weekend) {

                if (startHour < 8 || endHour > 22) {

                    out.print("{\"available\":false}");
                    return;
                }

            } else {

                if (startHour < 9 || endHour > 18) {

                    out.print("{\"available\":false}");
                    return;
                }

            }

            // ==========================
            // DB CONNECTION
            // ==========================
            Class.forName("com.mysql.cj.jdbc.Driver");

            conn = DriverManager.getConnection(
                    dbURL,
                    dbUser,
                    dbPass
            );

            // ==========================
            // CHECK CONFLICT
            // ==========================
            String sql =
                    "SELECT * FROM booking "
                    + "WHERE facility_name = ? "
                    + "AND booking_date = ? "
                    + "AND status != 'REJECTED' "
                    + "AND NOT "
                    + "(end_time <= ? "
                    + "OR start_time >= ?)";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setString(1, facility);
            ps.setString(2, date);
            ps.setString(3, start);
            ps.setString(4, end);

            ResultSet rs =
                    ps.executeQuery();

            boolean available =
                    !rs.next();

            out.print(
                    "{\"available\":"
                    + available
                    + "}"
            );

        }

        catch (Exception e) {

            e.printStackTrace();

            out.print("{\"available\":false}");

        }

        finally {

            try {

                if (conn != null) {

                    conn.close();

                }

            }

            catch (Exception e) {

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
