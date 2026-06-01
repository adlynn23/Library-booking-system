/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.sql.Connection;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import java.util.*;
import model.Facility;
import dao.FacilityDAO;

/**
 *
 * @author ASUS
 */
public class FacilityServlet extends HttpServlet {

    FacilityDAO dao = new FacilityDAO();

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
            out.println("<title>Servlet FacilityServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FacilityServlet at " + request.getContextPath() + "</h1>");
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

        List<Facility> list = new ArrayList<>();

        String type = request.getParameter("facilityType");
        String date = request.getParameter("date");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");

        System.out.println("Type = " + type);
        System.out.println("Date = " + date);
        System.out.println("Start = " + startTime);
        System.out.println("End = " + endTime);
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3307/librarydb", "root", "");

            PreparedStatement ps;

            // 🟢 CASE 1: FIRST LOAD (SHOW ALL)
            if (type == null || type.isEmpty()) {

                String sql = "SELECT * FROM facility";
                ps = conn.prepareStatement(sql);

            } // 🔵 CASE 2: SEARCH (AVAILABLE ONLY)
            else {

                String sql
                        = "SELECT * FROM facility f "
                        + "WHERE f.facility_name = ? "
                        + "AND f.facility_name NOT IN ("
                        + "SELECT b.facility_name FROM booking b "
                        + "WHERE b.booking_date = ? "
                        + "AND (b.start_time < ? AND b.end_time > ?))";
                ps = conn.prepareStatement(sql);

                ps.setString(1, type);
                ps.setString(2, date);
                ps.setString(3, endTime);
                ps.setString(4, startTime);
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Facility f = new Facility();

                f.setFacilityId(rs.getInt("facility_id"));
                f.setFacilityName(rs.getString("facility_name"));
                f.setUnitName(rs.getString("unit_name"));
                f.setDescription(rs.getString("description"));
                f.setCapacity(rs.getInt("capacity"));
                f.setImageUrl(rs.getString("image_url"));
                f.setStatus(rs.getString("status"));

                list.add(f);
            }

            request.setAttribute("facilities", list);

// FIRST LOAD
            boolean isSearch
                    = (date != null && !date.isEmpty())
                    && (startTime != null && !startTime.isEmpty())
                    && (endTime != null && !endTime.isEmpty());
            
            if (isSearch) {
                request.setAttribute("mode", "search");
            } else {
                request.setAttribute("mode", "all");
            }

            request.getRequestDispatcher("facility.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();

            request.setAttribute("error", e.getMessage());
            request.setAttribute("facilities", new ArrayList<>());
            request.setAttribute("mode", "all");

            request.setAttribute("facilities", list);

            boolean isSearch
                    = (type != null && !type.isEmpty())
                    || (date != null && !date.isEmpty())
                    || (startTime != null && !startTime.isEmpty())
                    || (endTime != null && !endTime.isEmpty());

            if (isSearch) {
                request.setAttribute("mode", "search");
            } else {
                request.setAttribute("mode", "all");
            }

            request.getRequestDispatcher("facility.jsp")
                    .forward(request, response);
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
