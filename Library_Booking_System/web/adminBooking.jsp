<%@page import="java.sql.*"%>
<%@page import="java.time.format.DateTimeFormatter"%>

<%
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("hh:mm a");

    int totalBookings = 0;
    int pendingCount = 0;
    int approvedCount = 0;
    int rejectedCount = 0;
    int cancelledCount = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection countConn = DriverManager.getConnection("jdbc:mysql://localhost:3307/librarydb", "root", "");

        String countSql =
                "SELECT " +
                "COUNT(*) AS total, " +
                "SUM(CASE WHEN status='PENDING' THEN 1 ELSE 0 END) AS pending, " +
                "SUM(CASE WHEN status='APPROVED' THEN 1 ELSE 0 END) AS approved, " +
                "SUM(CASE WHEN status='REJECTED' THEN 1 ELSE 0 END) AS rejected, " +
                "SUM(CASE WHEN status='CANCELLED' THEN 1 ELSE 0 END) AS cancelled " +
                "FROM booking";

        PreparedStatement countPs = countConn.prepareStatement(countSql);
        ResultSet countRs = countPs.executeQuery();

        if (countRs.next()) {
            totalBookings = countRs.getInt("total");
            pendingCount = countRs.getInt("pending");
            approvedCount = countRs.getInt("approved");
            rejectedCount = countRs.getInt("rejected");
            cancelledCount = countRs.getInt("cancelled");
        }

        countConn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Booking Management - EduSpace</title>

    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        :root {
            --primary: #163832;
            --soft-bg: #fff5eb;
            --mocha-text: #4a403a;
            --border-tan: #e6dcd2;
            --card-white: #ffffff;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'DM Sans', sans-serif;
            background-color: var(--soft-bg) !important;
            color: var(--mocha-text);
            padding-bottom: 60px;
        }

        .dashboard-header {
            font-size: 2rem;
            font-weight: 800;
            color: var(--primary);
            letter-spacing: -0.5px;
        }

        .top-nav {
            background: var(--card-white);
            padding: 8px;
            border-radius: 16px;
            display: inline-flex;
            gap: 5px;
            box-shadow: 0 4px 20px rgba(74, 64, 58, 0.04);
            border: 1px solid var(--border-tan);
        }

        .tab-btn {
            border: none;
            padding: 10px 24px;
            border-radius: 12px;
            background: transparent;
            font-weight: 700;
            font-size: 0.95rem;
            cursor: pointer;
            color: #777;
            transition: all 0.25s ease;
        }

        .tab-btn.active {
            background: var(--primary);
            color: white !important;
        }

        .tab-btn:hover:not(.active) {
            color: var(--primary);
            background: rgba(22, 56, 50, 0.06);
        }

        .summary-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(170px, 1fr));
            gap: 18px;
            margin-bottom: 28px;
        }

        .summary-card {
            background: white;
            padding: 20px;
            border-radius: 18px;
            border: 1px solid var(--border-tan);
            box-shadow: 0 8px 24px rgba(74, 64, 58, 0.04);
        }

        .summary-card span {
            color: #7a706a;
            font-size: 0.9rem;
            font-weight: 700;
        }

        .summary-card h2 {
            margin-top: 8px;
            font-size: 2rem;
            font-weight: 800;
            color: var(--primary);
        }

        .summary-pending h2 { color: #b06000; }
        .summary-approved h2 { color: #166534; }
        .summary-rejected h2 { color: #991b1b; }
        .summary-cancelled h2 { color: #555; }

        .content-section {
            display: none;
        }

        .content-section.active {
            display: block;
        }

        .maintenance-container {
            background: var(--card-white);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(74, 64, 58, 0.04);
            border: 1px solid var(--border-tan);
        }

        .search-filter-bar {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        .search-filter-bar input,
        .search-filter-bar select {
            padding: 12px 16px;
            border: 1px solid var(--border-tan);
            border-radius: 12px;
            background: white;
            font-family: 'DM Sans', sans-serif;
            font-size: 0.95rem;
            outline: none;
        }

        .search-filter-bar input {
            flex: 1;
            min-width: 260px;
        }

        .search-filter-bar select {
            min-width: 180px;
        }

        .search-filter-bar input:focus,
        .search-filter-bar select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 0.2rem rgba(22, 56, 50, 0.08);
        }

        .custom-table {
            width: 100%;
            margin-bottom: 0;
            vertical-align: middle;
        }

        .custom-table thead th {
            background-color: #faf6f0;
            color: var(--mocha-text);
            font-weight: 800;
            text-transform: uppercase;
            font-size: 0.78rem;
            letter-spacing: 0.5px;
            padding: 15px 18px;
            border-bottom: 2px solid var(--border-tan);
            white-space: nowrap;
        }

        .custom-table tbody td {
            padding: 16px 18px;
            font-size: 0.94rem;
            color: #555;
            border-bottom: 1px solid #f3ece4;
            vertical-align: middle;
        }

        .custom-table tbody tr:hover td {
            background-color: #fffdfb;
        }

        .status-badge {
            padding: 7px 14px;
            border-radius: 999px;
            font-size: 0.78rem;
            font-weight: 800;
            display: inline-block;
            text-transform: uppercase;
            white-space: nowrap;
        }

        .status-badge.approved {
            background: #dcfce7;
            color: #166534;
        }

        .status-badge.pending {
            background: #fef7e0;
            color: #b06000;
        }

        .status-badge.rejected {
            background: #fee2e2;
            color: #991b1b;
        }

        .status-badge.cancelled {
            background: #f1f3f4;
            color: #444;
        }

        .request-card {
            border: 1px solid var(--border-tan);
            padding: 24px;
            margin-bottom: 18px;
            border-radius: 18px;
            background: var(--card-white);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .request-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(74, 64, 58, 0.06);
        }

        .request-title {
            font-size: 1.05rem;
            font-weight: 800;
            color: var(--primary);
            margin-bottom: 14px;
        }

        .request-detail {
            margin-bottom: 8px;
            color: #625852;
            font-size: 0.95rem;
        }

        .request-detail strong {
            color: #3f3732;
        }

        .purpose-box {
            background: #faf6f0;
            padding: 12px 14px;
            border-radius: 12px;
            margin-top: 10px;
            color: #554b45;
            font-weight: 600;
        }

        .btn-action {
            background: var(--primary);
            color: white;
            border: none;
            padding: 10px 22px;
            border-radius: 10px;
            font-weight: 700;
            font-size: 0.9rem;
            transition: all 0.25s ease;
        }

        .btn-action:hover {
            opacity: 0.95;
            transform: translateY(-1px);
            color: white;
        }

        .notes-muted {
            color: #9a918b;
            font-style: italic;
        }

        .modal-content {
            border-radius: 20px;
            border: none;
            box-shadow: 0 15px 40px rgba(0,0,0,0.1);
        }

        .modal-header {
            border-bottom: 1px solid var(--border-tan);
            padding: 20px 25px;
        }

        .modal-header h5 {
            font-weight: 800;
            color: var(--mocha-text);
        }

        .modal-body {
            padding: 25px;
        }

        .modal-footer {
            border-top: 1px solid var(--border-tan);
            padding: 15px 25px;
        }

        .form-label-custom {
            font-weight: 700;
            color: var(--mocha-text);
            margin-bottom: 8px;
            font-size: 0.9rem;
        }

        .form-control-custom {
            border: 1px solid var(--border-tan) !important;
            border-radius: 10px !important;
            padding: 12px !important;
            background-color: #fcfcfc !important;
            font-size: 0.95rem;
        }

        .form-control-custom:focus {
            border-color: var(--primary) !important;
            box-shadow: 0 0 0 0.25rem rgba(22, 56, 50, 0.1) !important;
            background-color: #fff !important;
        }
    </style>
</head>

<body>

<jsp:include page="admin_header.jsp"/>

<div class="container mt-5">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="dashboard-header">Booking Management</h1>

        <div class="top-nav">
            <button class="tab-btn active" onclick="showTab('bookingList', this)">
                Booking History
            </button>
            <button class="tab-btn" onclick="showTab('bookingApproval', this)">
                Pending Approvals
            </button>
        </div>
    </div>

    <div class="summary-cards">
        <div class="summary-card">
            <span>Total Bookings</span>
            <h2><%= totalBookings %></h2>
        </div>

        <div class="summary-card summary-pending">
            <span>Pending</span>
            <h2><%= pendingCount %></h2>
        </div>

        <div class="summary-card summary-approved">
            <span>Approved</span>
            <h2><%= approvedCount %></h2>
        </div>

        <div class="summary-card summary-rejected">
            <span>Rejected</span>
            <h2><%= rejectedCount %></h2>
        </div>

        <div class="summary-card summary-cancelled">
            <span>Cancelled</span>
            <h2><%= cancelledCount %></h2>
        </div>
    </div>

    <div id="bookingList" class="content-section active">

        <div class="search-filter-bar">
            <input type="text"
                   id="searchInput"
                   placeholder="Search matric no, facility, date or notes...">

            <select id="statusFilter">
                <option value="">All Status</option>
                <option value="APPROVED">Approved</option>
                <option value="REJECTED">Rejected</option>
                <option value="CANCELLED">Cancelled</option>
            </select>
        </div>

        <div class="maintenance-container p-0 overflow-hidden">
            <div class="table-responsive">
                <table class="table custom-table">
                    <thead>
                    <tr>
                        <th>Matric No</th>
                        <th>Facility Name</th>
                        <th>Booking Date</th>
                        <th>Time Slot</th>
                        <th>Status</th>
                        <th>Administrative Notes</th>
                    </tr>
                    </thead>

                    <tbody>
                    <%
                        try {
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/librarydb", "root", "");

                            String sql = "SELECT * FROM booking WHERE status != 'PENDING' ORDER BY created_at DESC";
                            PreparedStatement ps = conn.prepareStatement(sql);
                            ResultSet rs = ps.executeQuery();

                            boolean hasHistory = false;

                            while (rs.next()) {
                                hasHistory = true;

                                String status = rs.getString("status");
                                String badge = "cancelled";

                                if ("APPROVED".equalsIgnoreCase(status)) {
                                    badge = "approved";
                                } else if ("REJECTED".equalsIgnoreCase(status)) {
                                    badge = "rejected";
                                } else if ("CANCELLED".equalsIgnoreCase(status)) {
                                    badge = "cancelled";
                                }

                                String displayDate = rs.getDate("booking_date").toLocalDate().format(dateFormatter);
                                String displayStart = rs.getTime("start_time").toLocalTime().format(timeFormatter);
                                String displayEnd = rs.getTime("end_time").toLocalTime().format(timeFormatter);

                                String notes = rs.getString("admin_notes");
                    %>

                    <tr class="booking-row" data-status="<%= status %>">
                        <td class="fw-bold text-dark"><%= rs.getString("matric_no") %></td>
                        <td><%= rs.getString("facility_name") %></td>
                        <td><%= displayDate %></td>
                        <td><%= displayStart %> - <%= displayEnd %></td>
                        <td>
                            <span class="status-badge <%= badge %>">
                                <%= status %>
                            </span>
                        </td>
                        <td class="text-secondary">
                            <%
                                if (notes == null || notes.trim().isEmpty()) {
                            %>
                                <span class="notes-muted">No remarks</span>
                            <%
                                } else {
                            %>
                                <%= notes %>
                            <%
                                }
                            %>
                        </td>
                    </tr>

                    <%
                            }

                            if (!hasHistory) {
                    %>

                    <tr>
                        <td colspan="6" class="text-center py-5 text-muted">
                            No booking history found.
                        </td>
                    </tr>

                    <%
                            }

                            conn.close();
                        } catch (Exception e) {
                            out.println("<tr><td colspan='6' class='text-danger text-center py-4'>Error: " + e.getMessage() + "</td></tr>");
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div id="bookingApproval" class="content-section">
        <div class="maintenance-container">
            <h4 class="mb-4 fw-bold text-dark" style="font-size: 1.25rem;">
                Outstanding Evaluation Requests
            </h4>

            <%
                try {
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/librarydb", "root", "");

                    String sql = "SELECT * FROM booking WHERE status='PENDING' ORDER BY created_at DESC";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery();

                    boolean hasPending = false;

                    while (rs.next()) {
                        hasPending = true;

                        String displayDate = rs.getDate("booking_date").toLocalDate().format(dateFormatter);
                        String displayStart = rs.getTime("start_time").toLocalTime().format(timeFormatter);
                        String displayEnd = rs.getTime("end_time").toLocalTime().format(timeFormatter);
            %>

            <div class="request-card">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <div class="request-title">
                            Student Matric: <%= rs.getString("matric_no") %>
                        </div>

                        <div class="row">
                            <div class="col-sm-6">
                                <div class="request-detail">
                                    <strong>Facility:</strong> <%= rs.getString("facility_name") %>
                                </div>

                                <div class="request-detail">
                                    <strong>Date:</strong> <%= displayDate %>
                                </div>
                            </div>

                            <div class="col-sm-6">
                                <div class="request-detail">
                                    <strong>Time:</strong> <%= displayStart %> - <%= displayEnd %>
                                </div>

                                <div class="request-detail">
                                    <strong>Status:</strong>
                                    <span class="status-badge pending">Pending</span>
                                </div>
                            </div>
                        </div>

                        <div class="purpose-box">
                            Purpose: <%= rs.getString("purpose") %>
                        </div>
                    </div>

                    <div class="col-md-4 text-md-end mt-3 mt-md-0">
                        <button class="btn btn-action"
                                data-bs-toggle="modal"
                                data-bs-target="#bookingModal"
                                onclick="openModal(<%= rs.getInt("booking_id") %>)">
                            Review
                        </button>
                    </div>
                </div>
            </div>

            <%
                    }

                    if (!hasPending) {
            %>

            <div class="text-center py-5 text-muted">
                <p class="mb-0">No pending booking approval requests found.</p>
            </div>

            <%
                    }

                    conn.close();
                } catch (Exception e) {
                    out.println("<div class='alert alert-danger'>Error processing database metrics: " + e.getMessage() + "</div>");
                }
            %>
        </div>
    </div>
</div>

<div class="modal fade" id="bookingModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title">Review Booking Transaction</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <form action="UpdateBookingServlet" method="post">
                <div class="modal-body">
                    <input type="hidden" name="booking_id" id="booking_id">

                    <div class="mb-3">
                        <label class="form-label-custom">Determination Status</label>
                        <select name="status" class="form-select form-control-custom">
                            <option value="APPROVED">Approve Resource Allocation</option>
                            <option value="REJECTED">Reject Resource Request</option>
                            <option value="PENDING">Hold Pending Verification</option>
                        </select>
                    </div>

                    <div class="mb-0">
                        <label class="form-label-custom">Administrative Notes</label>
                        <textarea name="admin_notes"
                                  class="form-control form-control-custom"
                                  rows="4"
                                  placeholder="Enter approval or rejection remarks..."></textarea>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button"
                            class="btn btn-light px-4"
                            data-bs-dismiss="modal"
                            style="border-radius: 10px;">
                        Cancel
                    </button>

                    <button type="submit" class="btn btn-action px-4">
                        Commit Update
                    </button>
                </div>
            </form>

        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />

<script>
    function showTab(tabId, btn) {
        document.querySelectorAll(".content-section").forEach(el => el.classList.remove("active"));
        document.getElementById(tabId).classList.add("active");

        document.querySelectorAll(".tab-btn").forEach(b => b.classList.remove("active"));
        btn.classList.add("active");
    }

    function openModal(id) {
        document.getElementById("booking_id").value = id;
    }

    const searchInput = document.getElementById("searchInput");
    const statusFilter = document.getElementById("statusFilter");

    function filterBookings() {
        let search = searchInput.value.toLowerCase();
        let status = statusFilter.value;

        document.querySelectorAll(".booking-row").forEach(row => {
            let text = row.innerText.toLowerCase();
            let rowStatus = row.dataset.status;

            let matchesSearch = text.includes(search);
            let matchesStatus = status === "" || rowStatus === status;

            row.style.display = (matchesSearch && matchesStatus) ? "" : "none";
        });
    }

    searchInput.addEventListener("keyup", filterBookings);
    statusFilter.addEventListener("change", filterBookings);
</script>

</body>
</html>