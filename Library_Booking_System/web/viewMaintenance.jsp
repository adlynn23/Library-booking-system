<%@page import="java.util.List"%>
<%@page import="model.Maintenance"%>
<%@page import="dao.MaintenanceDAO"%>
<%@page import="dao.FacilityDAO"%>
<%@page import="dao.FeedbackDAO"%>
<%@page import="model.Feedback"%>
<%@page import="model.Facility"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%!
    private String safe(Object value) {
        if (value == null) return "";
        return String.valueOf(value)
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }

    private String statusClass(String status) {
        if (status == null) return "badge-pending";
        if (status.equalsIgnoreCase("Done") || status.equalsIgnoreCase("Completed") || status.equalsIgnoreCase("Resolved")) return "badge-done";
        if (status.equalsIgnoreCase("In Progress")) return "badge-progress";
        return "badge-pending";
    }

    private String priorityClass(String priority) {
        if (priority == null) return "badge-medium";
        if (priority.equalsIgnoreCase("High")) return "badge-high";
        if (priority.equalsIgnoreCase("Low")) return "badge-low";
        return "badge-medium";
    }

    private String selected(String value, String current) {
        if (value == null || current == null) return "";
        return value.equalsIgnoreCase(current) ? "selected" : "";
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Portal | Maintenance</title>
    <jsp:include page="admin_header.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        :root { --primary:#163832; --primary-hover:#0f2824; --bg:#f7f8fa; --border:#e8ded4; --text:#2d3436; --muted:#6c757d; --gold:#d4a373; }
        html, body { background:var(--bg)!important; font-family:'DM Sans',sans-serif; color:var(--text); }
        .dashboard-wrapper { max-width:1440px; margin:0 auto; padding:70px 76px; }
        .top-section { display:flex; justify-content:space-between; align-items:center; gap:24px; margin-bottom:32px; }
        .page-title { font-size:2.3rem; font-weight:800; color:var(--primary); margin:0; letter-spacing:-.8px; }
        .page-subtitle { margin-top:8px; color:var(--muted); font-size:1rem; }
        .tab-box { background:#fff; border:1px solid var(--border); border-radius:16px; padding:8px; display:flex; gap:8px; box-shadow:0 8px 20px rgba(0,0,0,.04); }
        .tab-btn { border:none; background:transparent; padding:12px 26px; border-radius:12px; font-size:.98rem; font-weight:700; cursor:pointer; transition:.2s; color:#555; }
        .tab-btn.active { background:var(--primary); color:#fff; }
        .summary-grid { display:grid; grid-template-columns:repeat(4,1fr); gap:18px; margin-bottom:28px; }
        .summary-card { background:#fff; border:1px solid var(--border); border-radius:18px; padding:22px; box-shadow:0 8px 24px rgba(0,0,0,.03); }
        .summary-card h6 { color:var(--muted); font-size:.82rem; text-transform:uppercase; font-weight:800; letter-spacing:.7px; margin-bottom:8px; }
        .summary-card h3 { color:var(--primary); font-size:2rem; font-weight:800; margin:0; }
        .content-card { background:#fff; border:1px solid var(--border); border-radius:20px; padding:28px; box-shadow:0 8px 26px rgba(0,0,0,.035); }
        .card-header-clean { display:flex; justify-content:space-between; align-items:center; gap:16px; margin-bottom:22px; }
        .card-header-clean h4 { color:var(--primary); font-weight:800; margin:0; }
        .card-header-clean p { color:var(--muted); margin:6px 0 0; font-size:.95rem; }
        .toolbar { display:flex; gap:16px; margin-bottom:25px; }
        .search-box { flex:1; border:1px solid var(--border); border-radius:14px; padding:16px 20px; font-size:15px; background:#fff; transition:.2s; }
        .status-filter { width:220px; border-radius:14px; border:1px solid var(--border); padding:15px; background:#fff; font-size:15px; }
        .search-box:focus, .status-filter:focus { outline:none; border-color:var(--primary); box-shadow:0 0 0 4px rgba(22,56,50,.08); }
        .btn-main { background:var(--primary); color:#fff; border:none; padding:12px 20px; border-radius:12px; font-weight:800; text-decoration:none; display:inline-block; transition:.2s ease; }
        .btn-main:hover { background:var(--primary-hover); color:#fff; transform:translateY(-1px); }
        .btn-light-action { background:#f8f5ef; color:var(--primary); border:1px solid var(--border); padding:10px 16px; border-radius:10px; font-weight:800; }
        .table { width:100%; border-collapse:separate; border-spacing:0; }
        .table thead th { background:#faf7f2; padding:15px 16px; font-size:12px; font-weight:900; color:var(--muted); text-transform:uppercase; letter-spacing:.7px; border-bottom:1px solid var(--border); }
        .table tbody td { padding:17px 16px; border-bottom:1px solid #f1ebe5; vertical-align:middle; font-size:14px; }
        .table tbody tr:hover { background:#fffdf8; }
        .badge-pending,.badge-progress,.badge-done,.badge-high,.badge-medium,.badge-low { display:inline-block; padding:7px 13px; border-radius:999px; font-size:12px; font-weight:800; white-space:nowrap; }
        .badge-pending { background:#eee; color:#555; }
        .badge-progress { background:#e3f2fd; color:#1565c0; }
        .badge-done { background:#e8f5e9; color:#2e7d32; }
        .badge-high { background:#ffebee; color:#c62828; }
        .badge-medium { background:#fff3e0; color:#ef6c00; }
        .badge-low { background:#e8f5e9; color:#2e7d32; }
        .tab-content { display:none; }
        .tab-content.active { display:block; }
        .reply-preview { max-width:230px; color:var(--muted); font-size:13px; }
        .modal-content { border:none; border-radius:18px; box-shadow:0 18px 50px rgba(0,0,0,.12); }
        .modal-title { color:var(--primary); font-weight:800; }
        .form-control,.form-select { border-radius:10px; padding:11px 14px; border:1px solid var(--border); background:#fcfcfc; }
        .form-control:focus,.form-select:focus { border-color:var(--gold); box-shadow:0 0 0 4px rgba(212,163,115,.16); }
        .empty-state { text-align:center; padding:45px 20px; color:var(--muted); }
        @media(max-width:900px){ .dashboard-wrapper{padding:35px 18px;} .top-section{flex-direction:column; align-items:flex-start;} .tab-box{width:100%;} .tab-btn{flex:1; padding:13px 12px;} .summary-grid{grid-template-columns:repeat(2,1fr);} .toolbar{flex-direction:column;} .status-filter{width:100%;} }
    </style>
</head>
<body>

<%
    List<Maintenance> mList = MaintenanceDAO.getAllMaintenance();
    List<Feedback> fList = FeedbackDAO.getAllFeedback();
    int totalRepair = (mList == null) ? 0 : mList.size();
    int totalReport = (fList == null) ? 0 : fList.size();
    int pendingRepair = 0;
    int completedRepair = 0;
    if (mList != null) {
        for (Maintenance m : mList) {
            String st = m.getStatus();
            if (st != null && (st.equalsIgnoreCase("Done") || st.equalsIgnoreCase("Completed") || st.equalsIgnoreCase("Resolved"))) completedRepair++;
            else pendingRepair++;
        }
    }
%>

<div class="dashboard-wrapper">
    <div class="top-section">
        <div>
            <h2 class="page-title">Maintenance Management</h2>
            <p class="page-subtitle">Manage active repairs and respond to student customer care reports.</p>
        </div>
        <div class="tab-box">
            <button class="tab-btn active" onclick="showTab('repairTab', this)">Active Repairs</button>
            <button class="tab-btn" onclick="showTab('reportTab', this)">Student Reports</button>
        </div>
    </div>

    <div class="summary-grid">
        <div class="summary-card"><h6>Total Repairs</h6><h3><%= totalRepair %></h3></div>
        <div class="summary-card"><h6>Total Reports</h6><h3><%= totalReport %></h3></div>
        <div class="summary-card"><h6>Pending Repairs</h6><h3><%= pendingRepair %></h3></div>
        <div class="summary-card"><h6>Completed Repairs</h6><h3><%= completedRepair %></h3></div>
    </div>

    <div id="repairTab" class="tab-content active">
        <div class="content-card">
            <div class="card-header-clean">
                <div><h4>Active Repair Schedule</h4><p>Track repair progress, priority, category and expected completion date.</p></div>
                <button type="button" class="btn-main" data-bs-toggle="modal" data-bs-target="#addModal">+ Key In New Repair</button>
            </div>

            <div class="toolbar">
                <input type="text" id="repairSearch" class="search-box" placeholder="Search facility, category, priority...">
                <select id="repairStatusFilter" class="status-filter">
                    <option value="">All Status</option>
                    <option value="Pending">Pending</option>
                    <option value="In Progress">In Progress</option>
                    <option value="Done">Done</option>
                    <option value="Completed">Completed</option>
                </select>
            </div>

            <div class="table-responsive">
                <table class="table" id="repairTable">
                    <thead><tr><th>Facility</th><th>Category</th><th>Priority</th><th>Description</th><th>Expected Completion</th><th>Status</th><th>Action</th></tr></thead>
                    <tbody>
                    <% if (mList == null || mList.isEmpty()) { %>
                        <tr><td colspan="7" class="empty-state">No active maintenance logs found.</td></tr>
                    <% } else { for (Maintenance m : mList) { %>
                        <tr>
                            <td><strong><%= safe(m.getFacilityName()) %></strong></td>
                            <td><%= safe(m.getCategory()) %></td>
                            <td><span class="<%= priorityClass(m.getPriority()) %>"><%= safe(m.getPriority()) %></span></td>
                            <td><%= safe(m.getDescription()) %></td>
                            <td><%= m.getExpectedCompletion() == null ? "-" : safe(m.getExpectedCompletion()) %></td>
                            <td><span class="<%= statusClass(m.getStatus()) %>"><%= safe(m.getStatus()) %></span></td>
                            <td>
                                <% if (!"Done".equalsIgnoreCase(m.getStatus()) && !"Completed".equalsIgnoreCase(m.getStatus())) { %>
                                    <button class="btn-light-action" onclick="confirmDone(<%= m.getMaintenanceId() %>)">Mark Done</button>
                                <% } else { %>
                                    <span class="text-muted">Completed</span>
                                <% } %>
                            </td>
                        </tr>
                    <% }} %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div id="reportTab" class="tab-content">
        <div class="content-card">
            <div class="card-header-clean">
                <div><h4>Student Reports</h4><p>Review Customer Care feedback and send admin replies from the same page.</p></div>
            </div>

            <div class="toolbar">
                <input type="text" id="reportSearch" class="search-box" placeholder="Search student, subject, message, priority...">
                <select id="reportStatusFilter" class="status-filter">
                    <option value="">All Status</option>
                    <option value="Pending">Pending</option>
                    <option value="In Progress">In Progress</option>
                    <option value="Resolved">Resolved</option>
                </select>
            </div>

            <div class="table-responsive">
                <table class="table" id="reportTable">
                    <thead><tr><th>Student</th><th>Report</th><th>Status</th><th>Priority</th><th>Reply Preview</th><th>Action</th></tr></thead>
                    <tbody>
                    <% if (fList == null || fList.isEmpty()) { %>
                        <tr><td colspan="6" class="empty-state">No student reports found.</td></tr>
                    <% } else { for (Feedback f : fList) { %>
                        <tr>
                            <td><strong><%= safe(f.getMatric_no()) %></strong><br><small class="text-muted">#FB<%= f.getFeedbackId() %></small></td>
                            <td><strong><%= safe(f.getSubject()) %></strong><br><small class="text-muted"><%= safe(f.getMessage()) %></small></td>
                            <td><span class="<%= statusClass(f.getStatus()) %>"><%= safe(f.getStatus()) %></span></td>
                            <td><span class="<%= priorityClass(f.getPriority()) %>"><%= safe(f.getPriority()) %></span></td>
                            <td class="reply-preview"><%= (f.getAdminReply() == null || f.getAdminReply().trim().isEmpty()) ? "No reply yet" : safe(f.getAdminReply()) %></td>
                            <td><button type="button" class="btn-main" data-bs-toggle="modal" data-bs-target="#replyModal<%= f.getFeedbackId() %>">Reply</button></td>
                        </tr>

                        <div class="modal fade" id="replyModal<%= f.getFeedbackId() %>" tabindex="-1">
                            <div class="modal-dialog"><div class="modal-content">
                                <div class="modal-header"><h5 class="modal-title">Reply to Student Report</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
                                <form action="FeedbackServlet" method="POST">
                                    <input type="hidden" name="action" value="adminReply">
                                    <input type="hidden" name="feedbackId" value="<%= f.getFeedbackId() %>">
                                    <div class="modal-body">
                                        <p class="small text-muted mb-3"><strong>Student:</strong> <%= safe(f.getMatric_no()) %><br><strong>Subject:</strong> <%= safe(f.getSubject()) %><br><strong>Message:</strong> <%= safe(f.getMessage()) %></p>
                                        <label class="mb-2">Status</label>
                                        <select name="status" class="form-select mb-3" required>
                                            <option value="Pending" <%= selected("Pending", f.getStatus()) %>>Pending</option>
                                            <option value="In Progress" <%= selected("In Progress", f.getStatus()) %>>In Progress</option>
                                            <option value="Resolved" <%= selected("Resolved", f.getStatus()) %>>Resolved</option>
                                        </select>
                                        <label class="mb-2">Priority</label>
                                        <select name="priority" class="form-select mb-3" required>
                                            <option value="Low" <%= selected("Low", f.getPriority()) %>>Low</option>
                                            <option value="Medium" <%= selected("Medium", f.getPriority()) %>>Medium</option>
                                            <option value="High" <%= selected("High", f.getPriority()) %>>High</option>
                                        </select>
                                        <label class="mb-2">Category</label>
                                        <select name="category" class="form-select mb-3" required>
                                            <option value="General" <%= selected("General", f.getCategory()) %>>General</option>
                                            <option value="Computer" <%= selected("Computer", f.getCategory()) %>>Computer</option>
                                            <option value="Projector" <%= selected("Projector", f.getCategory()) %>>Projector</option>
                                            <option value="Furniture" <%= selected("Furniture", f.getCategory()) %>>Furniture</option>
                                            <option value="Electrical" <%= selected("Electrical", f.getCategory()) %>>Electrical</option>
                                            <option value="Air Conditioner" <%= selected("Air Conditioner", f.getCategory()) %>>Air Conditioner</option>
                                            <option value="Internet/WiFi" <%= selected("Internet/WiFi", f.getCategory()) %>>Internet/WiFi</option>
                                            <option value="Others" <%= selected("Others", f.getCategory()) %>>Others</option>
                                        </select>
                                        <label class="mb-2">Expected Completion Date</label>
                                        <input type="date" name="expectedCompletion" class="form-control mb-3" value="<%= f.getExpectedCompletion() == null ? "" : safe(f.getExpectedCompletion()) %>">
                                        <label class="mb-2">Admin Reply</label>
                                        <textarea name="adminReply" class="form-control" rows="4" required><%= f.getAdminReply() == null ? "" : safe(f.getAdminReply()) %></textarea>
                                    </div>
                                    <div class="modal-footer border-0"><button type="submit" class="btn-main">Send Reply</button></div>
                                </form>
                            </div></div>
                        </div>
                    <% }} %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="modal fade" id="addModal" tabindex="-1">
        <div class="modal-dialog"><div class="modal-content">
            <div class="modal-header"><h5 class="modal-title">Report New Maintenance</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
            <form action="Maintenance_Servlet" method="POST">
                <div class="modal-body">
                    <label class="mb-2">Facility</label>
                    <select name="facilityId" class="form-select mb-3" required>
                        <option value="">Select facility</option>
                        <% List<Facility> facilities = new FacilityDAO().getAllFacilities(); if (facilities != null) { for (Facility facility : facilities) { %>
                            <option value="<%= facility.getFacilityId() %>"><%= safe(facility.getUnitName()) %> - <%= safe(facility.getFacilityName()) %></option>
                        <% }} %>
                    </select>
                    <label class="mb-2">Category</label>
                    <select name="category" class="form-select mb-3" required>
                        <option value="General">General</option><option value="Computer">Computer</option><option value="Projector">Projector</option><option value="Furniture">Furniture</option><option value="Electrical">Electrical</option><option value="Air Conditioner">Air Conditioner</option><option value="Internet/WiFi">Internet/WiFi</option><option value="Others">Others</option>
                    </select>
                    <label class="mb-2">Priority</label>
                    <select name="priority" class="form-select mb-3" required><option value="Low">Low</option><option value="Medium" selected>Medium</option><option value="High">High</option></select>
                    <label class="mb-2">Expected Completion Date</label><input type="date" name="expectedCompletion" class="form-control mb-3">
                    <label class="mb-2">Issue Description</label><textarea name="description" class="form-control" rows="4" required></textarea>
                </div>
                <div class="modal-footer border-0"><button type="submit" class="btn-main">Save Report</button></div>
            </form>
        </div></div>
    </div>
</div>

<script>
    function showTab(tabId, button) {
        document.querySelectorAll(".tab-content").forEach(tab => tab.classList.remove("active"));
        document.querySelectorAll(".tab-btn").forEach(btn => btn.classList.remove("active"));
        document.getElementById(tabId).classList.add("active");
        button.classList.add("active");
    }

    function confirmDone(id) {
        Swal.fire({
            title:"Complete Maintenance?",
            text:"This will mark the repair as done and make the facility available again.",
            icon:"question",
            showCancelButton:true,
            confirmButtonColor:"#163832",
            cancelButtonColor:"#d33",
            confirmButtonText:"Yes, Complete"
        }).then((result) => { if (result.isConfirmed) window.location = "Maintenance_Servlet?id=" + id; });
    }

    function setupTableSearch(searchId, filterId, tableId) {
        const search = document.getElementById(searchId);
        const filter = document.getElementById(filterId);
        const table = document.getElementById(tableId);
        if (!search || !filter || !table) return;

        function filterRows() {
            const keyword = search.value.toLowerCase();
            const status = filter.value.toLowerCase();
            table.querySelectorAll("tbody tr").forEach(function(row) {
                const text = row.innerText.toLowerCase();
                const searchMatch = text.includes(keyword);
                const statusMatch = status === "" || text.includes(status);
                row.style.display = (searchMatch && statusMatch) ? "" : "none";
            });
        }
        search.addEventListener("keyup", filterRows);
        filter.addEventListener("change", filterRows);
    }

    setupTableSearch("repairSearch", "repairStatusFilter", "repairTable");
    setupTableSearch("reportSearch", "reportStatusFilter", "reportTable");

    <% if ("added".equals(request.getParameter("success"))) { %>
    Swal.fire({ icon:"success", title:"Maintenance Added!", text:"The maintenance record has been successfully created.", confirmButtonColor:"#163832" });
    <% } %>
    <% if ("reply".equals(request.getParameter("success"))) { %>
    Swal.fire({ icon:"success", title:"Reply Sent!", text:"The student can now view your reply.", confirmButtonColor:"#163832" });
    <% } %>
    <% if ("done".equals(request.getParameter("success"))) { %>
    Swal.fire({ icon:"success", title:"Maintenance Completed!", text:"The facility status has been updated.", confirmButtonColor:"#163832" });
    <% } %>
    <% if ("true".equals(request.getParameter("error"))) { %>
    Swal.fire({ icon:"error", title:"Action Failed", text:"Something went wrong. Please try again.", confirmButtonColor:"#163832" });
    <% } %>
</script>

<jsp:include page="footer.jsp" />
</body>
</html>
