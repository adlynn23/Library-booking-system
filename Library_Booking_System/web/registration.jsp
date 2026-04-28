<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create Account | EduSpace</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <style>
            :root {
                --edu-green: #1a3a32;
                --soft-peach: #fdf0e6;
            }

            body {
                font-family: 'DM Sans', sans-serif;
                background-color: var(--soft-peach);
                display: flex;
                align-items: center;
                justify-content: center;
                min-height: 100vh;
                margin: 20px 0;
            }

            .register-card {
                background: white;
                padding: 2.5rem;
                border-radius: 20px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 500px; /* Slightly wider for form fields */
            }

            .brand-name {
                font-size: 1.8rem;
                font-weight: 700;
                color: var(--edu-green);
                text-align: center;
            }

            .form-control {
                border-radius: 8px;
                margin-bottom: 0.8rem;
            }

            .btn-register {
                background-color: var(--edu-green);
                color: white;
                width: 100%;
                padding: 12px;
                border-radius: 8px;
                border: none;
                font-weight: 600;
                margin-top: 10px;
            }

            .btn-register:hover {
                background-color: #122924;
            }
        </style>
    </head>
    <body>

        <div class="register-card">
            <div class="brand-name">eduspace<span style="color: #d4a373;">.</span></div>

            <h4 class="fw-bold mb-1 text-center">Join EduSpace</h4>
            <p class="text-muted small mb-4 text-center">Create your library booking account today.</p>

            <form action="registerServlet" method="POST">

                <div class="mb-3">
                    <label for="fullName" class="form-label">Full Name</label>
                    <input type="text" class="form-control" id="fullName" name="fullName" placeholder="Enter your legal name" required>
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label">Email Address</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="name@university.edu" required>
                </div>

                <div class="mb-3">
                    <label for="phone" class="form-label">Phone Number</label>
                    <input type="tel" class="form-control" id="phone" name="phone" placeholder="+6012-3456789" required>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <div class="col-md-6 mb-4">
                        <label for="confirmPassword" class="form-label">Confirm</label>
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                    </div>
                </div>

                <button type="submit" class="btn-register shadow-sm">Create Account</button>
            </form>

            <div class="login-link">
                Already have an account? <a href="login.jsp">Sign In</a>
            </div>
        </div>

    </body>
</html>