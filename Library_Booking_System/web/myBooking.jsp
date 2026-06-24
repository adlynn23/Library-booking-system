<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.time.format.DateTimeFormatter"%>

<%
    HttpSession sessionUser = request.getSession(false);

    if (sessionUser == null || sessionUser.getAttribute("matricNo") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String matricNo = (String) sessionUser.getAttribute("matricNo");

    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("hh:mm a");

    int totalCount = 0;
    int pendingCount = 0;
    int approvedCount = 0;
    int cancelledCount = 0;

    List<Map<String, String>> bookings = new ArrayList<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3307/librarydb", "root", "");

        String sql = "SELECT * FROM booking WHERE matric_no=? ORDER BY booking_date DESC, start_time DESC";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, matricNo);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Map<String, String> b = new HashMap<>();

            String status = rs.getString("status");

            b.put("booking_id", String.valueOf(rs.getInt("booking_id")));
            b.put("facility_name", rs.getString("facility_name"));

            b.put("booking_date",
                    rs.getDate("booking_date").toLocalDate().format(dateFormatter));

            b.put("start_time",
                    rs.getTime("start_time").toLocalTime().format(timeFormatter));

            b.put("end_time",
                    rs.getTime("end_time").toLocalTime().format(timeFormatter));

            b.put("purpose", rs.getString("purpose"));
            b.put("admin_notes", rs.getString("admin_notes"));
            b.put("status", status);

            bookings.add(b);
            totalCount++;

            if ("Pending".equalsIgnoreCase(status)) {
                pendingCount++;
            } else if ("Approved".equalsIgnoreCase(status)) {
                approvedCount++;
            } else if ("Cancelled".equalsIgnoreCase(status)) {
                cancelledCount++;
            }
        }

        conn.close();

    } catch (Exception e) {
        request.setAttribute("dbError", e.getMessage());
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Booking | EduSpace</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --edu-green: #1a3a32;
            --accent-gold: #d4a373;
            --text-dark: #2d3436;
        }

        body {
            background-color: #f5f6f7;
            color: var(--text-dark);
        }

        .page-title {
            color: var(--edu-green);
            font-weight: 800;
            border-left: 4px solid var(--accent-gold);
            padding-left: 14px;
            margin-bottom: 24px;
        }

        .summary-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(170px, 1fr));
            gap: 16px;
            margin-bottom: 24px;
        }

        .summary-card {
            background: #ffffff;
            border-radius: 14px;
            padding: 18px;
            box-shadow: 0 6px 18px rgba(26, 58, 50, 0.06);
        }

        .summary-label {
            color: #6b7280;
            font-size: 0.9rem;
            font-weight: 600;
        }

        .summary-value {
            font-size: 1.8rem;
            font-weight: 800;
            color: var(--edu-green);
            margin-top: 4px;
        }

        .filter-bar {
            display: flex;
            gap: 16px;
            margin-bottom: 24px;
            flex-wrap: wrap;
            background: #ffffff;
            padding: 16px;
            border-radius: 14px;
            box-shadow: 0 6px 18px rgba(26, 58, 50, 0.05);
        }

        .filter-bar input,
        .filter-bar select {
            padding: 11px 15px;
            border-radius: 10px;
            border: 1px solid #dcdcdc;
            font-size: 0.95rem;
            outline: none;
        }

        .filter-bar input {
            flex: 1;
            min-width: 280px;
        }

        .filter-bar select {
            min-width: 170px;
        }

        .table-card {
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(26, 58, 50, 0.06);
            overflow: hidden;
        }

        .modern-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.95rem;
            margin-bottom: 0;
        }

        .modern-table thead {
            background-color: var(--edu-green);
            color: #ffffff;
        }

        .modern-table th {
            padding: 15px 18px;
            text-align: left;
            font-weight: 700;
            font-size: 0.85rem;
            text-transform: uppercase;
        }

        .modern-table td {
            padding: 14px 18px;
            border-bottom: 1px solid #f1f1f1;
            color: #4a5568;
            vertical-align: middle;
            white-space: nowrap;
        }

        .modern-table tbody tr:hover {
            background-color: #fdfbf7;
        }

        .facility-cell {
            font-weight: 700;
            color: #111827;
        }

        .wrap-cell {
            white-space: normal !important;
        }

        .status-badge {
            padding: 7px 14px;
            border-radius: 999px;
            font-size: 0.78rem;
            font-weight: 800;
            text-transform: uppercase;
            white-space: nowrap;
        }

        .status-approved {
            background: #e6f9ed;
            color: #137333;
        }

        .status-pending {
            background: #fef7e0;
            color: #b06000;
        }

        .status-rejected {
            background: #fce8e6;
            color: #c5221f;
        }

        .status-cancelled {
            background: #f1f3f4;
            color: #3c4043;
        }

        .status-default {
            background: #eef2f7;
            color: #374151;
        }

        .cancel-btn {
            border-radius: 10px;
            font-weight: 700;
            padding: 7px 12px;
        }

        .notes-empty {
            color: #9ca3af;
            font-style: italic;
        }
    </style>

    <jsp:include page="header.jsp"/>
</head>

<body>

