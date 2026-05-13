<%-- 
    Document   : login
    Created on : 13 May 2026, 5:44:38 pm
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
    </head>
    <body>
        <form action="LoginServlet" method="POST">
            <div class="mb-3">
                <label class="form-label small fw-bold">Matric / ID Number</label>
                <input type="text" class="form-control" name="matricNo" required>
            </div>
            <div class="mb-4">
                <label class="form-label small fw-bold">Password</label>
                <input type="password" class="form-control" name="password"  required>
            </div>
            <button type="submit" class="btn-signin shadow-sm">Sign In</button>
        </form>

        <script>
            const params = new URLSearchParams(window.location.search);
            if (params.get('status') === 'success')
                Swal.fire('Success', 'Account created! Please login.', 'success');
            if (params.get('error') === 'failed')
                Swal.fire('Login Failed', 'Invalid ID or Password.', 'error');
        </script>
    </body>
</html>
