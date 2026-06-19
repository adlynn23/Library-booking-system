/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CancelBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("matricNo") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String matricNo = (String) session.getAttribute("matricNo");

        String bookingId = request.getParameter("bookingId");

        Connection conn = null;
        PreparedStatement ps = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3307/librarydb",
                    "root",
                    "");

            String sql = "UPDATE booking "
                    + "SET status='Cancelled' "
                    + "WHERE booking_id=? "
                    + "AND matric_no=?";

            ps = conn.prepareStatement(sql);

            ps.setInt(1, Integer.parseInt(bookingId));
            ps.setString(2, matricNo);

            ps.executeUpdate();

            response.sendRedirect("myBooking.jsp");

        } catch (Exception e) {

            e.printStackTrace();

        } finally {

            try {

                if (ps != null) {
                    ps.close();
                }

                if (conn != null) {
                    conn.close();
                }

            } catch (Exception ex) {

                ex.printStackTrace();

            }

        }

    }

}