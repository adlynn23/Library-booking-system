<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Make a Booking | EduSpace</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&display=swap" rel="stylesheet">

        <style>
            :root {
                --edu-green: #1a3a32;
                --soft-peach: #fff5eb;
            }
            body {
                font-family: 'DM Sans', sans-serif;
                background-color: var(--soft-peach);
                color: #333;
            }

            /* Modern Header / Navbar */
            .navbar {
                background-color: #ffffff;
                border-bottom: 2px solid var(--edu-green);
                padding: 1rem 0;
            }
            .navbar-brand {
                font-weight: 700;
                color: var(--edu-green) !important;
                font-size: 1.5rem;
            }

            /* Booking Form Container */
            .booking-container {
                max-width: 700px;
                margin: 60px auto;
                background: #ffffff;
                padding: 40px;
                border-radius: 20px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            }

            .form-label {
                font-weight: 600;
                color: var(--edu-green);
                margin-bottom: 8px;
            }
            .form-control {
                border: 1px solid #ddd;
                border-radius: 10px;
                padding: 12px;
                background-color: #fcfcfc;
            }
            .form-control:focus {
                border-color: var(--edu-green);
                box-shadow: 0 0 0 0.25rem rgba(26, 58, 50, 0.1);
            }

            .btn-submit {
                background-color: var(--edu-green);
                color: white;
                border: none;
                border-radius: 10px;
                padding: 15px;
                font-weight: 700;
                width: 100%;
                margin-top: 25px;
                transition: 0.3s;
            }
            .btn-submit:hover {
                opacity: 0.9;
                transform: translateY(-2px);
            }
        </style>
    </head>
    <body>

        <nav class="navbar navbar-expand-lg sticky-top">
            <div class="container">
                <a class="navbar-brand" href="index.jsp">EduSpace.</a>
                <div class="ms-auto">
                    <span class="text-muted me-3">Welcome, User</span>
                    <a href="logout" class="btn btn-sm btn-outline-danger rounded-pill px-3">Logout</a>
                </div>
            </div>
        </nav>

        <div class="container">
            <div class="booking-container">
                <h2 class="fw-bold mb-2">Facility Reservation</h2>
                <p class="text-muted mb-4 text-uppercase small letter-spacing-1">Fill in the fields below to request a slot</p>

                <form action="BookingServlet" method="POST">

                    <div class="mb-4">
                        <label for="bookingDate" class="form-label">BOOKING DATE</label>
                        <input type="date" class="form-control" id="bookingDate" name="bookingDate" required>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-4">
                            <label for="startTime" class="form-label">START TIME</label>
                            <input type="time" class="form-control" id="startTime" name="startTime" required>
                        </div>
                        <div class="col-md-6 mb-4">
                            <label for="endTime" class="form-label">END TIME</label>
                            <input type="time" class="form-control" id="endTime" name="endTime" required>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label for="purpose" class="form-label">PURPOSE OF BOOKING</label>
                        <textarea class="form-control" id="purpose" name="purpose" rows="4" placeholder="Describe your activity (e.g., Exam revision, Group project)" required></textarea>
                    </div>

                    <div class="p-3 rounded bg-light mb-4 border-start border-4 border-warning">
                        <small class="text-muted">
                            <i class="fas fa-info-circle me-2"></i> 
                            High-demand rooms like <strong>Mangrove</strong> or <strong>Wetland</strong> are restricted to a maximum of 2 hours per session[cite: 99, 346, 569].
                        </small>
                    </div>

                    <button type="submit" class="btn-submit shadow-sm">CONFIRM AND SUBMIT</button>

                    <div class="text-center mt-3">
                        <a href="dashboard.jsp" class="text-decoration-none text-muted small">Return to Dashboard</a>
                    </div>
                </form>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>