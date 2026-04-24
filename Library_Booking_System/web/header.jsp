<%-- 
    Document   : header
    Created on : 24 Apr 2026, 11:34:54?pm
    Author     : DELL
--%>

<%@ page import="javax.servlet.http.HttpSession" %>
<%
    // Retrieve the user role and name from the session [cite: 993, 998]
    String userRole = (String) session.getAttribute("role"); 
    String userName = (String) session.getAttribute("userName");
    if (userName == null) userName = "Guest";
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="style.css"> [cite: 1001]
</head>
<body>
<header>
    <div class="header-container">
        <div class="logo-section">
            <img src="images/umt_logo.png" alt="UMT Logo" width="50">
            <h1>Library Booking Facility System</h1>
        </div>

        <nav>
            <ul class="nav-links">
                <li><a href="dashboard.jsp">Home</a></li>
                <li><a href="booking.jsp">Booking Module</a></li> [cite: 995]
                
                <%-- Logic for Role-Specific Functionalities [cite: 993, 994] --%>
                <% if ("Staff".equals(userRole)) { %>
                    <li><a href="systemManagement.jsp">System Management</a></li>
                    <li><a href="viewMaintenance.jsp">Booking Maintenance</a></li>
                <% } else if ("Student".equals(userRole)) { %>
                    <li><a href="myBookings.jsp">My Bookings</a></li>
                <% } %>

                <li><a href="profile.jsp">Profile Management</a></li> [cite: 995]
                <li><a href="logout.jsp">Logout (<%= userName %>)</a></li> [cite: 995]
            </ul>
        </nav>
    </div>
</header>
