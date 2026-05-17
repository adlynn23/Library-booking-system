 <%--
    Document   : admin_header
    Created on : 13 May 2026, 2:46:33 pm
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&display=swap" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="style.css?v=<%= System.currentTimeMillis()%>">

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
    :root {
        --edu-green: #1a3a32;
        --edu-green-hover: #112621;
        --accent-gold: #d4a373;
        --text-dark: #2d3436;
    }

    body {
        font-family: 'DM Sans', sans-serif;
        background-color: #fcfaf7; 
        color: var(--text-dark);
    }

    /* --- PREMIUM NAVIGATION CONFIGURATIONS --- */
    .navbar {
        background-color: #ffffff !important;
        border-bottom: 1px solid rgba(0, 0, 0, 0.04) !important;
        padding: 0.8rem 0 !important;
        box-shadow: 0 4px 20px rgba(26, 58, 50, 0.04) !important;
    }

    .navbar-brand {
        font-weight: 700 !important;
        color: var(--edu-green) !important;
        font-size: 1.7rem !important;
        letter-spacing: -0.5px;
        transition: opacity 0.2s ease;
    }

    .navbar-brand span {
        color: var(--accent-gold) !important;
    }

    .nav-link {
        color: #555555 !important;
        font-weight: 500 !important;
        font-size: 0.95rem !important;
        margin: 0 12px !important;
        padding: 6px 0 !important;
        transition: color 0.25s ease, transform 0.25s ease !important;
        position: relative;
    }

    .nav-link:hover {
        color: var(--edu-green) !important;
        transform: translateY(-1px);
    }

    /* Expanding gold accent line underneath text */
    .nav-link::after {
        content: '';
        position: absolute;
        width: 0;
        height: 2px;
        bottom: 0;
        left: 50%;
        background-color: var(--accent-gold);
        transition: width 0.25s ease, left 0.25s ease;
    }

    .nav-link:hover::after {
        width: 100%;
        left: 0;
    }

    /* User Profile & Notification Links */
    .admin-icon-link {
        color: #555;
        font-size: 1.1rem;
        transition: color 0.2s, transform 0.2s;
        position: relative;
    }
    .admin-icon-link:hover {
        color: var(--edu-green);
        transform: translateY(-1px);
    }
    
    /* Notification Indicator Badge Positioning */
    .notif-badge {
        position: absolute;
        top: -4px;
        right: -6px;
        background-color: #e63946;
        color: white;
        font-size: 0.65rem;
        padding: 3px 6px;
        border-radius: 50%;
        font-weight: 700;
        border: 2px solid #ffffff;
    }

    /* Customized Action Buttons */
    .btn-edu-logout {
        background-color: #e63946;
        color: white !important;
        font-weight: 600;
        font-size: 0.85rem;
        border: none;
        transition: all 0.2s ease;
    }
    .btn-edu-logout:hover {
        background-color: #c92a36;
        transform: translateY(-1px);
        box-shadow: 0 4px 10px rgba(230, 57, 70, 0.2);
    }

    .btn-edu-login {
        border: 1.5px solid var(--edu-green);
        color: var(--edu-green) !important;
        font-weight: 600;
        font-size: 0.85rem;
        transition: all 0.2s ease;
    }
    .btn-edu-login:hover {
        background-color: var(--edu-green);
        color: #ffffff !important;
    }
</style>

<%
    // Fetch administrator name if authenticated
    String userName = (String) session.getAttribute("userName");
    int unreadCount = 0;

    try {
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3307/librarydb",
            "root",
            ""
        );

        String sql = "SELECT COUNT(*) FROM notification WHERE status='UNREAD'";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            unreadCount = rs.getInt(1);
        }

        conn.close();
    } catch(Exception e) {
        out.println(e);
    }
%>

<nav class="navbar navbar-expand-lg navbar-light">
    <div class="container">

        <a class="navbar-brand" href="index.jsp">
            eduspace<span>.</span><small class="text-muted fw-normal fs-6 ms-2">Admin Panel</small>
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="admin_facility.jsp">Facility List</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="adminBooking.jsp">Booking List</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="viewMaintenance.jsp">Maintenance</a>
                </li>
            </ul>
        </div>

        <div class="d-flex align-items-center">
            <% if (userName != null) { %>
                <span class="me-3 small fw-medium text-secondary d-none d-md-inline">
                    Admin: <strong><%= userName %></strong>
                </span>

                <!--               <a href="adminNotification.jsp" class="me-3 admin-icon-link" title="Notifications">
                    <i class="fa-solid fa-bell fa-lg"></i>
                    <% if (unreadCount > 0) { %>
                        <span class="notif-badge"><%= unreadCount %></span>
                    <% } %>
                </a>  --> 

                <a href="myProfile.jsp" class="me-3 admin-icon-link" title="Admin Settings">
                    <i class="fa-solid fa-user-shield fa-lg"></i>
                </a>

                <a href="#" class="btn btn-edu-logout btn-sm px-3 rounded-pill" onclick="confirmLogout(event)">
                    Log Out
                </a>
            <% } else { %>
                <a href="login.jsp" class="btn btn-edu-login btn-sm px-3 rounded-pill">
                    Login
                </a>
            <% } %>
        </div>

    </div>
</nav>

<!--         NOTIFICATION BELL 
<div style="position:relative; display:inline-block; margin-left:20px;">

    <a href="adminNotification.jsp" style="text-decoration:none; font-size:20px;">
        🔔
    </a>-->

    <span style="
        position:absolute;
        top:-5px;
        right:-10px;
        background:red;
        color:white;
        font-size:12px;
        border-radius:50%;
        padding:2px 6px;
    ">
        <%= unreadCount %>
    </span>

    <!-- comment </div>-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
function confirmLogout(event) {
    event.preventDefault();
    Swal.fire({
        title: 'Logout?',
        text: "Are you sure you want to exit Admin Panel?",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#e63946',
        cancelButtonColor: '#6c757d',
        confirmButtonText: 'Yes, logout',
        cancelButtonText: 'Cancel'
    }).then((result) => {
        if (result.isConfirmed) {
            window.location.href = 'LogoutServlet';
        }
    });
}
</script>