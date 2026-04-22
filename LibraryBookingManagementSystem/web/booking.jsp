<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Book Facility | EduSpace</title>

        <style>
            :root {
                --edu-green: #1a3a32;
                --soft-peach: #fff5eb;
            }
            body {
                font-family: 'DM Sans', sans-serif;
                background-color: var(--soft-peach);
                padding-top: 50px;
            }

            .booking-card {
                background: white;
                border: none;
                border-radius: 20px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.05);
                overflow: hidden;
            }

            .card-header-custom {
                background-color: var(--edu-green);
                color: white;
                padding: 30px;
                text-align: center;
            }

            .form-label {
                font-weight: 600;
                color: #444;
                margin-bottom: 8px;
            }

            .form-control, .form-select {
                padding: 12px 15px;
                border-radius: 10px;
                border: 1px solid #e0e0e0;
                background-color: #f9f9f9;
            }

            .form-control:focus {
                border-color: var(--edu-green);
                box-shadow: 0 0 0 0.25 margin rgba(26, 58, 50, 0.1);
            }

            .btn-confirm {
                background-color: var(--edu-green);
                color: white;
                padding: 15px;
                border-radius: 10px;
                font-weight: 700;
                width: 100%;
                border: none;
                transition: 0.3s;
                margin-top: 20px;
            }
            .btn-confirm:hover {
                opacity: 0.9;
                transform: translateY(-2px);
            }

            .info-note {
                font-size: 0.85rem;
                color: #d4a373;
                background: #fff8f0;
                padding: 10px;
                border-radius: 8px;
                margin-top: 10px;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-6 col-md-8">

                    <div class="booking-card">
                        <div class="card-header-custom">
                            <h3 class="mb-0">New Reservation</h3>
                            <p class="mb-0 opacity-75">EduSpace Library Facility Booking</p>
                        </div>

                        <div class="card-body p-4 p-md-5">
                            <form action="BookingServlet" method="POST">

                                <div class="mb-4">
                                    <label for="facility" class="form-label">
                                        <i class="fas fa-door-open me-2 text-muted"></i>Select Facility
                                    </label>
                                    <select class="form-select" id="facility" name="facilityID" required>
                                        <option value="" selected disabled>Choose a room...</option>
                                        <option value="1">Mangrove Solo Study Room</option>
                                        <option value="2">Wetland Group Discussion Room</option>
                                        <option value="3">Seminar Hall A</option>
                                        <option value="4">Computer Lab 1</option>
                                    </select>
                                </div>

                                <div class="mb-4">
                                    <label for="bookingDate" class="form-label">
                                        <i class="fas fa-calendar-alt me-2 text-muted"></i>Booking Date
                                    </label>
                                    <input type="date" class="form-control" id="bookingDate" name="bookingDate" required>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-4">
                                        <label for="startTime" class="form-label">
                                            <i class="fas fa-clock me-2 text-muted"></i>Start Time
                                        </label>
                                        <input type="time" class="form-control" id="startTime" name="startTime" required>
                                    </div>
                                    <div class="col-md-6 mb-4">
                                        <label for="endTime" class="form-label">
                                            <i class="fas fa-hourglass-end me-2 text-muted"></i>End Time
                                        </label>
                                        <input type="time" class="form-control" id="endTime" name="endTime" required>
                                    </div>
                                </div>

                                <p class="info-note">
                                    <i class="fas fa-info-circle me-1"></i> 
                                    Note: Maximum booking duration is <strong>2 hours</strong> for study and discussion rooms.
                                </p>

                                <div class="mb-4 mt-4">
                                    <label for="purpose" class="form-label">
                                        <i class="fas fa-pen-nib me-2 text-muted"></i>Purpose of Booking
                                    </label>
                                    <textarea class="form-control" id="purpose" name="purpose" rows="3" placeholder="e.g. Group study for CSC3113..." required></textarea>
                                </div>

                                <button type="submit" class="btn-confirm shadow">
                                    Confirm Booking Request
                                </button>

                                <div class="text-center mt-3">
                                    <a href="dashboard.jsp" class="text-muted text-decoration-none small">Cancel and Return</a>
                                </div>

                            </form>
                        </div>
                    </div>

                </div>
            </div>
        </div>

    </body>
</html>