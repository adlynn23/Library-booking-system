<%-- 
    Document   : addMaintenance
    Created on : 20 Apr 2026, 9:41:15 am
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="AddMaintenanceServlet" method="post">
            Facility ID: <input type="text" name="facility_id"><br>
            Start Date: <input type="date" name="start_date"><br>
            End Date: <input type="date" name="end_date"><br>
            <button type="submit">Add Maintenance</button>
        </form>    
    </body>
</html>
