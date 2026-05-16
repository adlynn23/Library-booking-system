<%-- 
    Document   : adminBooking
    Created on : 16 May 2026, 5:25:41 pm
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
        <style>select{
    padding:8px;
    border-radius:10px;
    border:1px solid #ddd;
    margin-right:5px;
}

input[type="text"]{
    padding:8px;
    border-radius:10px;
    border:1px solid #ddd;
    width:180px;
}

form{
    display:flex;
    gap:8px;
    align-items:center;
}

button{
    padding:8px 12px;
    border:none;
    border-radius:10px;
    background:#163832;
    color:white;
    font-weight:600;
    cursor:pointer;
}

button:hover{
    opacity:0.9;
}</style>
                <jsp:include page="admin_header.jsp" />

    </head>
    <body>
<table class="modern-table">

<thead>
<tr>
    <th>Student</th>
    <th>Facility</th>
    <th>Date</th>
    <th>Time</th>
    <th>Purpose</th>
    <th>Status</th>
    <th>Notes</th>
    <th>Action</th>
</tr>
</thead>

<tbody>

<%
Connection conn = DriverManager.getConnection(
    "jdbc:mysql://localhost:3307/librarydb", "root", "");

String sql = "SELECT * FROM booking ORDER BY booking_date DESC";
PreparedStatement ps = conn.prepareStatement(sql);
ResultSet rs = ps.executeQuery();

while(rs.next()){
%>

<tr>
    <td><%= rs.getString("matric_no") %></td>
    <td><%= rs.getString("facility_name") %></td>
    <td><%= rs.getString("booking_date") %></td>
    <td><%= rs.getString("start_time") %> - <%= rs.getString("end_time") %></td>
    <td><%= rs.getString("purpose") %></td>

    <td>
        <span class="status-badge">
            <%= rs.getString("status") %>
        </span>
    </td>

    <td>
        <%= rs.getString("admin_notes") == null ? "-" : rs.getString("admin_notes") %>
    </td>

    <td>

        <form action="UpdateBookingServlet" method="post">

            <input type="hidden" name="booking_id" value="<%= rs.getInt("booking_id") %>">

            <select name="status">
                <option>Pending</option>
                <option>Approved</option>
                <option>Rejected</option>
            </select>

            <input type="text" name="admin_notes"
                   placeholder="Add notes (key pickup, rules...)">

            <button type="submit" class="btn-submit">
                Update
            </button>

        </form>

    </td>
</tr>

<%
}
conn.close();
%>

</tbody>
</table>    </body>
</html>
