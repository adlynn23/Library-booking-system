<%-- 
    Document   : header
    Created on : 27 Apr 2026, 4:14:32 pm
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="style.css">

<%
    // Ambil role daripada session yang ditetapkan semasa login
    String role = (String) session.getAttribute("role");

    // Elakkan ralat null jika pengguna belum login
    if (role == null) {
        role = "member"; // Default atau redirect ke login
    }
%>
<%
    // Ensure this is at the top of headerL.jsp to check login status [cite: 1472]
    String userSession = (String) session.getAttribute("userName");
%>

<div class="d-flex align-items-center">
    <% if (userSession == null) { %>
        <a href="login.jsp" class="btn btn-outline-primary btn-sm px-4 rounded-pill fw-bold">
            Sign In
        </a>
    <% } else { %>
        <div class="d-flex align-items-center">
            <span class="me-3 small text-muted d-none d-md-inline">Hi, <%= userSession %></span>
            
            <a href="myProfile.jsp" class="profile-link me-3">
                <div class="profile-icon-circle shadow-sm">
                    <i class="fas fa-user text-primary"></i>
                </div>
            </a>

            <a href="LogoutServlet" class="btn btn-danger btn-sm px-3 rounded-pill">
                Log Out
            </a>
        </div>
    <% } %>
</div>

<nav class="navbar navbar-expand-lg bg-white shadow-sm py-3">
    <div class="container"> <%-- Gunakan container (bukan container-fluid) supaya lebih kemas di tengah --%>

        <%-- BUANG 'text-primary' supaya tidak jadi biru --%>
        <a class="navbar-brand" href="dashboard.jsp">
            eduspace<span>.</span>
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">Home</a>
                </li>
                <li>
                    <a class="nav-link px-3" href="#">Facility</a>
                </li>
                <%
                    // Pastikan session userName diambil di bahagian atas header.jsp
                    String userSession = (String) session.getAttribute("userName");
                %>

                <li class="nav-item">
                    <% if (userSession == null) { %>
                    <a class="nav-link px-3" href="javascript:void(0);" onclick="showLoginAlert()">MyBooking</a>
                    <% } else { %>
                    <a class="nav-link px-3" href="booking.jsp">MyBooking</a>
                    <% } %>
                </li>
                <%-- LOGIK PERBEZAAN NAVIGASI DI SINI --%>
                <% if ("Staff".equalsIgnoreCase(role) || "Admin".equalsIgnoreCase(role)) { %>
                <%-- Menu untuk Admin/Librarian --%>
                <li class="nav-item">
                    <a class="nav-link" href="viewMaintenance.jsp">Maintenance</a>
                </li>
                <% } else { %>
                <%-- Menu untuk Student --%>
                <li class="nav-item">
                    <a class="nav-link" href="custCare.jsp">CustomerCare</a>
                </li>
                <% }%>
            </ul>
        </div>

        <div class="d-flex align-items-center">
            <a href="myProfile.jsp" class="nav-link fw-bold me-3">My Profile</a>
            <a href="LogoutServlet" class="btn btn-outline-danger btn-sm px-3 rounded-pill">Log Out</a>
        </div>
    </div>
</nav>

<%-- Letakkan JS di bahagian bawah --%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script> <li class="nav-item">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
                function showLoginAlert() {
                    Swal.fire({
                        title: 'Access Denied',
                        text: "Please sign in to your EduSpace account to make a booking.",
                        icon: 'info',
                        showCancelButton: true,
                        confirmButtonColor: '#8b4513', // Warna accent brown anda
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Sign In Now',
                        cancelButtonText: 'Maybe Later',
                        background: '#fff5eb', // Warna light peach anda
                        color: '#5d4037'       // Warna mocha-text anda
                    }).then((result) => {
                        if (result.isConfirmed) {
                            window.location.href = 'login.jsp';
                        }
                    });
                }
    </script>