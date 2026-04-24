<%@page import="dao.MaintenanceDAO"%>
<%@page import="model.Maintenance"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <link rel="stylesheet" type="text/css" href="style.css">
    <jsp:include page="header.jsp" />
<head>
    <title>Manage Maintenance</title>
</head>
<body>
    <h2>Maintenance Schedule</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Facility</th>
            <th>Start Date</th>
            <th>End Date</th>
            <th>Status</th>
        </tr>
        <% 
            List<Maintenance> list = MaintenanceDAO.getAllMaintenance();
            for (Maintenance m : list) { 
        %>
        <tr>
            <td><%= m.getMaintenanceId() %></td>
            <td><%= m.getFacilityId() %></td>
            <td><%= m.getStartDate() %></td>
            <td><%= m.getEndDate() %></td>
            <td><%= m.getStatus() %></td>
        </tr>
        <% } %>
    </table>
</body>
<jsp:include page="footer.jsp" />
</html>