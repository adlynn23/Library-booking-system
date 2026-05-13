<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>EduSpace | Login</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="auth-container">
        <div class="auth-box">
            <h2>Welcome Back</h2>
            <p>Please login to manage your bookings.</p>
            
            <%-- Error Message Handling --%>
            <% if(request.getParameter("status") != null && request.getParameter("status").equals("error")) { %>
                <div style="color: #d9534f; margin-bottom: 15px; font-weight: bold;">Invalid Email or Password</div>
            <% } %>
            <% if(request.getParameter("msg") != null && request.getParameter("msg").equals("please_login")) { %>
                <div style="color: #007bff; margin-bottom: 15px;">Please login to continue.</div>
            <% } %>

            <form action="LoginServlet" method="POST">
                <div class="input-group">
                    <label>Email Address</label>
                    <input type="email" name="email" placeholder="e.g. S12345@university.edu" required>
                </div>

                <div class="input-group">
                    <label>Password</label>
                    <input type="password" name="password" placeholder="Enter your password" required>
                </div>

                <button type="submit" class="btn-auth" style="background: #007bff;">Login</button>
            </form>
            <p class="auth-footer">Don't have an account? <a href="registration.jsp">Register here</a></p>
        </div>
    </div>
</body>
</html>