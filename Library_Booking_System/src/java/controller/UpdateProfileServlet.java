package controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Connection;

/**
 *
 * @author DELL
 */
public class UpdateProfileServlet extends HttpServlet {

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
            out.println("<title>Servlet UpdateProfileServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateProfileServlet at " + request.getContextPath() + "</h1>");
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

    HttpSession session = request.getSession(false);

    if (session == null || session.getAttribute("matricNo") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String matricNo = (String) session.getAttribute("matricNo");

    // Get form data
    String fullName = request.getParameter("fullName");
    String phone = request.getParameter("phone");

    Connection conn = null;
    PreparedStatement ps = null;

    try {

        Class.forName("com.mysql.cj.jdbc.Driver");

        conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3307/librarydb",
                "root",
                ""
        );

        // UPDATE query
        String sql = "UPDATE users SET name = ?, phone = ? WHERE matric_no = ?";

        ps = conn.prepareStatement(sql);

        ps.setString(1, fullName);
        ps.setString(2, phone);
        ps.setString(3, matricNo);

        int result = ps.executeUpdate();

        if (result > 0) {

            // Update session
            session.setAttribute("userName", fullName);
            session.setAttribute("userPhone", phone);

            response.sendRedirect("myProfile.jsp?status=success");

        } else {

            response.sendRedirect("myProfile.jsp?status=failed");
        }

    } catch (Exception e) {

        e.printStackTrace();
        response.sendRedirect("myProfile.jsp?status=error");

    } finally {

        try {

            if (ps != null) {
                ps.close();
            }

            if (conn != null) {
                conn.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
}
