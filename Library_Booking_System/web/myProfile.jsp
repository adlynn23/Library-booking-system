<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("userRole");
    String matricNo = (String) session.getAttribute("matricNo");
    String userPhone = (String) session.getAttribute("userPhone");

    if (userName == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    userPhone = (userPhone != null) ? userPhone : "";
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>My Profile</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>

    <body>

     <% if ("Admin".equalsIgnoreCase(userRole)) { %>
            <jsp:include page="admin_header.jsp" />
        <% } else { %>
            <jsp:include page="header.jsp" />
        <% } %>

        <div class="container mt-4">

            <div class="card mx-auto shadow-sm" style="max-width:600px; border-radius:15px;">
                <div class="card-body p-4">

                    <h3 class="mb-4 text-center">My Profile</h3>

                    <!-- PROFILE HEADER -->
   <div class="text-center mb-5 d-flex flex-column align-items-center">
    
    <div class="position-relative" style="width: 120px; height: 120px; display: block; margin: 0 auto;">
        
        <div class="w-100 h-100 rounded-circle d-flex align-items-center justify-content-center" 
             style="background-color: rgba(26, 58, 50, 0.05); border: 2px dashed rgba(214, 163, 115, 0.3);">
            <i class="fa-solid fa-user-gear" style="font-size: 3.5rem; color: #1a3a32; line-height: 1; display: inline-block; margin: 0; padding: 0;"></i>
        </div>
        
        <% if ("Admin".equalsIgnoreCase(userRole)) { %>
            <span class="position-absolute bg-danger text-white rounded-circle d-flex align-items-center justify-content-center shadow-sm" 
                  style="width: 32px; height: 32px; bottom: 0; right: 0; border: 3px solid #ffffff; font-size: 0.8rem; z-index: 10;" 
                  title="Admin Access Verified">
                <i class="fa-solid fa-shield-halved" style="margin: 0; padding: 0; font-size: 0.8rem; color: white !important;"></i>
            </span>
        <% } %>
        
    </div>
    
    <h3 class="mt-4 fw-bold mb-0 text-dark" style="letter-spacing: -0.5px;"><%= userName %></h3>
    <span class="badge text-secondary border px-3 py-2 mt-2 rounded-pill fw-semibold small text-uppercase tracking-wider" 
          style="background-color: rgba(0,0,0,0.02); font-size: 0.75rem;">
        <%= userRole %> Panel Access
    </span>
</div>

                    <!-- FORM -->
                    <form action="UpdateProfileServlet" method="POST">

                        <!-- NAME -->
                        <div class="mb-3">
                            <label>Full Name</label>
                            <input type="text" id="fullName" name="fullName"
                                   class="form-control"
                                   value="<%= userName%>" readonly>
                        </div>

                        <!-- MATRIC (READ ONLY) -->
                        <div class="mb-3">
                            <label>Matric No</label>
                            <input type="text"
                                   class="form-control"
                                   value="<%= matricNo%>" readonly>
                        </div>

                        <div class="mb-3">
                            <label class="form-label small text-muted font-weight-bold">Phone Number</label>

                            <div class="input-group">

                                <input type="text"
                                       name="phone"
                                       id="userPhone"
                                       class="form-control bg-light border-0"
                                       value="<%= userPhone%>"
                                       readonly>
                            </div>
                        </div>

                        <!-- ROLE (READ ONLY) -->
                        <div class="mb-3">
                            <label>Account Type</label>
                            <input type="text"
                                   class="form-control"
                                   value="<%= userRole%>" readonly>
                        </div>
                        <!-- PASSWORD SECTION -->
                        <hr>

                        <h5 class="mt-3">Change Password</h5>

                        <div class="mb-3">
                            <label>Current Password</label>
                            <input type="password"
                                   name="currentPassword"
                                   id="currentPassword"
                                   class="form-control"
                                   placeholder="Enter current password"
                                   disabled>
                        </div>

                        <div class="mb-3">
                            <label>New Password</label>
                            <input type="password"
                                   name="newPassword"
                                   id="newPassword"
                                   class="form-control"
                                   placeholder="Enter new password"
                                   disabled>
                        </div>

                        <div class="mb-3">
                            <label>Confirm Password</label>
                            <input type="password"
                                   name="confirmPassword"
                                   id="confirmPassword"
                                   class="form-control"
                                   placeholder="Confirm new password"
                                   disabled>
                        </div>
                        <!-- BUTTONS -->
                        <div class="d-grid gap-2">

                            <button type="button"
                                    id="editBtn"
                                    class="btn btn-outline-primary"
                                    onclick="enableEdit()">
                                Edit Profile
                            </button>

                            <button type="submit"
                                    id="saveBtn"
                                    class="btn btn-success d-none">
                                Save Changes
                            </button>

                        </div>

                    </form>

                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp" />

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <script>
                                        function enableEdit() {

                                            document.getElementById("fullName").readOnly = false;
                                            document.getElementById("userPhone").readOnly = false;

                                            document.getElementById("currentPassword").disabled = false;
                                            document.getElementById("newPassword").disabled = false;
                                            document.getElementById("confirmPassword").disabled = false;

                                            document.getElementById("fullName").classList.remove("bg-light");
                                            document.getElementById("userPhone").classList.remove("bg-light");

                                            document.getElementById("editBtn").classList.add("d-none");
                                            document.getElementById("saveBtn").classList.remove("d-none");
                                        }
                                        const params = new URLSearchParams(window.location.search);

                                        if (params.get("status") === "success") {

                                            Swal.fire({
                                                icon: "success",
                                                title: "Updated!",
                                                text: "Profile updated successfully!",
                                                confirmButtonColor: "#198754"
                                            });
                                        }

                                        if (params.get("status") === "error") {

                                            Swal.fire({
                                                icon: "error",
                                                title: "Error!",
                                                text: "Something went wrong.",
                                                confirmButtonColor: "#dc3545"
                                            });
                                        }
        </script>

    </body>
</html>