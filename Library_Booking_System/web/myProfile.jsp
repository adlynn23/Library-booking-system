<%-- 
    Document   : myProfile
    Created on : 27 Apr 2026, 4:16:06 pm
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Profile - Library Booking System</title>
<!--        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="style.css">-->
    </head>
    <body>
        <%
            // 1. Fetch data and handle nulls with empty strings to allow clean typing [cite: 1023]
            String userName = (String) session.getAttribute("userName");
            String userEmail = (String) session.getAttribute("userEmail");
            String userPhone = (String) session.getAttribute("userPhone");
            String role = (String) session.getAttribute("role"); // Ensure role is retrieved [cite: 963]

            userName = (userName != null) ? userName : "";
            userEmail = (userEmail != null) ? userEmail : "";
            userPhone = (userPhone != null) ? userPhone : "";
            role = (role != null) ? role : "Member";
        %>
        <jsp:include page="header.jsp" />
        <%-- Including your renamed header [cite: 977] --%>

        <div class="container mt-3 ">
            <%-- This container now uses the white card style from your CSS [cite: 965] --%>
            <div class="maintenance-container mx-auto" style="max-width: 600px;">
                <h2 class="mb-4" style="font-weight: 700; color: #008cc9;">My Profile </h2>

                <div class="d-flex align-items-center mb-4 p-2">
                    <div class="profile-avatar me-3">
                        <i class="fas fa-user-circle fa-4x text-primary"></i>
                    </div>
                    
                    <div class="d-flex flex-column">
                        <h4 class="mb-0" style="font-weight: 700;"><%= userName.isEmpty() ? "New User" : userName%></h4>
                        <p class="text-muted mb-0"><%= role%></p>
                    </div>
                </div>

                <form action="UpdateProfileServlet" method="POST">
                    <div class="mb-3">
                        <label class="form-label small text-muted font-weight-bold">Full Name</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-0"><i class="far fa-user text-primary"></i></span>
                                <%-- 2. REMOVED 'readonly' so you can type [cite: 1019, 1021] --%>
                            <input type="text" name="fullName" id="fullName" class="form-control bg-light border-0" value="<%= userName%>"readonly>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label small text-muted font-weight-bold">Email Address</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-0"><i class="far fa-envelope text-primary"></i></span>
                                <%-- 2. REMOVED 'readonly' --%>
                            <input type="email" name="email" id="userEmail" class="form-control bg-light border-0" value="<%= userEmail%>" readonly>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label small text-muted font-weight-bold">Phone Number</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-0"><i class="fas fa-phone-alt text-primary"></i></span>
                                <%-- 2. REMOVED 'readonly' --%>
                            <input type="text" name="phone" id="userPhone" class="form-control bg-light border-0" value="<%= userPhone%>" readonly>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label small text-muted font-weight-bold">Account Type</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-0"><i class="fas fa-shield-alt text-primary"></i></span>
                                <%-- Account type stays readonly to prevent users changing their own role [cite: 842] --%>
                            <input type="text" class="form-control bg-light border-0" value="<%= role%>" readonly>
                        </div>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="button" id="editBtn" class="btn btn-outline-primary py-3 fw-bold" onclick="enableEditing()">
                            Edit Profile
                        </button>
                        <button type="submit" id="saveBtn" class="btn btn-primary py-3 fw-bold shadow-sm d-none">
                            Save Changes
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <jsp:include page="footer.jsp" />    

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                function enableEditing() {
                                    // 1. Remove readonly from inputs
                                    document.getElementById('fullName').readOnly = false;
                                    document.getElementById('userEmail').readOnly = false;
                                    document.getElementById('userPhone').readOnly = false;

                                    // 2. Change input background to white to show they are active
                                    document.getElementById('fullName').classList.replace('bg-light', 'bg-white');
                                    document.getElementById('userEmail').classList.replace('bg-light', 'bg-white');
                                    document.getElementById('userPhone').classList.replace('bg-light', 'bg-white');
                                    // 3. Hide Edit button and show Save button
                                    document.getElementById('editBtn').classList.add('d-none');
                                    document.getElementById('saveBtn').classList.remove('d-none');

                                    // 4. Focus on the first field
                                    document.getElementById('fullName').focus();
                                }


        </script>
    </body>
</html>