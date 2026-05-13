<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Join EduSpace | Register</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            :root {
                --edu-green: #1a3a32;
                --soft-peach: #fdf0e6;
            }
            body {
                font-family: 'sans-serif';
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
                border-radius: 10px;
                font-weight: 600;
                border: none;
            }
        </style>
    </head>
    <body>
        <div class="reg-card">
            <h2 class="text-center mb-4" style="color: var(--edu-green); font-weight:700;">eduspace.</h2>
            <form action="RegisterServlet" method="POST" onsubmit="return validateForm()">
                <div class="mb-3">
                    <label class="form-label small fw-bold">Full Name</label>
                    <input type="text" class="form-control" name="fullName"  required>
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-bold">Matric No</label>
                    <input type="text" class="form-control" name="matricNo" required>
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-bold">University Email</label>
                    <input type="email" class="form-control" name="email" placeholder="" required>
                </div>

                <div class="mb-3">
                    <label class="form-label small fw-bold">Phone Number</label>
                    <input type="text" class="form-control" name="phone" required>
                </div>
                <div class="row">
                    <div class="col-6 mb-4">
                        <label class="form-label small fw-bold">Password</label>
                        <input type="password" class="form-control" id="pass" name="password" required>
                    </div>
                    <div class="col-6 mb-4">
                        <label class="form-label small fw-bold">Confirm</label>
                        <input type="password" class="form-control" id="confirm" required>
                    </div>
                </div>
                <button type="submit" class="btn-reg shadow-sm">Register Now</button>
            </form>
            <p class="text-center mt-3 small">Already have an account? <a href="login.jsp" style="color: var(--edu-green); font-weight: 700;">Login</a></p>
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
                Swal.fire('Error', 'Matric Number already exists!', 'warning');
            }
        </script>
    </body>
</html>