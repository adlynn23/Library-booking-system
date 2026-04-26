<%-- 
    Document   : custCare
    Created on : 25 Apr 2026, 1:45:49 pm
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Care - Library Booking System</title>
        <link rel="stylesheet" type="text/css" href="css/style.css">
    </head>
    <body>
        
        <%-- 1. Include the Dynamic Header --%>
        <jsp:include page="header.jsp" />

<div class="container mt-5">
    <div class="maintenance-container" style="max-width: 1100px;"> <h2 class="mb-4" style="font-weight: 700; color: var(--mocha-text);">Customer Care</h2>
        
        <div class="row">
            <div class="col-md-5 border-end pe-4">
                <h5 style="font-weight: 700; color: #8b4513;">Get in Touch</h5>
                <p class="text-muted small">Need immediate help? Use the contact details below or check our hours.</p>
                
                <div class="mt-4">
                    <p class="mb-1"><i class="fas fa-phone-alt me-2"></i> <strong>Hotline:</strong></p>
                    <p>+60 9-668 300</p>
                    
                    <p class="mb-1"><i class="fas fa-envelope me-2"></i> <strong>Email:</strong></p>
                    <p>helpdesk@library.com</p>
                    
                    <p class="mb-1"><i class="fas fa-clock me-2"></i> <strong>Operating Hours:</strong></p>
                    <p class="small">Mon-Fri: 8AM - 10PM<br>Sat-Sun: 9AM - 6PM</p>
                </div>
            </div>

            <div class="col-md-7 ps-4">
                <h5 style="font-weight: 700; color: #8b4513;">Send us a Message</h5>
                <form action="FeedbackServlet" method="POST" class="mt-3">
                    <div class="mb-3">
                        <label class="form-label small" style="font-weight: 600;">Subject</label>
                        <select name="subject" class="form-control form-control-sm">
                            <option value="Damaged Facility">Damaged Facility</option>
                            <option value="Booking Issue">Booking Issue</option>
                            <option value="General Feedback">General Feedback</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label small" style="font-weight: 600;">Message</label>
                        <textarea name="message" class="form-control form-control-sm" rows="4" placeholder="How can we help you?" required></textarea>
                    </div>

                    <button type="submit" class="btn-submit py-2">Submit Feedback</button>
                </form>
            </div>
        </div>
    </div>
</div>

        <%-- 3. Include the Footer --%>
        <jsp:include page="footer.jsp" />
        
    </body>
</html>
