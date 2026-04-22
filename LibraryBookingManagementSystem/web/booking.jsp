<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <!DOCTYPE html>
    <html lang="en">
        <head>

            <style>
                :root {
                    --edu-green: #1a3a32;
                    --soft-peach: #fff5eb;
                }
                body {
                    font-family: sans-serif;
                    background-color: #ffffff;
                    color: #333;
                }
                .main-container {
                    min-height: 100vh;
                    display: flex;
                    align-items: center;
                }
                .info-side {
                    background-color: var(--edu-green);
                    color: white;
                    padding: 60px;
                    border-radius: 0 40px 40px 0;
                    display: flex;
                    flex-direction: column;
                    justify-content: center;
                }
                .form-section-title {
                    font-weight: 700;
                    font-size: 2rem;
                    color: var(--edu-green);
                }
                .btn-submit {
                    background-color: var(--edu-green);
                    color: white;
                    border: none;
                    border-radius: 12px;
                    padding: 15px;
                    font-weight: 700;
                    width: 100%;
                    margin-top: 20px;
                }
            </style>
        </head>
        <body>

            <div class="container-fluid main-container p-0">
                <div class="row g-0 w-100">
                    <div class="col-lg-5 d-none d-lg-flex info-side shadow-lg">
                        <h1 class="display-4 fw-bold mb-4">EduSpace.</h1>
                        <p class="lead">Secure your study or discussion room in seconds.</p>
                    </div>

                    <div class="col-lg-7">
                        <div class="p-5 mx-auto" style="max-width: 600px;">
                            <h2 class="form-section-title">Book a Facility</h2>
                            <form action="BookingServlet" method="POST">
                                
                                <div class="mb-4">
                                    <label class="form-label fw-bold">DATE OF RESERVATION</label>
                                    <input type="date" class="form-control" name="bookingDate" required>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-4">
                                        <label class="form-label fw-bold">START TIME</label>
                                        <input type="time" class="form-control" name="startTime" required>
                                    </div>
                                    <div class="col-md-6 mb-4">
                                        <label class="form-label fw-bold">END TIME</label>
                                        <input type="time" class="form-control" name="endTime" required>
                                    </div>
                                </div>
                                <div class="mb-4">
                                    <label class="form-label fw-bold">PURPOSE</label>
                                    <textarea class="form-control" name="purpose" rows="4" required></textarea>
                                </div>
                                <button type="submit" class="btn-submit">SUBMIT BOOKING</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

        </body>
    </html>