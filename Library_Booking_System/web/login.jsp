<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sign In | EduSpace</title>

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
                padding: 20px;
            }

            .login-card {
                background: rgba(255, 255, 255, 0.96);
                padding: 3rem 2.5rem;
                border-radius: 20px;
                box-shadow: 0 15px 35px rgba(26, 58, 50, 0.25);
                width: 100%;
                max-width: 420px;
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

            .btn-signin {
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

            .btn-signin:hover {
                background-color: var(--edu-green-hover);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(26, 58, 50, 0.2);
                color: white;
            }

            .register-link {
                text-align: center;
                margin-top: 2rem;
                font-size: 0.9rem;
                color: #555;
            }

            .register-link a {
                color: var(--edu-green);
                text-decoration: none;
                font-weight: 700;
                transition: color 0.2s;
            }
            
            .register-link a:hover {
                color: var(--accent-gold);
            }
        </style>
    </head>
    <body>

        <div class="login-card">
            <div class="brand-name">eduspace<span style="color: var(--accent-gold);">.</span></div>
            <div class="brand-sub">Library Facility Booking System</div>

            <form action="LoginServlet" method="POST">
                <div class="mb-3">
                    <label class="form-label">Matric / ID Number</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa-solid fa-id-card"></i></span>
                        <input type="text" class="form-control" name="matricNo" placeholder="e.g. S75776" required>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label">Password</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                        <input type="password" class="form-control" name="password" placeholder="••••••••" required>
                    </div>
                </div>

                <button type="submit" class="btn-signin shadow-sm">Sign In</button>
            </form>

            <div class="register-link">
                Don't have an account? <a href="registration.jsp">Register here</a>
            </div>
        </div>

        <script>
            const params = new URLSearchParams(window.location.search);

            if (params.get('status') === 'success') {
                Swal.fire({ icon: 'success', title: 'Success!', text: 'Account created! Please login.', confirmButtonColor: '#1a3a32' });
            }
            if (params.get('error') === 'user') {
                Swal.fire({ icon: 'warning', title: 'User Not Found', text: 'Matric number does not exist.', confirmButtonColor: '#1a3a32' });
            }
            if (params.get('error') === 'pass') {
                Swal.fire({ icon: 'error', title: 'Wrong Password', text: 'Incorrect password. Try again.', confirmButtonColor: '#1a3a32' });
            }
            if (params.get('error') === 'failed') {
                Swal.fire({ icon: 'error', title: 'Login Failed', text: 'Invalid credentials.', confirmButtonColor: '#1a3a32' });
            }
        </script>
    </body>
</html>