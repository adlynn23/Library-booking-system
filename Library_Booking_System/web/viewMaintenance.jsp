<%@page import="java.util.List"%>
<%@page import="model.Maintenance"%>
<%@page import="dao.MaintenanceDAO"%>
<%@page import="dao.FacilityDAO"%>
<%@page import="dao.FeedbackDAO"%>
<%@page import="model.Feedback"%>
<%@page import="model.Facility"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<head>
    <jsp:include page="admin_header.jsp" />
    <title>Admin Portal | Facility Management</title>

    <style>
        :root {
            --primary: #163832;
            --bg: #fff5eb;
            --card-bg: #ffffff;
            --border: #e6dcd2;
            --text: #4a403a;
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

        .dashboard-wrapper {
            max-width: 1440px;
            margin: 0 auto;
            padding: 40px 24px;
        }

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

        .dashboard-grid {
            display: flex;
            gap: 28px;
            align-items: flex-start;
            flex-wrap: wrap;
        }

        .maintenance-container {
            background: var(--card-bg);
            border-radius: 16px;
            padding: 28px;
            border: 1px solid var(--border);
            box-shadow: 0 4px 20px rgba(74, 64, 58, 0.03);
            width: 100%;
        }

        .main-panel {
            flex: 1 1 65%;
        }

        .side-panel {
            flex: 1 1 30%;
        }

        .maintenance-container h5 {
            font-size: 1.2rem;
            font-weight: 700;
            margin-bottom: 22px;
            color: var(--primary);
        }

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
            padding: 16px;
            font-size: 14px;
            color: var(--text);
            border-bottom: 1px solid #f5ede4;
            vertical-align: middle;
        }

        .table tbody tr:last-child td {
            border-bottom: none;
        }

        .table tbody tr:hover {
            background: var(--hover);
        }

        .btn-update {
            background: var(--primary);
            color: white;
            border: none;
            padding: 10px 18px;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 600;
            text-decoration: none;
            transition: 0.2s ease;
            display: inline-block;
        }

        .btn-update:hover {
            color: white;
            transform: translateY(-1px);
            opacity: 0.95;
        }

        .badge-done {
            background-color: var(--success-bg);
            color: var(--success-text);
            padding: 6px 12px;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 600;
        }

        .badge-process {
            background-color: var(--warning-bg);
            color: var(--warning-text);
            padding: 6px 12px;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 600;
        }

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

        @media(max-width: 1100px){
            .dashboard-grid {
                flex-direction: column;
            }
        }
    </style>
</head>

<body>

<div class="dashboard-wrapper">

    <div class="page-header">
        <div>
            <h2>Maintenance Dashboard</h2>
            <p>Track repair schedules and monitor student reports.</p>
        </div>

        <button type="button"
                class="btn-update"
                data-bs-toggle="modal"
                data-bs-target="#addModal">

            + Key In New Repair
        </button>
    </div>

    <div class="dashboard-grid">

        <!-- MAINTENANCE TABLE -->
        <div class="maintenance-container main-panel">

            <h5>Active Repair Schedule</h5>

            <div class="table-responsive">

                <table class="table">

                    <thead>
                        <tr>
                            <th>Facility</th>
                            <th>Description</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>

                    <tbody>

                        <%
                            List<Maintenance> mList = MaintenanceDAO.getAllMaintenance();

                            if (mList == null || mList.isEmpty()) {
                        %>

                        <tr>
                            <td colspan="4" class="text-center text-muted">
                                No active maintenance logs found.
                            </td>
                        </tr>

                        <%
                            } else {

                                for (Maintenance m : mList) {
                        %>

                        <tr>

                            <td>
                                <%= m.getFacilityName()%>
                            </td>

                            <td>
                                <%= m.getDescription()%>
                            </td>

                            <td>

                                <span class="<%= m.getStatus().equalsIgnoreCase("Done")
                                        ? "badge-done"
                                        : "badge-process"%>">

                                    <%= m.getStatus()%>

                                </span>

                            </td>

                            <td>

                                <a href="Maintenance_Servlet?id=<%= m.getMaintenanceId()%>"
                                   class="btn-update">

                                    Update

                                </a>

                            </td>

                        </tr>

                        <%
                                }
                            }
                        %>

                    </tbody>

                </table>

            </div>

        </div>

        <!-- FEEDBACK TABLE -->
        <div class="maintenance-container side-panel">

            <h5>Student Reports (from Customer Care)</h5>

            <div class="table-responsive">

                <table class="table">

                    <thead>
                        <tr>
                            <th>Student</th>
                            <th>Subject</th>
                            <th>Message</th>
                        </tr>
                    </thead>

                    <tbody>

                        <%
                            List<Feedback> fList = FeedbackDAO.getAllFeedback();

                            if (fList == null || fList.isEmpty()) {
                        %>

                        <tr>
                            <td colspan="3" class="text-center text-muted">
                                No feedback found.
                            </td>
                        </tr>

                        <%
                            } else {

                                for (Feedback f : fList) {
                        %>

                        <tr>

                            <td>
                                <strong><%= f.getMatric_no()%></strong>
                            </td>

                            <td>
                                <%= f.getSubject()%>
                            </td>

                            <td>
                                <%= f.getMessage()%>
                            </td>

                        </tr>

                        <%
                                }
                            }
                        %>

                    </tbody>

                </table>

            </div>

        </div>

    </div>

    <!-- ADD MAINTENANCE MODAL -->
    <div class="modal fade" id="addModal" tabindex="-1">

        <div class="modal-dialog">

            <div class="modal-content">

                <div class="modal-header">

                    <h5 class="modal-title">
                        Report New Maintenance
                    </h5>

                    <button type="button"
                            class="btn-close"
                            data-bs-dismiss="modal">
                    </button>

                </div>

                <form action="Maintenance_Servlet" method="POST">

                    <div class="modal-body">

                        <label class="mb-2">
                            Facility
                        </label>

                        <select name="facilityId"
                                class="form-control mb-3"
                                required>

                            <option value="">
                                Select facility
                            </option>

                            <%
                                List<Facility> facilities = new FacilityDAO().getAllFacilities();

                                for (Facility facility : facilities) {
                            %>

                            <option value="<%= facility.getFacilityId()%>">
                                <%= facility.getUnitName()%> - <%= facility.getFacilityName()%>
                            </option>

                            <%
                                }
                            %>

                        </select>

                        <label class="mb-2">
                            Issue Description
                        </label>

                        <textarea name="description"
                                  class="form-control"
                                  rows="4"
                                  required></textarea>

                    </div>

                    <div class="modal-footer border-0">

                        <button type="submit"
                                class="btn-submit">

                            Save Report

                        </button>

                    </div>

                </form>

            </div>

        </div>

    </div>

</div>

<jsp:include page="footer.jsp" />

</body>
