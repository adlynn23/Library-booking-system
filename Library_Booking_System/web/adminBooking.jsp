<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>Booking Management</title>

    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700;800&display=swap" rel="stylesheet">

    <style>

        :root{
            --primary:#163832;
            --bg:#f7efe5;
            --card:#ffffff;
            --border:#e8ddd1;
            --text:#2d3748;
            --muted:#718096;
        }

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
        }

        body{
            font-family:'DM Sans',sans-serif;
            background:var(--bg);
            padding:40px;
        }

        h1{
            font-size:2.2rem;
            color:var(--text);
            margin-bottom:30px;
        }

        /* TAB BUTTONS */

        .top-nav{
            width:fit-content;
            background:white;
            padding:10px;
            border-radius:18px;
            display:flex;
            gap:10px;
            margin:0 auto 40px;
            box-shadow:0 5px 20px rgba(0,0,0,0.05);
        }

        .tab-btn{
            border:none;
            padding:14px 28px;
            border-radius:12px;
            background:transparent;
            font-weight:700;
            cursor:pointer;
            transition:0.2s ease;
            color:#666;
        }

        .tab-btn.active{
            background:var(--primary);
            color:white;
        }

        /* CONTENT */

        .content-section{
            display:none;
        }

        .content-section.active{
            display:block;
        }

        /* CARD */

        .card{
            background:white;
            border-radius:25px;
            padding:30px;
            box-shadow:0 10px 30px rgba(0,0,0,0.05);
        }

        /* SEARCH & FILTER */

        .top-tools{
            display:flex;
            gap:15px;
            margin-bottom:25px;
            flex-wrap:wrap;
        }

        .search-box,
        .filter-select{
            padding:14px;
            border-radius:12px;
            border:1px solid var(--border);
            outline:none;
            font-size:0.95rem;
        }

        .search-box{
            flex:1;
            min-width:250px;
        }

        /* TABLE */

        table{
            width:100%;
            border-collapse:collapse;
        }

        thead{
            background:#f8f8f8;
        }

        th{
            text-align:left;
            padding:18px;
            color:#444;
            font-weight:700;
        }

        td{
            padding:18px;
            border-bottom:1px solid #f1f1f1;
            color:#555;
        }

        tr:hover{
            background:#fcfaf7;
        }

        /* STATUS */

        .status{
            padding:7px 14px;
            border-radius:999px;
            font-size:0.82rem;
            font-weight:700;
        }

        .approved{
            background:#dcfce7;
            color:#166534;
        }

        .pending{
            background:#fef3c7;
            color:#92400e;
        }

        .rejected{
            background:#fee2e2;
            color:#991b1b;
        }

        /* APPROVAL CARD */

        .approval-card{
            border:1px solid #eee;
            border-radius:20px;
            padding:25px;
            margin-bottom:20px;
        }

        .approval-title{
            font-size:1.1rem;
            font-weight:700;
            margin-bottom:15px;
            color:var(--text);
        }

        .approval-detail{
            margin-bottom:8px;
            color:var(--muted);
        }

        textarea{
            width:100%;
            border-radius:12px;
            border:1px solid var(--border);
            padding:14px;
            margin-top:15px;
            resize:none;
            min-height:90px;
            font-family:'DM Sans',sans-serif;
            outline:none;
        }

        /* BUTTONS */

        .action-buttons{
            display:flex;
            gap:10px;
            margin-top:15px;
        }

        .approve-btn,
        .reject-btn{
            flex:1;
            border:none;
            padding:12px;
            border-radius:12px;
            color:white;
            font-weight:700;
            cursor:pointer;
        }

        .approve-btn{
            background:#16a34a;
        }

        .reject-btn{
            background:#dc2626;
        }

        /* ALERT */

        .success-box{
            background:#dcfce7;
            color:#166534;
            padding:15px;
            border-radius:14px;
            margin-bottom:20px;
            font-weight:700;
        }

    </style>
        <jsp:include page="admin_header.jsp"/>

</head>

<body>

<%
    String success = request.getParameter("success");
%>

<h1>Booking Management</h1>

<div class="top-nav">

    <button class="tab-btn active"
            onclick="showTab('bookingList', this)">
        Booking List
    </button>

    <button class="tab-btn"
            onclick="showTab('bookingApproval', this)">
        Booking Approval
    </button>

</div>

<% if(success != null){ %>

<div class="success-box">
    ? Booking status updated successfully!
</div>

<% } %>

<!-- BOOKING LIST -->

