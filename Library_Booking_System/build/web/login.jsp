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

        <style>
            :root {
                --edu-green: #1a3a32;
                --soft-peach: #fff5eb;
            }

            body {
                font-family: 'DM Sans', sans-serif;
                background-color: var(--soft-peach);
                height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .login-card {
                background: white;
                padding: 50px;
                border-radius: 24px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.05);
                width: 100%;
                max-width: 450px;
            }

            .brand-name {
                color: var(--edu-green);
                font-weight: 700;
                font-size: 28px;
                text-align: center;
                margin-bottom: 30px;
            }

            .form-label {
                font-weight: 600;
                color: #555;
                font-size: 14px;
            }

            .form-control {
                border: 2px solid #f0f0f0;
                border-radius: 12px;
                padding: 12px 15px;
                background: #fafafa;
            }

            .form-control:focus {
                border-color: var(--edu-green);
                box-shadow: none;
                background: white;
            }

            .btn-signin {
                background-color: var(--edu-green);
                color: white;
                width: 100%;
                padding: 14px;
                border-radius: 12px;
                font-weight: 700;
                border: none;
                margin-top: 20px;
                transition: 0.3s;
            }

            .btn-signin:hover {
                opacity: 0.9;
                transform: translateY(-2px);
            }

            .register-link {
                text-align: center;
                margin-top: 25px;
                font-size: 14px;
                color: #888;
            }

            .register-link a {
                color: var(--edu-green);
                font-weight: 700;
                text-decoration: none;
            }
        </style>
    </head>
    <body>

        <div class="login-card">
            <div class="brand-name">eduspace<span style="color: #d4a373;">.</span></div>

            <h4 class="fw-bold mb-2">Welcome Back</h4>
            <p class="text-muted small mb-4">Please enter your institutional credentials to continue.</p>

            <form action="LoginServlet" method="POST">
                <div class="mb-3">
                    <label for="email" class="form-label">INSTITUTIONAL EMAIL</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="name@university.edu" required>
                </div>

                <div class="mb-4">
                    <label for="password" class="form-label">PASSWORD</label>
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