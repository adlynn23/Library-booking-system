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
        margin-bottom: 1rem;
    }

    .form-label {
        font-weight: 500;
        font-size: 0.9rem;
        color: var(--text-dark);
    }

    .form-control {
        border-radius: 10px;
        padding: 12px;
        border: 1px solid #ddd;
        margin-bottom: 1rem;
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
    }

    .btn-signin:hover {
        background-color: #122924;
        transform: translateY(-2px);
    }

    .register-link {
        text-align: center;
        margin-top: 1.5rem;
        font-size: 0.85rem;
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
            <div class="brand-name">eduspace<span style="color: #d4a373;">.</span></div>

            <p class="text-muted small mb-4">Welcome Back</p>

            <form action="loginServlet" method="POST">
                <div class="mb-3">
                    <label for="email" class="form-label"> Email</label>
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

        <script>
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get('error') === 'invalid') {
                Swal.fire({
                    icon: 'error',
                    title: 'Access Denied',
                    text: 'Account not found! Please ensure you have registered first.',
                    confirmButtonColor: '#1a3a32'
                });
            }
        </script>

    </body>
</html>