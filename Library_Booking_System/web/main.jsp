<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard | EduSpace</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-5">
    <div class="container">
        <div class="card p-4 shadow-sm">
            <h2>Welcome, <%= session.getAttribute("sess_name") %>!</h2>
            <p class="text-muted">You are logged in as a <b><%= session.getAttribute("sess_role") %></b></p>
            <hr>
            <p><b>Email:</b> <%= session.getAttribute("sess_email") %></p>
            <a href="login.jsp" class="btn btn-danger mt-3">Logout</a>
        </div>
    </div>
</body>
</html>