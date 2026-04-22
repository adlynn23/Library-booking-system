<%-- 
    Document   : viewMaintenance
    Created on : 20 Apr 2026, 9:46:35 am
    Author     : DELL
--%>

<%@page import="java.util.List"%>
<%@page import="dao.MaintenanceDAO"%>
<%@page import="model.Maintenance"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <table border="1">
        <tr>
            <th>ID</th><th>Facility</th><th>Start</th><th>End</th><th>Status</th>
        </tr>

        <%
            List<Maintenance> list = MaintenanceDAO.getAllMaintenance();
            for (Maintenance m : list) {
        %>
        <tr>
            <td><%= m.getMaintenanceId()%></td>
            <td><%= m.getFacilityId()%></td>
            <td><%= m.getStartDate()%></td>
            <td><%= m.getEndDate()%></td>
            <td><%= m.getStatus()%></td>
        </tr>
        <% }%>
    </table>
</html>