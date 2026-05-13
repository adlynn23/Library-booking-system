<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>EduSpace | Library Booking System</title>
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <style>
            /* Reset Basic */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .hero-section {
                height: 100vh;
                background-image: url('https://images.unsplash.com/photo-1521587760476-6c12a4b040da?auto=format&fit=crop&q=80&w=2070'); /* Gambar Library */
                background-size: cover;
                background-position: center;
            }

            .overlay {
                height: 100vh;
                background: rgba(0, 0, 0, 0.6); /* Gelapkan gambar supaya teks nampak */
                display: flex;
                flex-direction: column;
            }

            /* Navbar */
            .navbar {
                padding: 20px 50px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }


            .nav-links a {
                color: #FFE5B4;
                text-decoration: none;
                margin-left: 20px;
                font-weight: 500;
            }

            .btn-reg {
                background-color: #5d4037; /* Dark Mocha/Brown Color [cite: 1821] */
                color: #ffffff !important;
                padding: 8px 20px;
                border-radius: 10px;
                transition: 0.3s;
                text-decoration: none;
                border: none;
            }

            .btn-reg:hover {
                background-color: #4a332c; /* Slightly darker brown on hover [cite: 1847, 1910] */
                color: #FFB07C;
            }

            /* Content */
            .hero-content {
                flex: 1;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                text-align: center;
                color: #fff;
                padding: 0 20px;
            }

            .hero-content h1 {
                font-size: 60px;
                margin-bottom: 20px;
            }

            .hero-content p {
                font-size: 20px;
                max-width: 700px;
                margin-bottom: 40px;
                line-height: 1.6;
            }

            .btn-main {
                background-color: #28a745; /* Hijau Emerald */
                color: white;
                text-decoration: none;
                padding: 15px 40px;
                font-size: 22px;
                border-radius: 50px;
                font-weight: bold;
                transition: 0.3s;
                box-shadow: 0 4px 15px rgba(0,0,0,0.3);
            }

            .btn-main:hover {
                background-color: #218838;
                transform: scale(1.05);
            }
            .navbar-brand {
                font-size: 26px;
                color: var(--edu-green) !important;
                font-weight: 700;
                letter-spacing: -0.5px;
                text-decoration: none;
            }

            .navbar-brand span {
                color: var(--accent-gold); /* The dot at the end of eduspace. */
            }

        </style> 
    </head>
    <body>
        <div class="hero-section">
            <div class="overlay">
                <nav class="navbar">
                    <a class="navbar-brand" href="index.jsp">
                        eduspace<span>.</span>
                    </a>
                    <div class="nav-links">
                        <a href="login.jsp" class="btn-reg">Login</a>
                        <a href="registration.jsp" class="btn-reg">Register</a>
                    </div>
                </nav>

                <div class="hero-content">
                    <h1>Welcome to EduSpace</h1>
                    <p>Your smart solution for library facility bookings. Reserve study rooms, computers, and more with just a few clicks.</p>
                    <!--                <a href="startBookingServlet" class="btn-main">Start Booking Now</a>
                                    <h1 class="hero-title">Better space for<br>better grades.</h1>-->
                    <p>Access real-time schedules for library facilities.</p>
                    <a href="login.jsp" class="btn-cta">Start Booking Now</a>

                </div>
            </div>
        </div>
        
    </body>
</html>