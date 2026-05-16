<%@page import="java.util.List"%>
<%@page import="model.Maintenance"%>
<%@page import="dao.MaintenanceDAO"%>
<%@page import="dao.FeedbackDAO"%>
<%@page import="model.Feedback"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<head>
<jsp:include page="admin_header.jsp" />
<title>Admin Portal | Facility Management</title>

<style>
    :root {
    --mocha-text: #4b3832;
    --soft-peach: #f3f4f6;
    --card-bg: #ffffff;
    --border-color: #e8ddd4;
    --hover-bg: #faf6f2;
    --accent: #8b5e3c;
    --success: #4CAF50;
    --warning: #f4b400;
}

/* CONTAINER */
.maintenance-container {
    background: var(--card-bg);
    padding: 25px;
    border-radius: 18px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.05);
    margin-bottom: 35px;
}

/* SECTION TITLE */
.maintenance-container h5 {
    color: var(--mocha-text);
    font-weight: 700;
    margin-bottom: 20px;
}

/* TABLE */
.table {
    width: 100%;
    border-collapse: collapse;
    overflow: hidden;
    border-radius: 12px;
}

/* HEADER */
.table thead {
    background: #f3ebe4;
}

.table thead th {
    padding: 16px;
    font-size: 14px;
    color: var(--mocha-text);
    font-weight: 700;
    border-bottom: 2px solid var(--border-color);
}

/* BODY */
.table tbody td {
    padding: 16px;
    vertical-align: middle;
    border-bottom: 1px solid #f1ece7;
    color: #555;
    font-size: 14px;
}

/* HOVER EFFECT */
.table tbody tr:hover {
    background: var(--hover-bg);
    transition: 0.2s ease;
}

/* BADGE */
.badge {
    padding: 8px 14px;
    border-radius: 30px;
    font-size: 12px;
    font-weight: 600;
}

/* BUTTON */
.btn-update {
    display: inline-block;
    padding: 10px 18px;
    border-radius: 10px;
    background: linear-gradient(to right, #8b5e3c, #b08968);
    color: white;
    text-decoration: none;
    font-size: 13px;
    font-weight: 600;
    border: none;
    transition: 0.3s ease;
}

.btn-update:hover {
    transform: translateY(-2px);
    opacity: 0.9;
    color: white;
}

/* SAVE BUTTON */
.btn-submit {
    background: linear-gradient(to right, #8b5e3c, #b08968);
    border: none;
    color: white;
    padding: 10px 22px;
    border-radius: 10px;
    font-weight: 600;
}

.btn-submit:hover {
    opacity: 0.9;
}

/* EMPTY TEXT */
.text-muted {
    padding: 20px;
}

/* MODAL INPUT */
.form-control {
    border-radius: 10px;
    padding: 12px;
    border: 1px solid #ddd;
    box-shadow: none;
}

.form-control:focus {
    border-color: #b08968;
    box-shadow: 0 0 0 0.15rem rgba(176, 137, 104, 0.25);
}
</style>
</head>

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
                    <td><<span class="badge 
<%= m.getStatus().equalsIgnoreCase("Done") 
? "bg-success" 
: "bg-warning text-dark" %>"></span></td>
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