<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register | EduSpace</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <style>
            :root {
                --edu-green: #1a3a32;
                --edu-green-hover: #112621;
                --accent-gold: #d4a373;
                --text-dark: #2d3436;
            }

            body {
                font-family: 'DM Sans', sans-serif;
                /* Balanced Library Hero Background Image with Dark Overlay */
                background: linear-gradient(rgba(0, 0, 0, 0.55), rgba(0, 0, 0, 0.55)), 
                            url('https://images.unsplash.com/photo-1521587760476-6c12a4b040da?auto=format&fit=crop&q=80&w=2070');
                background-size: cover;
                background-position: center;
                background-attachment: fixed;
                display: flex;
                align-items: center;
                justify-content: center;
                min-height: 100vh;
                margin: 0;
                padding: 40px 20px;
            }

            .register-card {
                background: rgba(255, 255, 255, 0.96);
                padding: 3rem 2.5rem;
                border-radius: 20px;
                /* Soft premium shadow with slight green tint blending */
                box-shadow: 0 15px 35px rgba(26, 58, 50, 0.25);
                width: 100%;
                max-width: 550px; /* Sized up slightly to allow passwords side-by-side cleanly */
                border: 1px solid rgba(255, 255, 255, 0.8);
            }

            .brand-name {
                font-size: 2.2rem;
                font-weight: 700;
                color: var(--edu-green);
                text-align: center;
                margin-bottom: 0.5rem;
                letter-spacing: -0.5px;
            }

            .brand-sub {
                text-align: center;
                font-size: 0.9rem;
                color: #666;
                margin-bottom: 2.5rem;
            }

            .form-label {
                color: var(--text-dark);
                font-weight: 600;
                font-size: 0.85rem;
                margin-bottom: 6px;
            }

            /* Cleaner Input Fields with Explicit Micro-spacing */
            .input-group-text {
                background-color: #fcfcfc;
                border: 1px solid #dcdcdc;
                border-right: none;
                border-top-left-radius: 10px;
                border-bottom-left-radius: 10px;
                color: #888;
                padding-left: 15px;
                width: 45px;
                justify-content: center;
            }

            .form-control {
                border-top-right-radius: 10px;
                border-bottom-right-radius: 10px;
                border-top-left-radius: 0;
                border-bottom-left-radius: 0;
                padding: 12px 15px;
                border: 1px solid #dcdcdc;
                background-color: #fcfcfc;
                font-size: 0.95rem;
                transition: all 0.3s ease;
            }

            .form-control:focus {
                border-color: var(--accent-gold);
                background-color: #ffffff;
                box-shadow: none;
            }
            
            .input-group:focus-within .input-group-text {
                border-color: var(--accent-gold);
                color: var(--accent-gold);
            }

            /* Professional Button Accent */
            .btn-register {
                background-color: var(--edu-green);
                color: white;
                width: 100%;
                padding: 14px;
                border: none;
                border-radius: 10px;
                font-weight: 600;
                font-size: 1rem;
                letter-spacing: 0.5px;
                transition: all 0.3s ease;
                margin-top: 1rem;
            }

            .btn-register:hover {
                background-color: var(--edu-green-hover);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(26, 58, 50, 0.2);
                color: white;
            }
            
            .btn-register:active {
                transform: translateY(0);
            }

            .login-link {
                text-align: center;
                margin-top: 2rem;
                font-size: 0.9rem;
                color: #555;
            }

            .login-link a {
                color: var(--edu-green);
                text-decoration: none;
                font-weight: 700;
                transition: color 0.2s;
            }
            
            .login-link a:hover {
                color: var(--accent-gold);
            }
        </style>
    </head>
    <body>

        <div class="register-card">
            <div class="brand-name">eduspace<span style="color: var(--accent-gold);">.</span></div>
            <div class="brand-sub">Create your Account</div>

            <form action="RegisterServlet" method="POST" onsubmit="return validateForm()">

                <div class="mb-3">
                    <label class="form-label">Full Name</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                        <input type="text" class="form-control" name="fullName" placeholder="John Doe" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Matric Number</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa-solid fa-id-card"></i></span>
                        <input type="text" class="form-control" name="matricNo" placeholder="e.g. S75776" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">University Email</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa-solid fa-envelope"></i></span>
                        <input type="email" class="form-control" name="email" placeholder="username@student.edu" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Phone Number</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa-solid fa-phone"></i></span>
                        <input type="text" class="form-control" name="phone" placeholder="e.g. +60123456789" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Password</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                            <input type="password" class="form-control" id="pass" name="password" placeholder="••••••••" required>
                        </div>
                    </div>

                    <div class="col-md-6 mb-4">
                        <label class="form-label">Confirm Password</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-shield-halved"></i></span>
                            <input type="password" class="form-control" id="confirm" placeholder="••••••••" required>
                        </div>
                    </div>
                </div>

                <button type="submit" class="btn-register shadow-sm">Register Now</button>
            </form>

            <div class="login-link">
                Already have an account? <a href="login.jsp">Login here</a>
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