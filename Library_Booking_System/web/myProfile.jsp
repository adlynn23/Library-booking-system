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

        <jsp:include page="header.jsp" />

        <div class="container mt-4">

            <div class="card mx-auto shadow-sm" style="max-width:600px; border-radius:15px;">
                <div class="card-body p-4">

                    <h3 class="mb-4 text-center">My Profile</h3>

                    <!-- PROFILE HEADER -->
                    <div class="text-center mb-4">
                        <i class="fas fa-user-circle fa-5x text-primary"></i>
                        <h4 class="mt-2 mb-0"><%= userName%></h4>
                        <small class="text-muted"><%= userRole%></small>
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
                                       placeholder="123456789"
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

        <script>
            function enableEdit() {

            document.getElementById("fullName").readOnly = false;
            document.getElementById("editBtn").classList.add("d-none");
            document.getElementById("saveBtn").classList.remove("d-none");
            }
            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
const params = new URLSearchParams(window.location.search); 
        if (param
    s.get("status") === "success")
    {

                    Swal.fire({
                    icon: "success",
                            title: "Updated!",
                            text: "Profile updat
                            ed successfully!"
                    });
        }

        if (params.get("status")  === "error") {
                    Swal.fire({
                    icon: "error",
                            title: "Error!",
                            text: "Something went wrong."
                    });
                }

              
                        }
                        </script>


  </body>
</html>