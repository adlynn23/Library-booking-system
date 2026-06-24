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
import util.DBConnection;
import java.sql.Connection;       // Represents the connection session with the database
import java.sql.PreparedStatement;
import java.util.Map;           // Interface for key-value pair structures
import java.util.HashMap;
import java.util.List;          // Interface for an ordered collection
import java.sql.ResultSet;      // Table of data representing a database result set
import java.util.ArrayList;
import model.Facility;

/**
 *
 * @author ASUS
 */
public class AvailabilityServlet extends HttpServlet {

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
            out.println("<title>Servlet Availability</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Availability at " + request.getContextPath() + "</h1>");
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

    List<Facility> facilities = new ArrayList<>();
    Map<String, List<String>> bookedMap = new HashMap<>();

    String type = request.getParameter("facilityType");
    String date = request.getParameter("date");

    if (date == null || date.isEmpty()) {
        response.sendRedirect("facility.jsp");
        return;
    }

    int startHour = 8;
    int endHour = 18;

    java.sql.Date sqlDate = java.sql.Date.valueOf(date);
    java.util.Calendar cal = java.util.Calendar.getInstance();
    cal.setTime(sqlDate);

    int day = cal.get(java.util.Calendar.DAY_OF_WEEK);

    if (day >= java.util.Calendar.SUNDAY && day <= java.util.Calendar.WEDNESDAY) {
        endHour = 22;
    }

    try (Connection conn = DBConnection.getConnection()) {

        PreparedStatement facilityPs;

        if (type == null || type.isEmpty() || type.equals("All Facilities")) {

            String facilitySql =
                    "SELECT * FROM facility " +
                    "WHERE status = 'AVAILABLE' " +
                    "ORDER BY facility_name, unit_name";

            facilityPs = conn.prepareStatement(facilitySql);

        } else {

            String facilitySql =
                    "SELECT * FROM facility " +
                    "WHERE facility_name = ? AND status = 'AVAILABLE' " +
                    "ORDER BY unit_name";

            facilityPs = conn.prepareStatement(facilitySql);
            facilityPs.setString(1, type);
        }

        ResultSet facilityRs = facilityPs.executeQuery();

        while (facilityRs.next()) {

            Facility f = new Facility();

            f.setFacilityId(facilityRs.getInt("facility_id"));
            f.setFacilityName(facilityRs.getString("facility_name"));
            f.setUnitName(facilityRs.getString("unit_name"));
            f.setDescription(facilityRs.getString("description"));
            f.setCapacity(facilityRs.getInt("capacity"));
            f.setStatus(facilityRs.getString("status"));

            facilities.add(f);
        }

        for (Facility f : facilities) {

            String bookingSql =
                    "SELECT facility_name, start_time, end_time " +
                    "FROM booking " +
                    "WHERE booking_date = ? " +
                    "AND facility_name = ? " +
                    "AND status <> 'REJECTED'";

            PreparedStatement bookingPs = conn.prepareStatement(bookingSql);

            bookingPs.setString(1, date);
            bookingPs.setString(2, f.getUnitName());

            ResultSet bookingRs = bookingPs.executeQuery();

            while (bookingRs.next()) {

                String facilityName = bookingRs.getString("facility_name");

                String start = bookingRs.getString("start_time").substring(0, 5);
                String end = bookingRs.getString("end_time").substring(0, 5);

                int bookingStartHour = Integer.parseInt(start.split(":")[0]);
                int bookingEndHour = Integer.parseInt(end.split(":")[0]);

                for (int h = bookingStartHour; h < bookingEndHour; h++) {

                    String bookedTime =
                            (h < 10 ? "0" + h : String.valueOf(h)) + ":00";

                    bookedMap
                            .computeIfAbsent(facilityName, k -> new ArrayList<>())
                            .add(bookedTime);
                }
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    request.setAttribute("facilities", facilities);
    request.setAttribute("bookedMap", bookedMap);
    request.setAttribute("facilityType", type);
    request.setAttribute("date", date);
    request.setAttribute("startHour", startHour);
    request.setAttribute("endHour", endHour);

    request.getRequestDispatcher("availability.jsp").forward(request, response);
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
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
