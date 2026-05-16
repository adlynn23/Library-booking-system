<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>Booking Management</title>

    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        :root{
            --primary:#163832;
            --bg:#f7efe5;
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
            color:#666;
        }

        .tab-btn.active{
            background:var(--primary);
            color:white;
        }

        .content-section{ display:none; }
        .content-section.active{ display:block; }

        .card{
            background:white;
            border-radius:25px;
            padding:30px;
            box-shadow:0 10px 30px rgba(0,0,0,0.05);
        }

        table{
            width:100%;
            border-collapse:collapse;
        }

        th, td{
            padding:15px;
            border-bottom:1px solid #eee;
        }

        .status{
            padding:6px 12px;
            border-radius:999px;
            font-size:12px;
        }

        .approved{ background:#dcfce7; color:#166534; }
        .rejected{ background:#fee2e2; color:#991b1b; }

        .approve-btn{
            background:#163832;
            color:white;
            border:none;
            padding:10px 14px;
            border-radius:10px;
            cursor:pointer;
        }

        .approve-btn:hover{
            opacity:0.9;
        }

    </style>
        <jsp:include page="header.jsp"/>

</head>

<body>

<h1>Booking Management</h1>

<div class="top-nav">

    <button class="tab-btn active" onclick="showTab('bookingList', this)">
        Booking List
    </button>

    <button class="tab-btn" onclick="showTab('bookingApproval', this)">
        Booking Approval
    </button>

</div>

<!-- ================= BOOKING LIST ================= -->
<div id="bookingList" class="content-section active">

<div class="card">

<table>
<thead>
<tr>
    <th>Matric No</th>
    <th>Facility</th>
    <th>Date</th>
    <th>Status</th>
    <th>Notes</th>
</tr>
</thead>

<tbody>

<%
try {

    Connection conn =
        DriverManager.getConnection(
            "jdbc:mysql://localhost:3307/librarydb",
            "root",
            ""
        );

    String sql =
        "SELECT * FROM booking WHERE status != 'PENDING' ORDER BY created_at DESC";

    PreparedStatement ps = conn.prepareStatement(sql);
    ResultSet rs = ps.executeQuery();

    while(rs.next()){

        String status = rs.getString("status");
        String badge = "";

        if(status.equalsIgnoreCase("APPROVED")){
            badge = "approved";
        } else {
            badge = "rejected";
        }

%>

<tr>
    <td><%= rs.getString("matric_no") %></td>
    <td><%= rs.getString("facility_name") %></td>
    <td><%= rs.getString("booking_date") %></td>

    <td>
        <span class="status <%= badge %>">
            <%= status %>
        </span>
    </td>

    <td>
        <%= rs.getString("admin_notes") == null ? "-" : rs.getString("admin_notes") %>
    </td>
</tr>

<%
    }

    conn.close();

} catch(Exception e){
    out.println(e);
}
%>

</tbody>
</table>

</div>
</div>

<!-- ================= BOOKING APPROVAL ================= -->
<div id="bookingApproval" class="content-section">

<div class="card">

<%
try {

    Connection conn =
        DriverManager.getConnection(
            "jdbc:mysql://localhost:3307/librarydb",
            "root",
            ""
        );

    String sql =
        "SELECT * FROM booking WHERE status='PENDING' ORDER BY created_at DESC";

    PreparedStatement ps = conn.prepareStatement(sql);
    ResultSet rs = ps.executeQuery();

    while(rs.next()){

%>

<div style="border:1px solid #eee; padding:20px; margin-bottom:15px; border-radius:15px;">

    <h5><%= rs.getString("matric_no") %></h5>

    <p>Facility: <%= rs.getString("facility_name") %></p>
    <p>Date: <%= rs.getString("booking_date") %></p>
    <p>Time: <%= rs.getString("start_time") %> - <%= rs.getString("end_time") %></p>
    <p>Purpose: <%= rs.getString("purpose") %></p>

    <button class="approve-btn"
            data-bs-toggle="modal"
            data-bs-target="#bookingModal"
            onclick="openModal(<%= rs.getInt("booking_id") %>)">
        Review
    </button>

</div>

<%
    }

    conn.close();

} catch(Exception e){
    out.println(e);
}
%>

</div>
</div>

<!-- ================= MODAL ================= -->
<div class="modal fade" id="bookingModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">

      <div class="modal-header">
        <h5 class="modal-title">Update Booking</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <form action="UpdateBookingServlet" method="post">

        <div class="modal-body">

            <input type="hidden" name="booking_id" id="booking_id">

            <label>Status</label>
            <select name="status" class="form-control">
                <option value="APPROVED">Approve</option>
                <option value="REJECTED">Reject</option>
                <option value="PENDING">Pending</option>
            </select>

            <br>

            <label>Notes</label>
            <textarea name="admin_notes" class="form-control"></textarea>

        </div>

        <div class="modal-footer">
            <button type="submit" class="btn btn-primary">Update</button>
        </div>

      </form>

    </div>
  </div>
</div>

<!-- ================= SCRIPT ================= -->
<script>

function showTab(tabId, btn){

    document.querySelectorAll(".content-section")
        .forEach(el => el.classList.remove("active"));

    document.getElementById(tabId).classList.add("active");

    document.querySelectorAll(".tab-btn")
        .forEach(b => b.classList.remove("active"));

    btn.classList.add("active");
}

function openModal(id){
    document.getElementById("booking_id").value = id;
}

</script>

</body>
</html>