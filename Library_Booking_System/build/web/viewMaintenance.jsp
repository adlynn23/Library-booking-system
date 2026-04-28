<%-- 
    Document   : viewMaintenance
    Created on : 27 Apr 2026, 6:40:51 pm
    Author     : DELL
--%>

<%@page import="java.util.*"%>
<%@page import="model.Maintenance"%>
<%@page import="dao.MaintenanceDAO"%>
<%@page import="dao.FeedbackDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="header.jsp" />

<div class="container mt-5 py-4">
    <%-- SECTION 1: Maintenance Tasks (Staff Only) --%>
    <% if ("Staff".equals(session.getAttribute("role"))) { %>
        <div class="maintenance-container mb-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold" style="color: var(--mocha-text);">Maintenance Dashboard</h2>
                <a href="addMaintenance.jsp" class="btn btn-primary rounded-pill px-4 shadow-sm">+ Add New Task</a>
            </div>

            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
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
                            <td class="fw-bold text-muted">#<%= m.getMaintenanceId() %></td>
                            <td>Facility <%= m.getFacilityId() %></td>
                            <td>
                                <span class="badge rounded-pill <%= m.getStatus().equals("Done") ? "bg-success" : "bg-warning text-dark" %>">
                                    <%= m.getStatus() %>
                                </span>
                            </td>
                            <td>
                                <a href="editMaintenance.jsp?id=<%= m.getMaintenanceId() %>" class="btn btn-sm btn-outline-secondary">Edit</a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

        <%-- SECTION 2: Student Feedback & Issues (Staff Only) --%>
        <div class="maintenance-container">
            <h3 class="fw-bold mb-4" style="color: #8b4513;">Student Feedback & Issues</h3>
            <div class="table-responsive">
                <table class="table table-hover border-top">
                    <thead class="table-light">
                        <tr>
                            <th>Date</th>
                            <th>Subject</th>
                            <th>Message</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            List<Map<String, String>> feedbackList = FeedbackDAO.getAllFeedback();
                            if (feedbackList.isEmpty()) {
                        %>
                            <tr><td colspan="3" class="text-center text-muted">No new feedback received.</td></tr>
                        <% 
                            } else {
                                for (Map<String, String> fb : feedbackList) { 
                        %>
                        <tr>
                            <td class="small text-muted"><%= fb.get("date") %></td>
                            <td><span class="badge bg-info text-dark"><%= fb.get("subject") %></span></td>
                            <td><%= fb.get("message") %></td>
                        </tr>
                        <% 
                                }
                            } 
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    <% } else { %>
        <%-- Access Denied Message for Students --%>
        <div class="text-center py-5">
            <i class="fas fa-lock fa-3x text-muted mb-3"></i>
            <h3 class="text-muted">Access Restricted</h3>
            <p>Only administrative staff can view the maintenance logs.</p>
            <a href="dashboard.jsp" class="btn btn-primary">Return Home</a>
        </div>
    <% } %>
</div>

<jsp:include page="footer.jsp" />