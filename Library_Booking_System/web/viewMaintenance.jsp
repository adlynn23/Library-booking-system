<%@page import="java.util.List"%>
<%@page import="model.Maintenance"%>
<%@page import="dao.MaintenanceDAO"%>
<%@page import="dao.FeedbackDAO"%>
<%@page import="model.Feedback"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="admin_header.jsp" />

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 style="color: var(--mocha-text);">Manage Maintenance</h2>
        <button type="button" class="btn-update" data-bs-toggle="modal" data-bs-target="#addModal">
            + Key In New Repair
        </button>
    </div>

    <div class="maintenance-container mb-5">
        <h5>Active Repair Schedule</h5>
        <table class="table">
            <thead>
                <tr><th>Facility</th><th>Description</th><th>Status</th><th>Action</th></tr>
            </thead>
            <tbody>
                <%
                    List<Maintenance> mList = dao.MaintenanceDAO.getAllMaintenance();
                    if (mList == null || mList.isEmpty()) {
                %>
                <tr><td colspan="4" class="text-center text-muted">No active maintenance logs found.</td></tr>
                <%
                } else {
                    for (Maintenance m : mList) {
                %>
                <tr>
                    <td><%= m.getFacilityId()%></td>
                    <td><%= m.getDescription()%></td>
                    <td><span class="badge bg-warning text-dark"><%= m.getStatus()%></span></td>
                    <td><a href="UpdateStatusServlet?id=<%= m.getMaintenanceId()%>" class="btn-update">Mark Done</a></td>
                </tr>
                <%     }
                    }
                %>
            </tbody>
        </table>
    </div>

    <div class="maintenance-container">
        <h5>Student Reports (from Customer Care)</h5>
        <table class="table">
            <thead>
                <tr><th>Student</th><th>Subject</th><th>Message</th></tr>
            </thead>
            <tbody>
                <% List<Feedback> fList = FeedbackDAO.getAllFeedback();
                    for (Feedback f : fList) {%>
                <tr>
                    <td><strong><%= f.getMatric_no()%></strong></td>
                    <td><%= f.getSubject()%></td>
                    <td><%= f.getMessage()%></td>
                </tr>
                <% }%>
            </tbody>
        </table>
    </div>
</div>

<div class="modal fade" id="addModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content" style="border-radius: 15px; background: var(--soft-peach);">
            <div class="modal-header">
                <h5 class="modal-title">Report New Maintenance</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="Maintenance_Servlet" method="POST">
                <div class="modal-body">
                    <label>Facility ID</label>
                    <input type="text" name="facilityId" class="form-control mb-3" required>
                    <label>Issue Description</label>
                    <textarea name="description" class="form-control" rows="3" required></textarea>
                </div>
                <div class="modal-footer border-0">
                    <button type="submit" class="btn-submit">Save Report</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />