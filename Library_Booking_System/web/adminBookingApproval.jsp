<%-- 
    Document   : adminBookingApproval
    Created on : 16 May 2026, 5:58:36 pm
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>.alert-success{
                background:#dcfce7;
                color:#166534;
                padding:14px;
                border-radius:12px;
                margin-bottom:20px;
                font-weight:600;
            }

            .alert-error{
                background:#fee2e2;
                color:#991b1b;
                padding:14px;
                border-radius:12px;
                margin-bottom:20px;
                font-weight:600;
            }</style>
    </head>
    <body>

        <%
            String success = request.getParameter("success");
            String error = request.getParameter("error");
        %>

        <% if (success != null) { %>

        <div class="alert-success">
            ✅ Booking status updated successfully!
        </div>

        <% } %>

        <% if (error != null) { %>

        <div class="alert-error">
            ❌ Failed to update booking!
        </div>

        <% }%>

    </body>
</html>
