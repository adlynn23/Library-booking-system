<%-- 
    Document   : header
    Created on : 27 Apr 2026, 4:14:32 pm
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/latest/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/latest/js/bootstrap.bundle.min.js"></script>

<nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm py-3">
    <div class="container-fluid">
         <div class="navbar-brand fw-bold m-0" style="letter-spacing: 1px;">
            <span class="text-primary">Edu</span>Space
        </div>

        <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link px-3" href="index.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link px-3" href="facility.jsp">Facility</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link px-3" href="mybooking.jsp">MyBooking</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link px-3" href="custCare.jsp">CustomerCare</a>
                </li>
            </ul>
        </div>
 <div class="d-flex align-items-center">
            <a href="myProfile.jsp" class="btn btn-outline-secondary btn-sm me-2">My Profile</a>
            <a href="logout.jsp" class="btn btn-danger btn-sm">Log Out</a>
        </div>
       
    </div>
</nav>
