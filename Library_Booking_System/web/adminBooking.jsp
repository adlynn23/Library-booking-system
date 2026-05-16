<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Management - EduSpace</title>

    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        :root {
            --primary: #163832;
            --soft-bg: #fff5eb;       /* Matching your friend's soft beige background */
            --mocha-text: #4a403a;    /* Clean dark mocha tone for text readability */
            --border-tan: #e6dcd2;    /* Subtle dividers instead of harsh grays */
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
            font-weight: 700;
            color: var(--primary);
            letter-spacing: -0.5px;
        }

        /* Top Nav Layout */
        .top-nav {
            background: var(--card-white);
            padding: 8px;
            border-radius: 16px;
            display: inline-flex;
            gap: 5px;
            box-shadow: 0 4px 20px rgba(74, 64, 58, 0.03);
            border: 1px solid var(--border-tan);
        }

        .tab-btn {
            border: none;
            padding: 10px 24px;
            border-radius: 12px;
            background: transparent;
            font-weight: 600;
            font-size: 0.95rem;
            cursor: pointer;
            color: #777;
            transition: all 0.3s ease;
        }

        .tab-btn.active {
            background: var(--primary);
            color: white !important;
        }

        .tab-btn:hover:not(.active) {
            color: var(--primary);
            background: rgba(22, 56, 50, 0.05);
        }

        .content-section { display: none; }
        .content-section.active { display: block; }

        /* Premium Card Containers */
        .maintenance-container {
            background: var(--card-white);
            border-radius: 20px;
            padding: 35px;
            box-shadow: 0 10px 30px rgba(74, 64, 58, 0.04);
            border: 1px solid var(--border-tan);
        }

        /* Professional Clean Tables */
        .custom-table {
            width: 100%;
            margin-bottom: 0;
            vertical-align: middle;
        }

        .custom-table thead th {
            background-color: #faf6f0;
            color: var(--mocha-text);
            font-weight: 700;
            text-transform: uppercase;
            font-size: 0.8rem;
            letter-spacing: 0.5px;
            padding: 16px 20px;
            border-bottom: 2px solid var(--border-tan);
        }

        .custom-table tbody td {
            padding: 18px 20px;
            font-size: 0.95rem;
            color: #555;
            border-bottom: 1px solid #f3ece4;
        }

        .custom-table tbody tr:hover td {
            background-color: #fffdfb;
        }

        /* Modern Flat Badges */
        .status-badge {
            padding: 6px 14px;
            border-radius: 50px;
            font-size: 0.8rem;
            font-weight: 600;
            display: inline-block;
        }
        .status-badge.approved { background: #dcfce7; color: #166534; }
        .status-badge.rejected { background: #fee2e2; color: #991b1b; }

        /* Request Approval Cards Layout */
        .request-card {
            border: 1px solid var(--border-tan);
            padding: 24px;
            margin-bottom: 20px;
            border-radius: 16px;
            background: var(--card-white);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .request-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(74, 64, 58, 0.05);
        }

        .request-card h5 {
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 15px;
        }

        .request-card p {
            margin-bottom: 8px;
            font-size: 0.95rem;
            color: #666;
        }

        /* Buttons Setup */
        .btn-action {
            background: var(--primary);
            color: white;
            border: none;
            padding: 10px 22px;
            border-radius: 10px;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }

        .btn-action:hover {
            opacity: 0.9;
            transform: translateY(-1px);
            color: white;
        }

        /* Modal Custom Forms */
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
            font-weight: 700;
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
            font-weight: 600;
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
            transition: 0.3s;
        }
        .form-control-custom:focus {
            border-color: var(--primary) !important;
            box-shadow: 0 0 0 0.25rem rgba(22, 56, 50, 0.1) !important;
            background-color: #fff !important;
        }
    </style>
</head>
<body>

    <jsp:include page="header.jsp"/>

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

        <div id="bookingList" class="content-section active">
            <div class="maintenance-container p-0 overflow-hidden">
                <div class="table-responsive">
                    <table class="table custom-table">
                        <thead>
                            <tr>
                                <th>Matric No</th>
                                <th>Facility Name</th>
                                <th>Booking Date</th>
                                <th>Status Indicators</th>
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

                            while(rs.next()){
                                String status = rs.getString("status");
                                String badge = status.equalsIgnoreCase("APPROVED") ? "approved" : "rejected";
                        %>
                            <tr>
                                <td class="fw-bold text-dark"><%= rs.getString("matric_no") %></td>
                                <td><%= rs.getString("facility_name") %></td>
                                <td><%= rs.getString("booking_date") %></td>
                                <td>
                                    <span class="status-badge <%= badge %>">
                                        <%= status %>
                                    </span>
                                </td>
                                <td class="text-secondary">
                                    <%= rs.getString("admin_notes") == null ? "-" : rs.getString("admin_notes") %>
                                </td>
                            </tr>
                        <%
                            }
                            conn.close();
                        } catch(Exception e){
                            out.println("<tr><td colspan='5' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
                        }
                        %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div id="bookingApproval" class="content-section">
            <div class="maintenance-container">
                <h4 class="mb-4 fw-bold text-dark" style="font-size: 1.25rem;">Outstanding Evaluation Requests</h4>
                <%
                try {
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/librarydb", "root", "");
                    String sql = "SELECT * FROM booking WHERE status='PENDING' ORDER BY created_at DESC";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery();
                    
                    boolean hasPending = false;
                    while(rs.next()){
                        hasPending = true;
                %>
                    <div class="request-card">
                        <div class="row align-items-center">
                            <div class="col-md-8">
                                <h5>Student Matric: <%= rs.getString("matric_no") %></h5>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <p><strong>Facility:</strong> <%= rs.getString("facility_name") %></p>
                                        <p><strong>Date Specified:</strong> <%= rs.getString("booking_date") %></p>
                                    </div>
                                    <div class="col-sm-6">
                                        <p><strong>Booking Time </strong> <%= rs.getString("start_time") %> - <%= rs.getString("end_time") %></p>
                                        <p><strong>Declared Purpose:</strong> <%= rs.getString("purpose") %></p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 text-md-end mt-3 mt-md-0">
                                <button class="btn btn-action"
                                        data-bs-toggle="modal"
                                        data-bs-target="#bookingModal"
                                        onclick="openModal(<%= rs.getInt("booking_id") %>)">
                                    Review Request
                                </button>
                            </div>
                        </div>
                    </div>
                <%
                    }
                    if(!hasPending) {
                        out.println("<div class='text-center py-5 text-muted'><p class='mb-0'>No pending booking validation entries found.</p></div>");
                    }
                    conn.close();
                } catch(Exception e){
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
                    <label class="form-label-custom">Administrative Statement Notes</label>
                    <textarea name="admin_notes" class="form-control form-control-custom" rows="4" placeholder="Provide justification context arguments here..."></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light rounded-10 px-4" data-bs-dismiss="modal" style="border-radius: 10px;">Cancel</button>
                <button type="submit" class="btn btn-action px-4">Commit Update</button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <jsp:include page="footer.jsp" />

    <script>
    function showTab(tabId, btn){
        document.querySelectorAll(".content-section").forEach(el => el.classList.remove("active"));
        document.getElementById(tabId).classList.add("active");
        document.querySelectorAll(".tab-btn").forEach(b => b.classList.remove("active"));
        btn.classList.add("active");
    }

    function openModal(id){
        document.getElementById("booking_id").value = id;
    }
    </script>
</body>
</html>