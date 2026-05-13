package controller;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Corrected RegisterServlet
 *
 * @author ASUS
 */
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to the registration page
        response.sendRedirect("registration.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get Form Parameters
        String name = request.getParameter("fullName");
        String matric = request.getParameter("matricNo") != null ? request.getParameter("matricNo").trim() : "";
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String pass = request.getParameter("password");

        // 2. Auto-assign role based on first letter of Matric No
        String role = "Student";
        if (!matric.isEmpty()) {
            char prefix = Character.toUpperCase(matric.charAt(0));
            if (prefix == 'L') {
                role = "Lecturer";
            } else if (prefix == 'A') {
                role = "Admin";
            }
        }

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            // 3. Database Connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Ensure port 3307 and database name "librarydb" match your XAMPP/WAMP setup
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/librarydb", "root", "");

            // 4. SQL Statement (5 columns)
            String sql = "INSERT INTO users (matric_no,name,email,phone,password,role) VALUES (?, ?, ?,?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, matric);
            ps.setString(2, name);
            ps.setString(3, email);
            ps.setString(4, phone);
            ps.setString(5, pass);
            ps.setString(6, role);

            // 5. Execute Update
            int result = ps.executeUpdate();

            if (result > 0) {
                // Success: Redirect to login page with success message
                response.sendRedirect("login.jsp?status=success");
            } else {
                // Database didn't update but didn't crash
                response.sendRedirect("registration.jsp?error=failed");
            }

        } catch (SQLIntegrityConstraintViolationException e) {
            // Duplicate Primary Key (User already exists)
            response.sendRedirect("registration.jsp?error=exists");
        } catch (Exception e) {
            response.setContentType("text/html");
            e.printStackTrace(response.getWriter());
        } finally {
            // 6. Properly close resources
            try {
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Handles user registration and auto-role assignment";
    }
}