<div class="container mt-5 mb-5">
    <h2 class="page-title">My Bookings</h2>

    <div class="summary-grid">
        <div class="summary-card">
            <div class="summary-label">Total Bookings</div>
            <div class="summary-value"><%= totalCount %></div>
        </div>

        <div class="summary-card">
            <div class="summary-label">Pending</div>
            <div class="summary-value"><%= pendingCount %></div>
        </div>

        <div class="summary-card">
            <div class="summary-label">Approved</div>
            <div class="summary-value"><%= approvedCount %></div>
        </div>

        <div class="summary-card">
            <div class="summary-label">Cancelled</div>
            <div class="summary-value"><%= cancelledCount %></div>
        </div>
    </div>

    <div class="filter-bar">
        <input type="text" id="searchInput" placeholder="Search by facility, date, or purpose...">

        <select id="statusFilter">
            <option value="all">All Statuses</option>
            <option value="Approved">Approved</option>
            <option value="Pending">Pending</option>
            <option value="Rejected">Rejected</option>
            <option value="Cancelled">Cancelled</option>
        </select>
    </div>

    <div class="table-card">
        <table class="modern-table">
            <thead>
                <tr>
                    <th>Facility</th>
                    <th>Date</th>
                    <th>Time Slot</th>
                    <th>Purpose</th>
                    <th>Admin Notes</th>
                    <th class="text-center">Status</th>
                    <th class="text-center">Action</th>
                </tr>
            </thead>

            <tbody>
            <%
                String dbError = (String) request.getAttribute("dbError");

                if (dbError != null) {
            %>
                <tr>
                    <td colspan="7" class="text-danger text-center py-4">
                        Error connecting to database: <%= dbError %>
                    </td>
                </tr>
            <%
                } else if (bookings.isEmpty()) {
            %>
                <tr>
                    <td colspan="7" class="text-center py-5 text-muted">
                        <i class="fa-regular fa-folder-open fa-2x mb-3 d-block text-secondary"></i>
                        You haven't made any facility reservations yet.
                    </td>
                </tr>
            <%
                } else {
                    for (Map<String, String> b : bookings) {
                        String status = b.get("status");
                        String badgeClass = "status-default";

                        if ("Approved".equalsIgnoreCase(status)) {
                            badgeClass = "status-approved";
                        } else if ("Pending".equalsIgnoreCase(status)) {
                            badgeClass = "status-pending";
                        } else if ("Rejected".equalsIgnoreCase(status)) {
                            badgeClass = "status-rejected";
                        } else if ("Cancelled".equalsIgnoreCase(status)) {
                            badgeClass = "status-cancelled";
                        }

                        String notes = b.get("admin_notes");
            %>

                <tr>
                    <td class="facility-cell"><%= b.get("facility_name") %></td>

                    <td>
                        <i class="fa-regular fa-calendar me-2 text-muted"></i>
                        <%= b.get("booking_date") %>
                    </td>

                    <td>
                        <i class="fa-regular fa-clock me-2 text-muted"></i>
                        <%= b.get("start_time") %> - <%= b.get("end_time") %>
                    </td>

                    <td class="wrap-cell"><%= b.get("purpose") %></td>

                    <td class="wrap-cell">
                        <%
                            if (notes == null || notes.trim().isEmpty()) {
                        %>
                            <span class="notes-empty">-</span>
                        <%
                            } else {
                        %>
                            <%= notes %>
                        <%
                            }
                        %>
                    </td>

                    <td class="text-center">
                        <span class="status-badge <%= badgeClass %>">
                            <%= status %>
                        </span>
                    </td>

                    <td class="text-center">
                        <%
                            if ("Pending".equalsIgnoreCase(status)
                                    || "Approved".equalsIgnoreCase(status)) {
                        %>
                            <a href="CancelBookingServlet?bookingId=<%= b.get("booking_id") %>"
                               class="btn btn-sm btn-outline-danger cancel-btn"
                               onclick="return confirm('Are you sure you want to cancel this booking?');">
                                <i class="fa-solid fa-ban"></i>
                                Cancel
                            </a>
                        <%
                            } else {
                        %>
                            <span class="text-muted">-</span>
                        <%
                            }
                        %>
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

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const searchInput = document.getElementById("searchInput");
        const statusFilter = document.getElementById("statusFilter");
        const tableRows = document.querySelectorAll(".modern-table tbody tr");

        function filterTable() {
            const searchValue = searchInput.value.toLowerCase().trim();
            const statusValue = statusFilter.value.toLowerCase().trim();

            tableRows.forEach(row => {
                if (row.cells.length < 7) return;

                const facility = row.cells[0].innerText.toLowerCase();
                const date = row.cells[1].innerText.toLowerCase();
                const purpose = row.cells[3].innerText.toLowerCase();
                const status = row.cells[5].innerText.toLowerCase().trim();

                const matchSearch =
                        facility.includes(searchValue) ||
                        date.includes(searchValue) ||
                        purpose.includes(searchValue);

                const matchStatus =
                        statusValue === "all" || status === statusValue;

                row.style.display = matchSearch && matchStatus ? "" : "none";
            });
        }

        searchInput.addEventListener("input", filterTable);
        statusFilter.addEventListener("change", filterTable);
    });
</script>

<jsp:include page="footer.jsp" />

</body>
</html>