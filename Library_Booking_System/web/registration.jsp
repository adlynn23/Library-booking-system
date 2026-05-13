<%-- 
    Document   : registration
    Created on : 13 May 2026, 3:29:34 pm
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Join EduSpace | Register</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&display=swap" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            :root {
                --edu-green: #1a3a32;
                --soft-peach: #fdf0e6;
                --accent-gold: #d4a373;
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
            .reg-card {
                background: white;
                padding: 2.5rem;
                border-radius: 20px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
                width: 100%;
                max-width: 450px;
            }
            .btn-reg {
                background-color: var(--edu-green);
                color: white;
                width: 100%;
                padding: 12px;
                border: none;
                border-radius: 10px;
                font-weight: 600;
                transition: 0.3s;
            }
            .btn-reg:hover {
                background-color: #122924;
                transform: translateY(-2px);
            }
        </style>
    </head>
    <body>
        <div class="reg-card">
            <div class="text-center mb-4">
                <h2 style="color: var(--edu-green); font-weight: 700;">eduspace<span style="color: var(--accent-gold);">.</span></h2>
                <p class="text-muted small">Create your library account</p>
            </div>

            <form action="RegisterServlet" method="POST" onsubmit="return validateForm()">
                <div class="mb-3">
                    <label class="form-label small fw-bold">Full Name</label>
                    <input type="text" class="form-control" name="fullName" placeholder="Enter Full Name" required>
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-bold">Matric / Staff ID</label>
                    <input type="text" class="form-control" name="matricNo" placeholder="e.g. S75776" required>
                </div>
                <div class="row">
                    <div class="col-6 mb-3">
                        <label class="form-label small fw-bold">Password</label>
                        <input type="password" class="form-control" id="pass" name="password" required>
                    </div>
                    <div class="col-6 mb-3">
                        <label class="form-label small fw-bold">Confirm</label>
                        <input type="password" class="form-control" id="confirm" required>
                    </div>
                </div>
                <button type="submit" class="btn-reg shadow-sm">Register Now</button>
            </form>
            <div class="text-center mt-4 small">
                Already have an account? <a href="login.jsp" style="color: var(--edu-green); font-weight: 700; text-decoration:none;">Login</a>
            </div>
        </div>

        <script>
            function validateForm() {
                if (document.getElementById("pass").value !== document.getElementById("confirm").value) {
                    Swal.fire('Error', 'Passwords do not match!', 'error');
                    return false;
                }
                return true;
            }
            const params = new URLSearchParams(window.location.search);
            if (params.get('error') === 'exists') {
                Swal.fire('Account Exists', 'This Matric Number is already registered!', 'warning');
            }
        </script>
    </body>
</html>