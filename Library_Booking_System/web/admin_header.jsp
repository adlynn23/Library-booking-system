<%-- 
    Document   : admin_header
    Created on : 13 May 2026, 2:46:33 pm
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="style.css">

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<%
    // Fetch administrator name if authenticated
    String userName = (String) session.getAttribute("userName");
%>

<nav class="navbar navbar-expand-lg bg-white shadow-sm py-3">
    <div class="container">

        <a class="navbar-brand" href="index.jsp">
            eduspace<span>.</span><small class="text-secondary fs-6 ms-1">Admin Panel</small>
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
            <ul class="navbar-nav ma-auto">
                <li class="nav-item">
                    <a class="nav-link" href="admin_facility.jsp">Facility List</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Booking List</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="viewMaintenance.jsp">Maintenance</a>
                </li>
            </ul>
        </div>

        <div class="d-flex align-items-center">
            <% if (userName != null) { %>
                <span class="me-3 small text-muted d-none d-md-inline">
                    Admin: <strong><%= userName %></strong>
                </span>

                <a href="myProfile.jsp" class="me-3">
                    <i class="fas fa-user-shield"></i>
                </a>

                <a href="#" class="btn btn-danger btn-sm px-3 rounded-pill" onclick="confirmLogout(event)">
                    Log Out
                </a>
            <% } else { %>
                <a href="login.jsp" class="btn btn-outline-primary btn-sm">
                    Login
                </a>
            <% } %>
        </div>

    </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
function confirmLogout(event) {
    event.preventDefault();
    Swal.fire({
        title: 'Logout?',
        text: "Are you sure you want to exit Admin Panel?",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#d33',
        cancelButtonColor: '#3085d6',
        confirmButtonText: 'Yes, logout'
    }).then((result) => {
        if (result.isConfirmed) {
            window.location.href = 'LogoutServlet';
        }
    });
}
</script>