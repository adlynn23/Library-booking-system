<%-- 
    Document   : header
    Created on : 24 Apr 2026, 11:34:54?pm
    Author     : DELL
--%>

<%@ page import="javax.servlet.http.HttpSession" %>
<%
    String userName = (String) session.getAttribute("userName");
    String role = (String) session.getAttribute("role");
    if (userName == null)
        userName = "User";
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg sticky-top">
            <div class="container">
                <a class="navbar-brand" href="dashboard.jsp">EduSpace.</a>

                <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav mx-auto">
                        <li class="nav-item"><a class="nav-link" href="dashboard.jsp">Home</a></li>

                        <%-- COMMON LINK: Facility --%>
                        <li class="nav-item"><a class="nav-link" href="viewFacility.jsp">Facility</a></li>

                        <% if ("Staff".equals(role)) { %>
                        <%-- STAFF VIEW --%>
                        <li class="nav-item"><a class="nav-link" href="manageBookings.jsp">Booking</a></li>
                        <li class="nav-item"><a class="nav-link" href="viewMaintenance.jsp">Maintenance</a></li>

                        <% } else { %>
                        <%-- STUDENT VIEW --%>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="booking.jsp" id="bookDrop" role="button" data-bs-toggle="dropdown">
                                Booking
                            </a>
                            <ul class="dropdown-menu border-0 shadow-sm">
                                <li><a class="dropdown-item" href="myBookings.jsp">My Booking</a></li>
                            </ul>
                        </li>
                        <li class="nav-item"><a class="nav-link" href="custCare.jsp">Customer Care</a></li>
<!--                        <li class="nav-item"><a class="nav-link" href="myProfile.jsp">My Profile</a></li>-->
                            <% }%>
                    </ul>
                    <div class="d-flex align-items-center">
                        <%-- PROFILE ICON LINK --%>
                        <a href="myProfile.jsp" class="profile-link d-flex align-items-center me-3 text-decoration-none">
                            <div class="profile-icon-circle">
                                <i class="fas fa-user text-primary"></i>
                            </div>
                        </a>

                    <div class="d-flex align-items-center">
                        <span class="text-muted me-3">Welcome, <strong><%= userName%></strong></span>
                        <a href="logout" class="btn btn-sm btn-outline-danger rounded-pill px-3">Logout</a>                </div>
                </div>
            </div>
        </nav>