<%-- 
    Document   : index
    Created on : 27 Apr 2026, 12:50:01 am
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/style.css">

        <title>JSP Page</title>
        <%@include file="header.jsp" %>

    </head>
    <body>
        <section class="hero-container">
            <div class="hero-content">
                <h1 class="hero-title">Better space for<br>better grades.</h1>
                <p>Access real-time schedules for library facilities.</p>
                <a href="startBookingServlet" class="btn-cta">Start Booking Now</a>

            </div>
            <div class="visual-box"></div>
        </section>
    </body>
    <%@include file="footer.jsp" %>

</html>
