<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>

<%
    HttpSession sessionUser = request.getSession(false);

    if (sessionUser == null || sessionUser.getAttribute("matricNo") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String matricNo = (String) sessionUser.getAttribute("matricNo");
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<div class="container mt-5">

    <h2>My Bookings</h2>

    <table class="table table-bordered mt-3">

        <tr>
            <th>Facility</th>
            <th>Date</th>
            <th>Time</th>
            <th>Purpose</th>
            <th>Status</th>
        </tr>

        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3307/librarydb", "root", "");

                String sql =
                    "SELECT * FROM booking WHERE matric_no=? ORDER BY booking_date DESC";

                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, matricNo);

                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
        %>

        <tr>
            <td><%= rs.getString("facility_name") %></td>
            <td><%= rs.getString("booking_date") %></td>
            <td><%= rs.getString("start_time") %> - <%= rs.getString("end_time") %></td>
            <td><%= rs.getString("purpose") %></td>
            <td>
                <span class="badge bg-info">
                    <%= rs.getString("status") %>
                </span>
            </td>
        </tr>

        <%
                }

                conn.close();

            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        %>

    </table>

</div>

</body>
</html>