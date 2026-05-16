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
<html>
<head>
    <title>My Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
.table-card{
    margin-top:30px;
    background:white;
    border-radius:18px;
    box-shadow:0 15px 40px rgba(0,0,0,0.06);
    overflow:hidden;
}

/* Table base */
.modern-table{
    width:100%;
    border-collapse:collapse;
    font-size:0.95rem;
}

/* Header */
.modern-table thead{
    background:linear-gradient(90deg, #163832, #1f4d45);
    color:white;
}

.modern-table th{
    padding:16px;
    text-align:left;
    font-weight:700;
    letter-spacing:0.3px;
}

/* Body rows */
.modern-table td{
    padding:16px;
    border-bottom:1px solid #f0e6dc;
    color:#374151;
}

/* Hover effect */
.modern-table tbody tr{
    transition:0.2s ease;
}

.modern-table tbody tr:hover{
    background:#fff8f1;
    transform:scale(1.01);
}

/* Status badges */
.status-badge{
    padding:6px 12px;
    border-radius:999px;
    font-size:0.85rem;
    font-weight:700;
    display:inline-block;
}

/* Status colors */
.status-approved{
    background:#dcfce7;
    color:#166534;
}

.status-pending{
    background:#fef9c3;
    color:#854d0e;
}

.status-rejected{
    background:#fee2e2;
    color:#991b1b;
}

.status-default{
    background:#e5e7eb;
    color:#374151;
}

/* Responsive */
@media (max-width: 768px){
    .modern-table th,
    .modern-table td{
        padding:12px;
        font-size:0.85rem;
    }
}

.filter-bar{
    display:flex;
    gap:12px;
    margin:20px 0;
    flex-wrap:wrap;
}

.filter-bar input,
.filter-bar select{
    padding:12px 14px;
    border-radius:12px;
    border:1px solid #e5d6c7;
    font-size:0.95rem;
    outline:none;
    transition:0.2s ease;
    background:white;
}

.filter-bar input{
    flex:1;
    min-width:200px;
}

.filter-bar input:focus,
.filter-bar select:focus{
    border-color:#163832;
    box-shadow:0 0 0 3px rgba(22,56,50,0.12);
}
</style>

        <jsp:include page="header.jsp"/>

</head>

<body>

<div class="container mt-5">

    <h2>My Bookings</h2>

    <div class="table-card">

<table class="modern-table">

    <thead>
        <tr>
            <th>Facility</th>
            <th>Date</th>
            <th>Time</th>
            <th>Purpose</th>
            <th>Status</th>
        </tr>
    </thead>

    <tbody>
        
        <div class="filter-bar">

    <input type="text" id="searchInput" placeholder="Search facility, purpose, or date...">

    <select id="statusFilter">
        <option value="all">All Status</option>
        <option value="Approved">Approved</option>
        <option value="Pending">Pending</option>
        <option value="Rejected">Rejected</option>
    </select>

</div>

    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3307/librarydb", "root", "");

            String sql =
                "SELECT * FROM booking WHERE matric_no=? ORDER BY booking_date DESC";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, matricNo);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
    %>

        <tr>
            <td><%= rs.getString("facility_name") %></td>
            <td><%= rs.getString("booking_date") %></td>
            <td><%= rs.getString("start_time") %> - <%= rs.getString("end_time") %></td>
            <td><%= rs.getString("purpose") %></td>
            <td>
                <%
                    String status = rs.getString("status");
                    String badgeClass = "status-default";

                    if(status.equalsIgnoreCase("Approved")){
                        badgeClass = "status-approved";
                    } else if(status.equalsIgnoreCase("Pending")){
                        badgeClass = "status-pending";
                    } else if(status.equalsIgnoreCase("Rejected")){
                        badgeClass = "status-rejected";
                    }
                %>

                <span class="status-badge <%= badgeClass %>">
                    <%= status %>
                </span>
            </td>
        </tr>

    <%
            }

            conn.close();

        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    %>

    <script>

document.addEventListener("DOMContentLoaded", function(){

    const searchInput = document.getElementById("searchInput");
    const statusFilter = document.getElementById("statusFilter");
    const tableRows = document.querySelectorAll(".modern-table tbody tr");

    function filterTable(){

        const searchValue = searchInput.value.toLowerCase();
        const statusValue = statusFilter.value.toLowerCase();

        tableRows.forEach(row => {

            const facility = row.cells[0].innerText.toLowerCase();
            const date = row.cells[1].innerText.toLowerCase();
            const purpose = row.cells[3].innerText.toLowerCase();
            const status = row.cells[4].innerText.toLowerCase();

            const matchSearch =
                facility.includes(searchValue) ||
                date.includes(searchValue) ||
                purpose.includes(searchValue);

            const matchStatus =
                statusValue === "all" || status.includes(statusValue);

            if(matchSearch && matchStatus){
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
    </tbody>

</table>

</div>


</body>
</html>