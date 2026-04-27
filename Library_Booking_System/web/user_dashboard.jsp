<%-- 
    Document   : user_dashboard
    Created on : 27 Apr 2026, 5:22:48 pm
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Security Check: If someone tries to access this page without logging in
    if (session.getAttribute("userRole") == null
            || (!session.getAttribute("userRole").equals("Student") && !session.getAttribute("userRole").equals("Staff"))) {
        response.sendRedirect("login.jsp?msg=unauthorized");
        return;
    }
    String name = (String) session.getAttribute("userName");
%>
<%@include file="header_dashboard.jsp" %>

<div class="dashboard-container">
    <aside class="sidebar">
        <div class="user-profile">
            <i class="fas fa-user-circle"></i>
            <p>Welcome, <br><strong><%= name%></strong></p>
        </div>
        <nav class="sidebar-nav">
            <a href="user_dashboard.jsp" class="active"><i class="fas fa-th-large"></i> Dashboard</a>
            <a href="browse_facilities.jsp"><i class="fas fa-door-open"></i> Book Facility</a>
            <a href="my_bookings.jsp"><i class="fas fa-calendar-check"></i> My Bookings</a>
            <a href="LogoutServlet" class="logout-link"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </nav>
    </aside>

    <main class="main-content">
        <header class="content-header">
            <h2>User Dashboard</h2>
            <p>Select a facility to begin your booking process.</p>
        </header>

        <div class="status-cards">
            <div class="card">
                <h3>Active Bookings</h3>
                <p class="count">2</p>
            </div>
            <div class="card">
                <h3>Pending Requests</h3>
                <p class="count">1</p>
            </div>
        </div>

        <section class="quick-action">
            <h3>Quick Booking</h3>
            <div class="peach-box">
                <p>Need a study room right now? Check availability instantly.</p>
                <a href="browse_facilities.jsp" class="btn-cta">Browse Rooms</a>
            </div>
        </section>
    </main>
</div>

<%@include file="footer.jsp" %>