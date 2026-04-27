<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sign In | EduSpace</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">

    </head>
    <body>

        <div class="login-card">
            <div class="brand-name">eduspace<span style="color: #d4a373;">.</span></div>

            <h4 class="fw-bold mb-2">Welcome Back</h4>
            <p class="text-muted small mb-4">Please enter your institutional credentials to continue.</p>

            <form action="LoginServlet" method="POST">
                <div class="mb-3">
                    <label for="email" class="form-label">Institutional Email</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="name@university.edu" required>
                </div>

                <div class="mb-4">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="••••••••" required>
                </div>

                <button type="submit" class="btn-signin shadow-sm">Sign In</button>
            </form>

            <div class="register-link">
                Don't have an account? <a href="registration.jsp">Register Now</a>
            </div>
        </div>

    </body>
</html>