<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head> 
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Care | EduSpace</title>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    
    <style>
        :root {
            --edu-green: #1a3a32;
            --edu-green-hover: #112621;
            --accent-gold: #d4a373;
            --text-dark: #2d3436;
        }

        /* Dashboard Canvas Area Wrap */
        .support-wrapper {
            background: #ffffff;
            border: 1px solid rgba(0, 0, 0, 0.05);
            border-radius: 16px;
            box-shadow: 0 4px 24px rgba(26, 58, 50, 0.03);
            padding: 3rem 2.5rem;
            margin-bottom: 4rem;
        }

        .page-title {
            color: var(--edu-green);
            font-weight: 700;
            border-left: 4px solid var(--accent-gold);
            padding-left: 12px;
            margin-bottom: 2rem;
            letter-spacing: -0.5px;
        }

        .section-heading {
            font-weight: 700; 
            color: var(--edu-green);
            margin-bottom: 1rem;
        }

        /* Clean Styled Form Components */
        .form-label {
            font-weight: 600;
            font-size: 0.85rem;
            color: var(--text-dark);
            margin-bottom: 6px;
        }

        .form-control, .form-select {
            border-radius: 8px;
            padding: 10px 14px;
            border: 1px solid #dcdcdc;
            background-color: #fcfcfc;
            font-size: 0.95rem;
            transition: all 0.2s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--accent-gold);
            background-color: #ffffff;
            box-shadow: 0 0 0 3px rgba(212, 163, 115, 0.15);
        }

        /* Branded Submit Terminal Action */
        .btn-submit {
            background-color: var(--edu-green);
            color: white;
            font-weight: 600;
            border-radius: 8px;
            padding: 12px 24px;
            border: none;
            transition: all 0.2s ease;
            width: 100%;
        }

        .btn-submit:hover {
            background-color: var(--edu-green-hover);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(26, 58, 50, 0.15);
            color: white;
        }

        .contact-item i {
            color: var(--accent-gold);
            width: 24px;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="container mt-5">
        <div class="support-wrapper mx-auto" style="max-width: 1100px;"> 
            
            <h2 class="page-title">Customer Care</h2>

            <div class="row g-5">
                <div class="col-md-5 border-end pe-md-5">
                    <h5 class="section-heading">Get in Touch</h5>
                    <p class="text-muted small mb-4">Need immediate help? Use the contact details below or check our operating hours framework.</p>

                    <div class="mt-4 dashboard-contact-list">
                        <div class="contact-item mb-3">
                            <p class="mb-1"><i class="fas fa-phone-alt"></i> <strong>Hotline:</strong></p>
                            <p class="text-secondary ps-4">+60 9-668 XXXX</p>
                        </div>

                        <div class="contact-item mb-3">
                            <p class="mb-1"><i class="fas fa-envelope"></i> <strong>Email:</strong></p>
                            <p class="text-secondary ps-4">helpdesk@library.com</p>
                        </div>

                        <div class="contact-item mb-3">
                            <p class="mb-1"><i class="fas fa-clock"></i> <strong>Operating Hours:</strong></p>
                            <p class="small text-secondary ps-4">
                                Mon-Fri: 8AM - 10PM<br>
                                Sat-Sun: 9AM - 6PM
                            </p>
                        </div>
                    </div>
                </div>

                <div class="col-md-7 ps-md-5">
                    <h5 class="section-heading">Send us a Message</h5>
                    
                    <form action="FeedbackServlet" method="POST" class="mt-4">
                        <div class="mb-3">
                            <label class="form-label">Subject</label>
                            <select name="subject" class="form-select">
                                <option value="Damaged Facility">Damaged Facility</option>
                                <option value="Booking Issue">Booking Issue</option>
                                <option value="General Feedback">General Feedback</option>
                                <option value="Others">Others</option>
                            </select>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Message</label>
                            <textarea name="message" class="form-control" rows="5" placeholder="How can we help you today?" required></textarea>
                        </div>

                        <button type="submit" class="btn-submit">Submit Feedback</button>
                    </form>
                </div>
            </div>
            
        </div>
    </div>

    <%
        String success = request.getParameter("success");
        String error = request.getParameter("error");
    %>

    <% if("true".equals(success)) { %>
    <script>
    Swal.fire({
        icon: "success",
        title: "Feedback Submitted!",
        text: "Your message has been successfully sent to our team.",
        confirmButtonText: "Great!",
        confirmButtonColor: "#1a3a32",
        showClass: { popup: "animate__animated animate__fadeInDown" },
        hideClass: { popup: "animate__animated animate__fadeOutUp" }
    });
    </script>
    <% } %>

    <% if("true".equals(error)) { %>
    <script>
    Swal.fire({
        icon: "error",
        title: "Submission Failed",
        text: "Unable to send feedback. Please try again later.",
        confirmButtonColor: "#e63946"
    });
    </script>
    <% } %>
    
    <jsp:include page="footer.jsp" />
</body>
</html>