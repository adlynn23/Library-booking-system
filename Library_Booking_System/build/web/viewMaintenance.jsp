<jsp:include page="header.jsp" />
<%@page import="java.util.List"%>
<%@page import="model.Maintenance"%>
<%@page import="dao.MaintenanceDAO"%>


<div class="container">
    <div class="maintenance-container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 style="font-weight: 700; margin: 0;">Maintenance Dashboard</h2>
            <%-- ADD BUTTON --%>
            <a href="addMaintenance.jsp" class="btn-submit" style="width: auto; text-decoration: none;">+ Add New Task</a>
        </div>
        
        <table class="table table-borderless">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>FACILITY</th>
                    <th>STATUS</th>
                    <th>ACTIONS</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<Maintenance> list = MaintenanceDAO.getAllMaintenance();
                    for (Maintenance m : list) { 
                %>
                <tr>
                    <td><%= m.getMaintenanceId() %></td>
                    <td><%= m.getFacilityId() %></td>
                    <td><span class="badge" style="background-color: var(--border-tan); color: var(--text-dark);"><%= m.getStatus() %></span></td>
                    <td>
                        <%-- EDIT BUTTON --%>
                        <a href="editMaintenance.jsp?id=<%= m.getMaintenanceId() %>" 
                           style="color: var(--text-dark); font-weight: 600; text-decoration: none; margin-right: 15px;">Edit</a>
                        
                        <%-- MARK DONE BUTTON --%>
                        <form action="MaintenanceServlet" method="POST" style="display:inline;">
                            <input type="hidden" name="maintenanceId" value="<%= m.getMaintenanceId() %>">
                            <input type="hidden" name="action" value="complete">
                            <button type="submit" style="background: none; border: none; color: #8b4513; font-weight: 700; cursor: pointer;">Mark Done</button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="footer.jsp" />
