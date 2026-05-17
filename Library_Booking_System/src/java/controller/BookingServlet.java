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

        String matricNo
                = (String) session.getAttribute("matricNo");

        String facility
                = request.getParameter("facilityName");

        String date
                = request.getParameter("bookingDate");

        String start
                = request.getParameter("startTime");

        String end
                = request.getParameter("endTime");

        String purpose
                = request.getParameter("purpose");

        Connection conn = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            conn = DriverManager.getConnection(
                    dbURL,
                    dbUser,
                    dbPass
            );

            // ==========================
            // DATE VALIDATION
            // ==========================
            LocalDate bookingDate
                    = LocalDate.parse(date);

            LocalDate today
                    = LocalDate.now();

            if (bookingDate.isBefore(today)) {

                response.sendRedirect(
                        "booking.jsp?unit="
                        + facility
                        + "&error=pastdate"
                );

                return;
            }

            // ==========================
            // TIME VALIDATION
            // ==========================
            java.time.LocalTime startTime
                    = java.time.LocalTime.parse(start);

            java.time.LocalTime endTime
                    = java.time.LocalTime.parse(end);

            // END BEFORE START
            if (!endTime.isAfter(startTime)) {

                response.sendRedirect(
                        "booking.jsp?unit="
                        + facility
                        + "&error=invalidtime"
                );

                return;
            }

            // ==========================
            // MAX 2 HOURS
            // ==========================
            long duration
                    = java.time.Duration
                            .between(startTime, endTime)
                            .toHours();

            if (duration > 2) {

                response.sendRedirect(
                        "booking.jsp?unit="
                        + facility
                        + "&error=maxduration"
                );

                return;
            }

            // ==========================
            // CURRENT DATE & TIME
            // ==========================
            java.time.LocalDate currentDate
                    = java.time.LocalDate.now();

            java.time.LocalTime currentTime
                    = java.time.LocalTime.now();

            java.time.LocalDateTime now
                    = java.time.LocalDateTime.of(
                            currentDate,
                            currentTime
                    );

            java.time.LocalDateTime bookingDateTime
                    = java.time.LocalDateTime.of(
                            bookingDate,
                            startTime
                    );

            // ==========================
            // PAST TIME CHECK
            // ==========================
            if (bookingDate.isEqual(currentDate)) {

                if (startTime.isBefore(currentTime)) {

                    response.sendRedirect(
                            "booking.jsp?unit="
                            + facility
                            + "&error=pasttime"
                    );

                    return;
                }
            }

            // ==========================
            // 1 HOUR EARLIER RULE
            // ==========================
            long minutes
                    = java.time.Duration
                            .between(now, bookingDateTime)
                            .toMinutes();

            if (minutes < 60) {

                response.sendRedirect(
                        "booking.jsp?unit="
                        + facility
                        + "&error=onehour"
                );

                return;
            }

            // ==========================
            // FINAL PAST CHECK
            // ==========================
            if (bookingDateTime.isBefore(now)) {

                response.sendRedirect(
                        "booking.jsp?unit="
                        + facility
                        + "&error=pasttime"
                );

                return;
            }

            // ==========================
            // OPERATING HOURS
            // ==========================
            java.time.DayOfWeek day
                    = bookingDate.getDayOfWeek();

            int startHour = startTime.getHour();

            int endHour = endTime.getHour();

            boolean weekend
                    = day == java.time.DayOfWeek.SATURDAY
                    || day == java.time.DayOfWeek.SUNDAY;

            if (!weekend) {

                if (startHour < 8 || endHour > 22) {

                    response.sendRedirect(
                            "booking.jsp?unit="
                            + facility
                            + "&error=operatinghours"
                    );

                    return;
                }

            } else {

                if (startHour < 9 || endHour > 18) {

                    response.sendRedirect(
                            "booking.jsp?unit="
                            + facility
                            + "&error=operatinghours"
                    );

                    return;
                }

            }

            // ==========================
            // CHECK SLOT CONFLICT
            // ==========================
            String checkSql
                    = "SELECT * FROM booking "
                    + "WHERE facility_name = ? "
                    + "AND booking_date = ? "
                    + "AND status != 'REJECTED' "
                    + "AND NOT "
                    + "(end_time <= ? "
                    + "OR start_time >= ?)";

            PreparedStatement checkPs
                    = conn.prepareStatement(checkSql);

            checkPs.setString(1, facility);
            checkPs.setString(2, date);
            checkPs.setString(3, start);
            checkPs.setString(4, end);

            ResultSet rs
                    = checkPs.executeQuery();

            if (rs.next()) {

                response.sendRedirect(
                        "booking.jsp?unit="
                        + facility
                        + "&error=conflict"
                );

                return;
            }

            // ==========================
            // INSERT BOOKING
            // ==========================
            String insertSql
                    = "INSERT INTO booking "
                    + "(matric_no, facility_name, "
                    + "booking_date, start_time, "
                    + "end_time, purpose, status) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement ps
                    = conn.prepareStatement(insertSql);

            ps.setString(1, matricNo);
            ps.setString(2, facility);
            ps.setString(3, date);
            ps.setString(4, start);
            ps.setString(5, end);
            ps.setString(6, purpose);

            // DEFAULT STATUS
            ps.setString(7, "PENDING");

            ps.executeUpdate();

            // ==========================
// INSERT ADMIN NOTIFICATION
// ==========================
            String notificationSql
                    = "INSERT INTO notification (user_id, message, status) VALUES (?, ?, ?)";

            PreparedStatement notificationPs
                    = conn.prepareStatement(notificationSql);

            notificationPs.setString(1, "ADMIN");
            notificationPs.setString(
                    2,
                    "You have booking request from " + matricNo
            );
            notificationPs.setString(3, "UNREAD");

            notificationPs.executeUpdate();

            // ==========================
            // REDIRECT
            // ==========================
            response.sendRedirect(
                    "myBooking.jsp?success=1"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "booking.jsp?unit="
                    + facility
                    + "&error=db"
            );

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

    @Override
    public String getServletInfo() {

        return "Booking Servlet - handles facility reservation";

    }
}
