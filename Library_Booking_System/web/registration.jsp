<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>EduSpace | Join Us</title>
        <link rel="stylesheet" type="text/css" href="css/style.css">

        <style>/* Existing styles... (keep your hero-section styles) */

            .auth-container {
                height: 100vh;
                background: linear-gradient(135deg, #007bff, #28a745);
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .auth-box {
                background: white;
                padding: 40px;
                border-radius: 15px;
                box-shadow: 0 10px 25px rgba(0,0,0,0.2);
                width: 100%;
                max-width: 450px;
                text-align: center;
            }

            .auth-box h2 {
                color: #333;
                margin-bottom: 10px;
            }
            .auth-box p {
                color: #666;
                margin-bottom: 30px;
            }

            .input-group {
                text-align: left;
                margin-bottom: 20px;
            }
            .input-group label {
                display: block;
                font-weight: 600;
                margin-bottom: 5px;
                color: #444;
            }
            .input-group input {
                width: 100%;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 8px;
                font-size: 16px;
            }

            .btn-auth {
                width: 100%;
                background: #28a745;
                color: white;
                border: none;
                padding: 15px;
                border-radius: 8px;
                font-size: 18px;
                font-weight: bold;
                cursor: pointer;
                transition: 0.3s;
            }

            .btn-auth:hover {
                background: #218838;
            }
            .auth-footer {
                margin-top: 20px;
                font-size: 14px;
                color: #666;
            }
            .auth-footer a {
                color: #007bff;
                text-decoration: none;
                font-weight: bold;
            }</style>
    </head>
    <body>
        <div class="auth-container">
            <div class="auth-box">
                <h2>Create Account</h2>
                <p>Join the EduSpace community to start booking.</p>

                <form action="RegisterServlet" method="POST">
                    <div class="input-group">
                        <label>Full Name</label>
                        <input type="text" name="fullName" placeholder="Enter your name" required>
                    </div>

                    <div class="input-group">
                        <label>University Email</label>
                        <input type="email" name="email" placeholder="e.g. S12345@university.edu" required>
                        <small>Role is auto-assigned based on email (S/L/A)</small>
                    </div>

                    <div class="input-group">
                        <label>Phone Number</label>
                        <input type="text" name="phone" placeholder="012-3456789" required>
                    </div>

                    <div class="input-group">
                        <label>Password</label>
                        <input type="password" name="password" placeholder="Min 6 characters" required>
                    </div>

                    <button type="submit" class="btn-auth">Register Now</button>
                </form>
                <p class="auth-footer">Already have an account? <a href="login.jsp">Login here</a></p>
            </div>
        </div>
    </body>
</html>