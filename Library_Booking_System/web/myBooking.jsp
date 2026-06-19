<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>

<%
    HttpSession sessionUser = request.getSession(false);

    if (sessionUser == null || sessionUser.getAttribute("matricNo") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String matricNo = (String) sessionUser.getAttribute("matricNo");
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Booking | EduSpace</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <style>
            :root {
                --edu-green: #1a3a32;
                --edu-green-hover: #112621;
                --accent-gold: #d4a373;
                --text-dark: #2d3436;
            }

            body {
                background-color: #fcfaf7;
                color: var(--text-dark);
            }

            .page-title {
                color: var(--edu-green);
                font-weight: 700;
                border-left: 4px solid var(--accent-gold);
                padding-left: 12px;
                margin-bottom: 1.5rem;
                letter-spacing: -0.5px;
            }

            /* Optimized Filter Container Layout */
            .filter-bar {
                display: flex;
                gap: 16px;
                margin-bottom: 24px;
                flex-wrap: wrap;
                background: #ffffff;
                padding: 16px;
                border-radius: 12px;
                border: 1px solid rgba(0, 0, 0, 0.04);
                box-shadow: 0 4px 15px rgba(26, 58, 50, 0.02);
            }

            .filter-bar input,
            .filter-bar select {
                padding: 10px 14px;
                border-radius: 8px;
                border: 1px solid #dcdcdc;
                font-size: 0.95rem;
                outline: none;
                transition: all 0.2s ease;
                background: #ffffff;
            }

            .filter-bar input {
                flex: 1;
                min-width: 280px;
            }

            .filter-bar select {
                min-width: 160px;
            }

            .filter-bar input:focus,
            .filter-bar select:focus {
                border-color: var(--accent-gold);
                box-shadow: 0 0 0 3px rgba(212, 163, 115, 0.15);
            }

            /* Modern Table Canvas Layout Container */
            .table-card {
                background: #ffffff;
                border-radius: 16px;
                border: 1px solid rgba(0, 0, 0, 0.04);
                box-shadow: 0 8px 30px rgba(26, 58, 50, 0.03);
                overflow: hidden;
            }

            .modern-table {
                width: 100%;
                border-collapse: collapse;
                font-size: 0.95rem;
                margin-bottom: 0;
            }

            /* Symmetrical, Accessible Headers */
            .modern-table thead {
                background-color: var(--edu-green);
                color: #ffffff;
            }

            .modern-table th {
                padding: 16px 20px;
                text-align: left;
                font-weight: 600;
                font-size: 0.9rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                border: none;
            }

            .modern-table td {
                padding: 16px 20px;
                border-bottom: 1px solid #f1f1f1;
                color: #4a5568;
                vertical-align: middle;
            }

            .modern-table tbody tr {
                transition: background-color 0.2s ease;
            }

            .modern-table tbody tr:hover {
                background-color: #fdfbf7;
            }

            /* Clean Badge Micro-elements */
            .status-badge {
                padding: 6px 14px;
                border-radius: 50px;
                font-size: 0.8rem;
                font-weight: 700;
                display: inline-flex;
                align-items: center;
                gap: 6px;
                letter-spacing: 0.3px;
                text-transform: uppercase;
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

            .status-default {
                background: #f1f3f4;
                color: #3c4043;
            }

            @media (max-width: 768px) {
                .modern-table th, .modern-table td {
                    padding: 12px 14px;
                    font-size: 0.85rem;
                }
            }
        </style>

        <jsp:include page="header.jsp"/>
    </head>

    <body>

        <div class="container mt-5">
            <h2 class="page-title">My Bookings</h2>

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
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection conn = DriverManager.getConnection(
                                        "jdbc:mysql://localhost:3307/librarydb", "root", "");

                                String sql = "SELECT * FROM booking WHERE matric_no=? ORDER BY booking_date DESC";
                                PreparedStatement ps = conn.prepareStatement(sql);
                                ps.setString(1, matricNo);

                                ResultSet rs = ps.executeQuery();
                                boolean hasData = false;

                                while (rs.next()) {
                                    hasData = true;
                        %>
                        <tr>
                            <td class="fw-medium text-dark"><%= rs.getString("facility_name")%></td>
                            <td><i class="fa-regular fa-calendar me-2 text-muted"></i><%= rs.getString("booking_date")%></td>
                            <td><i class="fa-regular fa-clock me-2 text-muted"></i><%= rs.getString("start_time")%> - <%= rs.getString("end_time")%></td>
                            <td><%= rs.getString("purpose")%></td>
                            <td class="text-muted fst-italic">
                                <%= rs.getString("admin_notes") == null || rs.getString("admin_notes").trim().isEmpty() ? "No remarks attached" : rs.getString("admin_notes")%>
                            </td>
                            <td class="text-center">
                                <%
                                    String status = rs.getString("status");
                                    String badgeClass = "status-default";

                                    if ("Approved".equalsIgnoreCase(status)) {
                                        badgeClass = "status-approved";
                                    } else if ("Pending".equalsIgnoreCase(status)) {
                                        badgeClass = "status-pending";
                                    } else if ("Rejected".equalsIgnoreCase(status)) {
                                        badgeClass = "status-rejected";
                                    }
                                %>
                                <span class="status-badge <%= badgeClass%>">
                                    <%= status%>
                                </span>
                            </td>
                            <td class="text-center">

                                <%
                                    if ("Pending".equalsIgnoreCase(status)
                                            || "Approved".equalsIgnoreCase(status)) {
                                %>

                                <a href="CancelBookingServlet?bookingId=<%= rs.getInt("booking_id")%>"
                                   class="btn btn-sm btn-outline-danger"
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
                            if (!hasData) {
                        %>
                        <tr>
                            <td colspan="6" class="text-center py-5 text-muted">
                                <i class="fa-regular fa-folder-open fa-2x mb-3 d-block text-secondary"></i>
                                You haven't made any facility reservations yet.
                            </td>
                        </tr>
                        <%
                                }
                                conn.close();
                            } catch (Exception e) {
                                out.println("<tr><td colspan='6' class='text-danger text-center'>Error connecting to database: " + e.getMessage() + "</td></tr>");
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
                        // Skip the fallback empty row message if it appears
                        if (row.cells.length < 7)
                            return;

                        const facility = row.cells[0].innerText.toLowerCase();
                        const date = row.cells[1].innerText.toLowerCase();
                        const purpose = row.cells[3].innerText.toLowerCase();
                        const status = row.cells[5].innerText.toLowerCase().trim(); // Fixed Cell Index to 5

                        const matchSearch = facility.includes(searchValue) ||
                                date.includes(searchValue) ||
                                purpose.includes(searchValue);

                        const matchStatus = (statusValue === "all") || (status === statusValue);

                        if (matchSearch && matchStatus) {
                            row.style.display = "";
                        } else {
                            row.style.display = "none";
                        }
                    });
                }

                searchInput.addEventListener("input", filterTable);
                statusFilter.addEventListener("change", filterTable);
            });
        </script>
        <jsp:include page="footer.jsp" />

    </body>
</html>