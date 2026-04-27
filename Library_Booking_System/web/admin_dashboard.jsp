<%-- 
    Document   : admin_dashboard
    Created on : 27 Apr 2026, 5:28:05 pm
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    //Security check: only allow librarians
    if (session.getAttribute("userRole") == null || !session.getAttribute("userRole").equals("Librarian")) {
        response.sendRedirect("login.jsp?msg=unauthorized");
        return;
    }
    String name = (String) session.getAttribute("userName");
%>

<%@include file="admin_header.jsp" %>
<div class="dashboard-container">
    <aside class="sidebar">
        <div class="user-profile">
            <i class="fas fa-user-shield"></i>
            <p>Admin Panel<br><strong><%= name%></strong></p>
        </div>
        <nav class="sidebar-nav">
            <a href="admin_dashboard.jsp" class="active"><i class="fas fa-chart-line"></i> Overview</a>
            <a href="manage_facilities.jsp"><i class="fas fa-tasks"></i> Manage Facilities</a>
            <a href="maintenance.jsp"><i class="fas fa-tools"></i> Maintenance</a>
            <a href="reports.jsp"><i class="fas fa-file-alt"></i> Booking Reports</a>
            <a href="LogoutServlet" class="logout-link"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </nav>
    </aside>

    <main class="main-content">
        <header class="content-header">
            <h2>Librarian Dashboard</h2>
            <p>System Management and Facility Control</p>
        </header>

        <div class="status-cards">
            <div class="card" style="border-left: 5px solid #2ecc71;">
                <h3>Total Bookings Today</h3>
                <p class="count">14</p>
            </div>
            <div class="card" style="border-left: 5px solid #e67e22;">
                <h3>Pending Approvals</h3>
                <p class="count">5</p>
            </div>
        </div>

        <section class="quick-action">
            <h3>System Status</h3>
            <div class="peach-box" style="border: 1px solid #d4a373;">
                <p>All library systems are currently operational. There are 2 rooms scheduled for cleaning today.</p>
                <a href="manage_facilities.jsp" class="btn-cta">Update Facility Status</a>
            </div>
        </section>
    </main>
</div>

<%@include file="footer.jsp" %>
