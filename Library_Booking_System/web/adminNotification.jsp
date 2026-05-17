<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>

    <title>Admin Notifications</title>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        body{
            font-family:Arial;
            background:#f5f5f5;
            padding:20px;
        }

        .notification{
            background:white;
            padding:15px;
            border-radius:10px;
            margin-bottom:15px;
            border-left:5px solid red;
            cursor:pointer;
        }

        .time{
            color:gray;
            font-size:13px;
        }
    </style>

</head>

<body>

<h2>Admin Notifications</h2>

<%

Connection conn = null;

try {

    Class.forName("com.mysql.cj.jdbc.Driver");

    conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3307/librarydb",
        "root",
        ""
    );

    String sql =
        "SELECT * FROM notification " +
        "WHERE user_id='ADMIN' AND status='UNREAD' " +
        "ORDER BY created_at DESC";

    PreparedStatement ps = conn.prepareStatement(sql);
    ResultSet rs = ps.executeQuery();

    while(rs.next()) {
%>

<div class="notification"
     onclick="openNotification(<%= rs.getInt("id") %>, `<%= rs.getString("message") %>`)">

    <h4><%= rs.getString("message") %></h4>

    <div class="time">
        <%= rs.getTimestamp("created_at") %>
    </div>

</div>

<%
    }

} catch(Exception e) {
    out.println(e);
}
%>

<script>
function openNotification(id, message) {

    Swal.fire({
        title: "Booking Request",
        text: message,
        icon: "info",
        confirmButtonText: "OK"
    }).then(() => {

        fetch("OpenNotificationServlet?id=" + id)
            .then(() => location.reload());

    });
}
</script>

</body>
</html>