<%-- 
    Document   : register
    Created on : 8 May 2026, 11:47:56 pm
    Author     : H O N O R
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | EduSpace</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&display=swap" rel="stylesheet">
        
<style>
        :root{
            --edu-green:#163832;
            --soft-bg:#f7efe5;
        }
        body{
            margin:0;
            font-family:'DM Sans',sans-serif;
            background:var(--soft-bg);
        }
        .navbar-brand{
            height:80px;
            background:white;
            border-bottom:2px solid var(--edu-green);
            display:flex;
            justify-content:space-between;
            align-items:center;
            font-weight: 700;
            font-size: 1.5rem;
            padding:0 60px;
        }
        .btn-google{
            background:white;
            border:1px solid #ddd;
            padding:10px 18px;
            border-radius:12px;
            cursor:pointer;
        }
        .content-wrapper{
            padding:60px 20px;
        }
        .register-container{
            max-width:450px;
            margin:auto;
            background:white;
            padding:40px;
            border-radius:28px;
            box-shadow:0 10px 30px rgba(0,0,0,0.06);
        }
        .form-group{
            margin-bottom:22px;
        }
        .form-group label{
            display:block;
            margin-bottom:10px;
            color:var(--edu-green);
            font-weight:600;
        }
        .form-group input{
            width:100%;
            padding:14px;
            border:1px solid #ddd;
            border-radius:12px;
            box-sizing:border-box;
        }
        .btn-submit{
            width:100%;
            background:var(--edu-green);
            color:white;
            border:none;
            padding:15px;
            border-radius:12px;
            cursor:pointer;
            font-weight:700;
        }
        footer{
            text-align:center;
            padding:25px;
            color:#666;
        }
</style>
</head>
<body>   
    <nav class="navbar-brand">  
        <div>EduSpace.</div>
        <div style="display:flex; align-items:center; gap:15px;">            
            <button class="btn-google" onclick="location.href='index.jsp'">Back to Home</button>
        </div>
    </nav>
    
    <div class="content-wrapper">
        <div class="register-container">
            <h2 style="text-align:center; margin-top:0;">Register</h2>
            
            <form action="processRegister.jsp" method="post">
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="fullname" placeholder="Enter your full name" required>
                </div>

                <div class="form-group">
                    <label>Student ID</label>
                    <input type="text" name="studentID" placeholder="e.g. 2024123456" required>
                </div>

                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" name="email" placeholder="example@student.com" required>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" placeholder="Create a password" required>
                </div>

                <button type="submit" class="btn-submit">Create Account</button>
            </form>
            
            <p style="text-align:center; font-size:0.9rem; color:#666; margin-top:20px;">
                Already have an account? <a href="login.jsp" style="color:#0095ff; text-decoration:none;">Login here</a>
            </p>
        </div>
    </div>
        <footer class="text-center">
            <div class="container">
                <p>&copy; 2026 EduSpace System. Developed for Application Development Course.</p>
            </div>
        </footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function toggleCard(card){
        card.classList.toggle("active");
    }
</script>
</body>
</html>