<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sign In | EduSpace</title>

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
            }

            .login-card {
                background: white;
                padding: 2.5rem;
                border-radius: 20px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
                width: 100%;
                max-width: 400px;
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

            .btn-signin {
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

            .btn-signin:hover {
                background-color: #122924;
                transform: translateY(-2px);
                color: white;
            }

            .register-link {
                text-align: center;
                margin-top: 1.5rem;
                font-size: 0.85rem;
                color: #666;
            }

            .register-link a {
                color: var(--edu-green);
                text-decoration: none;
                font-weight: 700;
            }
        </style>
    </head>
    <body>

        <div class="login-card">
            <div class="brand-name">eduspace<span style="color: var(--accent-gold);">.</span></div>
            
            <form action="LoginServlet" method="POST">
                <div class="mb-3">
                    <label class="form-label small fw-bold">Matric / ID Number</label>
                    <input type="text" class="form-control" name="matricNo" placeholder="e.g. S75776" required>
                </div>
                
                <div class="mb-4">
                    <label class="form-label small fw-bold">Password</label>
                    <input type="password" class="form-control" name="password" placeholder="••••••••" required>
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
                Swal.fire({
                    icon: 'success',
                    title: 'Success!',
                    text: 'Account created! Please login.',
                    confirmButtonColor: '#1a3a32'
                });
            }
            if (params.get('error') === 'failed') {
                Swal.fire({
                    icon: 'error',
                    title: 'Login Failed',
                    text: 'Invalid ID or Password.',
                    confirmButtonColor: '#1a3a32'
                });
            }
        </script>
    </body>
</html>