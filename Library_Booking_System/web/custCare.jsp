

<head> 
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>custCare | EduSpace</title>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
</head>
<body>
    <jsp:include page="header.jsp" />
    <div class="container mt-5">
        <div class="maintenance-container" style="max-width: 1100px;"> <h2 class="mb-4" style="font-weight: 700; color: var(--mocha-text);">Customer Care</h2>

            <div class="row">
                <div class="col-md-5 border-end pe-4">
                    <h5 style="font-weight: 700; color: #8b4513;">Get in Touch</h5>
                    <p class="text-muted small">Need immediate help? Use the contact details below or check our hours.</p>

                    <div class="mt-4">
                        <p class="mb-1"><i class="fas fa-phone-alt me-2"></i> <strong>Hotline:</strong></p>
                        <p>+60 9-668 XXXX</p>

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
                                <option value="Others">Others</option>
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

    <%
    String success = request.getParameter("success");
    String error = request.getParameter("error");
%>

<% if("true".equals(success)) { %>

<script>
Swal.fire({
    icon: "success",
    title: "Feedback Submitted ?",
    text: "Your feedback has been successfully sent.",
    confirmButtonText: "Great!",
    confirmButtonColor: "#1a3a32",
    background: "#ffffff",
    color: "#1a3a32",
    iconColor: "#1a3a32",
    showClass: {
        popup: "animate__animated animate__fadeInDown"
    },
    hideClass: {
        popup: "animate__animated animate__fadeOutUp"
    }
});
</script>

<% } %>

<% if("true".equals(error)) { %>

<script>
Swal.fire({
    icon: "error",
    title: "Submission Failed",
    text: "Unable to send feedback.",
    confirmButtonColor: "#8b0000"
});
</script>

<% } %>
    <jsp:include page="footer.jsp" />
</body>