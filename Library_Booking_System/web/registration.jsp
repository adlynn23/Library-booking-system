<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register | EduSpace</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&display=swap" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <style>
            :root {
                --edu-green: #1a3a32;
                --soft-peach: #fdf0e6;
                --accent-gold: #d4a373;
                --text-dark: #2d3436;
            }

            body {
                font-family: 'DM Sans', sans-serif;
                background-color: var(--soft-peach);
                display: flex;
                align-items: center;
                justify-content: center;
                min-height: 100vh;
                margin: 0;
                padding: 20px;
            }

            .register-card {
                background: white;
                padding: 2.5rem;
                border-radius: 20px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
                width: 100%;
                max-width: 450px;
            }

            .brand-name {
                font-size: 1.8rem;
                font-weight: 700;
                color: var(--edu-green);
                text-align: center;
                margin-bottom: 1.5rem;
            }

            .form-control {
                border-radius: 10px;
                padding: 12px;
                border: 1px solid #eee;
                background-color: #fcfcfc;
                transition: 0.3s;
            }

            .form-control:focus {
                border-color: var(--accent-gold);
                box-shadow: 0 0 0 0.2rem rgba(212, 163, 115, 0.1);
            }

            .btn-register {
                background-color: var(--edu-green);
                color: white;
                width: 100%;
                padding: 12px;
                border: none;
                border-radius: 10px;
                font-weight: 600;
                transition: 0.3s;
                margin-top: 0.5rem;
            }

            .btn-register:hover {
                background-color: #122924;
                transform: translateY(-2px);
                color: white;
            }

            .login-link {
                text-align: center;
                margin-top: 1.5rem;
                font-size: 0.85rem;
                color: #666;
            }

            .login-link a {
                color: var(--edu-green);
                text-decoration: none;
                font-weight: 700;
            }
        </style>
    </head>

    <body>

        <div class="register-card">

            <div class="brand-name">
                eduspace<span style="color: var(--accent-gold);">.</span>
            </div>

            <form action="RegisterServlet" method="POST" onsubmit="return validateForm()">

                <div class="mb-3">
                    <label class="form-label small fw-bold">Full Name</label>
                    <input type="text" class="form-control" name="fullName" required>
                </div>

                <div class="mb-3">
                    <label class="form-label small fw-bold">Matric Number</label>
                    <input type="text" class="form-control" name="matricNo" required>
                </div>

                <div class="mb-3">
                    <label class="form-label small fw-bold">University Email</label>
                    <input type="email" class="form-control" name="email"required>
                </div>

                <div class="mb-3">
                    <label class="form-label small fw-bold">Phone Number</label>
                    <input type="text" class="form-control" name="phone"  required>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label small fw-bold">Password</label>
                        <input type="password" class="form-control" id="pass" name="password" required>
                    </div>

                    <div class="col-md-6 mb-4">
                        <label class="form-label small fw-bold">Confirm Password</label>
                        <input type="password" class="form-control" id="confirm" required>
                    </div>
                </div>

                <button type="submit" class="btn-register shadow-sm">
                    Register Now
                </button>

            </form>

            <div class="login-link">
                Already have an account?
                <a href="login.jsp">Login here</a>
            </div>

        </div>

        <script>

            function validateForm() {

                if (document.getElementById("pass").value !== document.getElementById("confirm").value) {

                    Swal.fire({
                        icon: 'error',
                        title: 'Password Error',
                        text: 'Passwords do not match!',
                        confirmButtonColor: '#1a3a32'
                    });

                    return false;
                }

                return true;
            }

            const params = new URLSearchParams(window.location.search);

            if (params.get('error') === 'exists') {

                Swal.fire({
                    icon: 'warning',
                    title: 'Account Exists',
                    text: 'Matric Number already exists!',
                    confirmButtonColor: '#1a3a32'
                });
            }

        </script>

    </body>
</html>