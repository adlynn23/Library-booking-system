<%-- 
    Document   : myProfile
    Created on : 25 Apr 2026, 2:28:42 pm
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Ensure session data is available for display
    String userName = (String) session.getAttribute("userName");
    String userEmail = (String) session.getAttribute("userEmail"); // Assuming these are set at login
    String userPhone = (String) session.getAttribute("userPhone");
    String role = (String) session.getAttribute("role");
    
//    if (userName == null) userName = "Demo User";
//    if (userEmail == null) userEmail = "user@library.com";
//    if (userPhone == null) userPhone = "+1 (555) 123-4567";
//    if (role == null) role = "User";
//%>
<jsp:include page="header.jsp" />

<div class="container mt-5">
    <div class="maintenance-container" style="max-width: 650px;">
        <h2 class="mb-4" style="font-weight: 700; color: #008cc9;">Profile Management</h2>
        
        <div class="d-flex align-items-center mb-4">
            <div class="profile-avatar me-3">
                <i class="fas fa-user-circle fa-4x text-primary"></i>
            </div>
            <div>
                <h4 class="mb-0" style="font-weight: 700;"><%= userName %></h4>
                <p class="text-muted mb-0"><%= role %></p>
            </div>
        </div>

        <form action="UpdateProfileServlet" method="POST">
            <div class="mb-3">
                <label class="form-label small text-muted font-weight-bold">Full Name</label>
                <div class="input-group">
                    <span class="input-group-text bg-light border-0"><i class="far fa-user text-primary"></i></span>
                    <input type="text" name="fullName" class="form-control bg-light border-0" value="<%= userName %>" readonly>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label small text-muted font-weight-bold">Email Address</label>
                <div class="input-group">
                    <span class="input-group-text bg-light border-0"><i class="far fa-envelope text-primary"></i></span>
                    <input type="email" name="email" class="form-control bg-light border-0" value="<%= userEmail %>" readonly>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label small text-muted font-weight-bold">Phone Number</label>
                <div class="input-group">
                    <span class="input-group-text bg-light border-0"><i class="fas fa-phone-alt text-primary"></i></span>
                    <input type="text" name="phone" class="form-control bg-light border-0" value="<%= userPhone %>" readonly>
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label small text-muted font-weight-bold">Account Type</label>
                <div class="input-group">
                    <span class="input-group-text bg-light border-0"><i class="fas fa-shield-alt text-primary"></i></span>
                    <input type="text" class="form-control bg-light border-0" value="<%= role %>" readonly>
                </div>
            </div>

            <button type="submit" class="btn btn-primary w-100 py-3 shadow-sm" style="border-radius: 12px; font-weight: 700;">
                Edit Profile
            </button>
        </form>
    </div>
</div>

<jsp:include page="footer.jsp" />
