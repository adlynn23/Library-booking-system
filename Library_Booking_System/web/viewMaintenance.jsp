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
        --primary: #163832;
        --bg: #fff5eb;       /* Smooth Muji-style soft peach aesthetic background */
        --card-bg: #ffffff;
        --border: #e6dcd2;   /* Elegant tan border lines matching your theme */
        --text: #4a403a;     /* Rich mocha text color instead of harsh solid black */
        --muted: #8a7a71;
        --hover: #fdfbf7;
        --success-bg: #e8f5e9;
        --success-text: #2e7d32;
        --warning-bg: #fff3e0;
        --warning-text: #ef6c00;
    }

    html, body {
        background-color: var(--bg) !important;
        font-family: 'DM Sans', sans-serif;
        color: var(--text);
        margin: 0;
        padding: 0;
    }

    /* EXPANDED MASTER HUB CONTAINER */
    .dashboard-wrapper {
        max-width: 1440px; /* Gives the application maximum screen utilization space */
        margin: 0 auto;
        padding: 40px 24px;
    }

    /* TOP SECTION MANAGEMENT BAR */
    .page-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 35px;
        border-bottom: 1px solid var(--border);
        padding-bottom: 20px;
    }

    .page-header h2 {
        font-size: 2.2rem;
        font-weight: 700;
        color: var(--primary);
        margin: 0;
        letter-spacing: -0.5px;
    }

    .page-header p {
        color: var(--muted);
        margin-top: 6px;
        margin-bottom: 0;
        font-size: 1.05rem;
    }

    /* SIDE-BY-SIDE GRID LAYOUT ENGINE */
    .dashboard-grid {
        display: flex;
        flex-direction: row; /* Locks cards layout horizontally side-by-side */
        gap: 28px;          /* Generous clean gap spacing between columns */
        align-items: flex-start;
    }

    /* 65% Major Column Width Configuration */
    .main-schedule-panel {
        flex: 0 0 65%;
        max-width: 65%;
    }

    /* 35% Sidebar Feedback Column Width Configuration */
    .side-feedback-panel {
        flex: 0 0 35%;
        max-width: 35%;
    }

    /* WHITE MATTE CONTAINER BLOCK */
    .maintenance-container {
        background: var(--card-bg);
        border-radius: 16px;
        padding: 28px;
        border: 1px solid var(--border);
        box-shadow: 0 4px 20px rgba(74, 64, 58, 0.03);
        width: 100%;
    }

    .maintenance-container h5 {
        font-size: 1.2rem;
        font-weight: 700;
        margin-bottom: 22px;
        color: var(--primary);
    }

    /* RESPONSIVE DATA TABLE STANDARDS */
    .table-responsive {
        width: 100%;
        overflow-x: auto;
    }

    .table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
        margin-bottom: 0;
    }

    .table thead th {
        background: #faf6f0;
        padding: 14px 16px;
        font-size: 11.5px;
        font-weight: 700;
        color: var(--muted);
        text-transform: uppercase;
        letter-spacing: 0.8px;
        border-bottom: 2px solid var(--border);
    }

    .table tbody td {
        padding: 16px 16px;
        font-size: 14px;
        color: var(--text);
        border-bottom: 1px solid #f5ede4;
        vertical-align: middle;
    }

    .table tbody tr:last-child td {
        border-bottom: none;
    }

    .table tbody tr {
        transition: background 0.2s ease;
    }

    .table tbody tr:hover {
        background: var(--hover);
    }

    /* USER SUBMIT/UPDATE ACTION BUTTONS */
    .btn-update {
        background: var(--primary);
        color: white;
        border: none;
        padding: 12px 22px;
        border-radius: 10px;
        font-size: 14px;
        font-weight: 600;
        text-decoration: none;
        transition: all 0.2s ease;
        box-shadow: 0 4px 12px rgba(22, 56, 50, 0.15);
    }

    .btn-update:hover {
        opacity: 0.95;
        transform: translateY(-1px);
        box-shadow: 0 6px 16px rgba(22, 56, 50, 0.2);
        color: white;
    }

    /* CLEAN MODERN SURFACE BADGES */
    .badge-done {
        background-color: var(--success-bg);
        color: var(--success-text);
        padding: 5px 12px;
        border-radius: 6px;
        font-size: 12.5px;
        font-weight: 600;
        display: inline-block;
    }

    .badge-process {
        background-color: var(--warning-bg);
        color: var(--warning-text);
        padding: 5px 12px;
        border-radius: 6px;
        font-size: 12.5px;
        font-weight: 600;
        display: inline-block;
    }

    /* MODAL POPUP FORM STRUCTURING */
    .modal-content {
        border: none;
        border-radius: 16px;
        box-shadow: 0 15px 40px rgba(0,0,0,0.1);
    }
    
    .form-control {
        border-radius: 8px;
        padding: 12px 15px;
        border: 1px solid var(--border);
        background-color: #fcfcfc;
    }
    
    .form-control:focus {
        border-color: var(--primary);
        box-shadow: 0 0 0 4px rgba(22, 56, 50, 0.08);
        background-color: #fff;
    }

    .btn-submit {
        background: var(--primary);
        color: white;
        border: none;
        padding: 12px 24px;
        border-radius: 8px;
        font-weight: 600;
    }

    /* MOBILE SCALE DOWN DOWNFALL STRATEGY */
    @media(max-width: 1100px){
        .dashboard-grid {
            flex-direction: column; /* Stacks components downward on narrow tablet screens */
        }
        .main-schedule-panel, .side-feedback-panel {
            flex: 0 0 100%;
            max-width: 100%;
        }
    }
</style>
</head>

<div class="dashboard-wrapper">
    <div class="page-header">

        <div>
            <h2>Maintenance Dashboard</h2>
            <p>
                Track repair schedules and monitor student reports.
            </p>
        </div>
        <button type="button" class="btn-update" data-bs-toggle="modal" data-bs-target="#addModal">
            + Key In New Repair
        </button>
    </div>

    <div class="dashboard-grid">
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
                        <td>
                            <span class="badge 
                                  <%= m.getStatus().equalsIgnoreCase("Done")
            ? "bg-success"
            : "bg-warning text-dark"%>">

                                <%= m.getStatus()%>

                            </span>
                        </td></tr>
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
</div>

<jsp:include page="footer.jsp" />