<div id="bookingList"
     class="content-section active">

    <div class="card">

        <div class="top-tools">

            <input type="text"
                   class="search-box"
                   id="searchInput"
                   placeholder="Search booking...">

            <select class="filter-select"
                    id="statusFilter">

                <option value="all">All Status</option>
                <option value="APPROVED">Approved</option>
                <option value="PENDING">Pending</option>
                <option value="REJECTED">Rejected</option>

            </select>

        </div>

        <table id="bookingTable">

            <thead>
                <tr>
                    <th>Student</th>
                    <th>Facility</th>
                    <th>Date</th>
                    <th>Status</th>
                    <th>Notes</th>
                </tr>
            </thead>

            <tbody>

            <%

                try{

                    Class.forName("com.mysql.cj.jdbc.Driver");

                    Connection conn =
                        DriverManager.getConnection(
                            "jdbc:mysql://localhost:3307/librarydb",
                            "root",
                            ""
                        );

                    String sql =
                        "SELECT * FROM booking ORDER BY created_at DESC";

                    PreparedStatement ps =
                        conn.prepareStatement(sql);

                    ResultSet rs =
                        ps.executeQuery();

                    while(rs.next()){

                        String status =
                            rs.getString("status");

                        String badgeClass = "pending";

                        if(status.equalsIgnoreCase("APPROVED")){
                            badgeClass = "approved";
                        }
                        else if(status.equalsIgnoreCase("REJECTED")){
                            badgeClass = "rejected";
                        }

            %>

                <tr>

                    <td>
                        <%= rs.getString("matric_no") %>
                    </td>

                    <td>
                        <%= rs.getString("facility_name") %>
                    </td>

                    <td>
                        <%= rs.getString("booking_date") %>
                    </td>

                    <td>
                        <span class="status <%= badgeClass %>">
                            <%= status %>
                        </span>
                    </td>

                    <td>
                        <%= rs.getString("admin_notes") == null
                            ? "-"
                            : rs.getString("admin_notes") %>
                    </td>

                </tr>

            <%
                    }
            %>

            </tbody>

        </table>

    </div>

</div>

<!-- BOOKING APPROVAL -->

<div id="bookingApproval"
     class="content-section">

    <div class="card">

    <%

        String pendingSql =
            "SELECT * FROM booking WHERE status='PENDING' ORDER BY created_at DESC";

        PreparedStatement pendingPs =
            conn.prepareStatement(pendingSql);

        ResultSet pendingRs =
            pendingPs.executeQuery();

        while(pendingRs.next()){

    %>

        <div class="approval-card">

            <div class="approval-title">
                <%= pendingRs.getString("matric_no") %>
            </div>

            <div class="approval-detail">
                ? Facility:
                <%= pendingRs.getString("facility_name") %>
            </div>

            <div class="approval-detail">
                ? Date:
                <%= pendingRs.getString("booking_date") %>
            </div>

            <div class="approval-detail">
                ? Time:
                <%= pendingRs.getString("start_time") %>
                -
                <%= pendingRs.getString("end_time") %>
            </div>

            <div class="approval-detail">
                ? Purpose:
                <%= pendingRs.getString("purpose") %>
            </div>

            <form action="UpdateBookingStatusServlet"
                  method="post">

                <input type="hidden"
                       name="booking_id"
                       value="<%= pendingRs.getInt("booking_id") %>">

                <textarea name="admin_notes"
                          placeholder="Add notes for student..."></textarea>

                <div class="action-buttons">

                    <button type="submit"
                            name="status"
                            value="APPROVED"
                            class="approve-btn">

                        Approve

                    </button>

                    <button type="submit"
                            name="status"
                            value="REJECTED"
                            class="reject-btn">

                        Reject

                    </button>

                </div>

            </form>

        </div>

    <%
        }

        conn.close();

        }catch(Exception e){
            out.println(e);
        }

    %>

    </div>

</div>

<script>

    /* TAB SWITCH */

    function showTab(tabId, button){

        document.querySelectorAll(".content-section")
            .forEach(section => {
                section.classList.remove("active");
            });

        document.getElementById(tabId)
            .classList.add("active");

        document.querySelectorAll(".tab-btn")
            .forEach(btn => {
                btn.classList.remove("active");
            });

        button.classList.add("active");
    }

    /* SEARCH + FILTER */

    const searchInput =
        document.getElementById("searchInput");

    const statusFilter =
        document.getElementById("statusFilter");

    const table =
        document.getElementById("bookingTable");

    searchInput.addEventListener("keyup", filterTable);
    statusFilter.addEventListener("change", filterTable);

    function filterTable(){

        const search =
            searchInput.value.toLowerCase();

        const status =
            statusFilter.value.toLowerCase();

        const rows =
            table.getElementsByTagName("tr");

        for(let i = 1; i < rows.length; i++){

            const row = rows[i];

            const text =
                row.innerText.toLowerCase();

            const rowStatus =
                row.cells[3].innerText.toLowerCase();

            const matchSearch =
                text.includes(search);

            const matchStatus =
                status === "all" ||
                rowStatus.includes(status);

            row.style.display =
                matchSearch && matchStatus
                ? ""
                : "none";
        }
    }

</script>

</body>
</html>