<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="dao.FacilityDAO"%>
<%@page import="model.Facility"%>

<%!
    private String h(Object value) {
        if (value == null) {
            return "";
        }

        return String.valueOf(value)
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
%>

<%
    FacilityDAO facilityDAO = new FacilityDAO();
    List<Facility> facilities = facilityDAO.getAllFacilities();
%>

<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Portal | Facility Management</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&display=swap" rel="stylesheet">

        <jsp:include page="admin_header.jsp" />

        <style>
            :root{
                --primary:#163832;
                --bg:#f3f4f6;
                --card:#ffffff;
                --border:#e5e7eb;
                --text:#1f2937;
                --muted:#6b7280;
                --success-bg:#ecfdf3;
                --success-text:#027a48;
                --warning-bg:#fff7ed;
                --warning-text:#c2410c;
                --danger:#dc2626;
            }

            *{
                margin:0;
                padding:0;
                box-sizing:border-box;
            }

            body{
                font-family:'DM Sans',sans-serif;
                background-color:var(--bg);
                color:var(--text);
            }

            .page-wrapper{
                padding:40px 50px;
                background-color:var(--bg);
            }

            .page-top{
                display:flex;
                justify-content:space-between;
                align-items:center;
                gap:20px;
                margin-bottom:25px;
            }

            .page-title h2{
                font-size:2rem;
                font-weight:700;
                margin-bottom:6px;
            }

            .page-title p{
                color:var(--muted);
                margin:0;
            }

            .admin-tabs{
                display:flex;
                justify-content:center;
                margin-bottom:35px;
            }

            .tabs-wrapper{
                background:white;
                padding:8px;
                border-radius:14px;
                display:flex;
                gap:10px;
                box-shadow:0 4px 20px rgba(0,0,0,0.05);
            }

            .tab-btn{
                border:none;
                background:transparent;
                padding:12px 22px;
                border-radius:10px;
                font-weight:600;
                color:#777;
                cursor:pointer;
                transition:0.2s;
            }

            .tab-btn.active{
                background:var(--primary);
                color:white;
            }

            .admin-list-container{
                background:var(--card);
                border-radius:20px;
                padding:24px;
                border:1px solid var(--border);
                box-shadow:0 10px 30px rgba(15,23,42,0.05);
            }

            .facility-table{
                margin-bottom:0;
            }

            .facility-table th{
                color:var(--muted);
                font-size:0.78rem;
                text-transform:uppercase;
                letter-spacing:0.06em;
                border-bottom:1px solid var(--border);
            }

            .facility-table td{
                vertical-align:middle;
                padding:16px 12px;
            }

            .facility-thumb{
                width:88px;
                height:60px;
                object-fit:cover;
                border-radius:8px;
                border:1px solid var(--border);
                background:#f9fafb;
            }

            .badge-active,
            .badge-inactive{
                padding:7px 12px;
                border-radius:30px;
                font-size:0.75rem;
                font-weight:700;
                display:inline-block;
                white-space:nowrap;
            }

            .badge-active{
                background:var(--success-bg);
                color:var(--success-text);
            }

            .badge-inactive{
                background:var(--warning-bg);
                color:var(--warning-text);
            }

            .btn-primary-custom{
                background:var(--primary);
                color:white;
                border:none;
                padding:12px 20px;
                border-radius:12px;
                font-weight:600;
                cursor:pointer;
            }

            .btn-secondary-custom{
                background:#f3f4f6;
                border:none;
                color:#374151;
                padding:9px 14px;
                border-radius:10px;
                cursor:pointer;
                font-size:0.85rem;
            }

            .btn-danger-soft{
                background:#fef2f2;
                color:#b91c1c;
            }

            .icon-btn{
                width:38px;
                height:38px;
                border:none;
                border-radius:10px;
                background:#f9fafb;
                cursor:pointer;
            }

            .form-control{
                border-radius:10px;
                padding:10px 12px;
            }

            @media(max-width:768px){
                .page-wrapper{
                    padding:30px 18px;
                }

                .page-top{
                    align-items:flex-start;
                    flex-direction:column;
                }
            }
        </style>
    </head>

    <body>

        <div class="page-wrapper">

            <div class="admin-tabs">
                <div class="tabs-wrapper">
                    <button class="tab-btn" onclick="switchTab('user')">User Management</button>
                    <button class="tab-btn active" onclick="switchTab('facility')">Facility Management</button>
                </div>
            </div>

            <div id="userSection" class="admin-list-container mb-4" style="display:none;">
                <h4 class="mb-3">User Management</h4>

                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Matric No</th>
                            <th>Name</th>
                            <th>Phone</th>
                            <th>Role</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Connection conn = null;
                            PreparedStatement ps = null;
                            ResultSet rs = null;

                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");

                                conn = DriverManager.getConnection(
                                        "jdbc:mysql://localhost:3307/librarydb",
                                        "root",
                                        ""
                                );

                                ps = conn.prepareStatement("SELECT matric_no, name, phone, role FROM users");
                                rs = ps.executeQuery();

                                boolean hasData = false;

                                while (rs.next()) {
                                    hasData = true;
                        %>
                        <tr>
                            <td><%= h(rs.getString("matric_no"))%></td>
                            <td><%= h(rs.getString("name"))%></td>
                            <td><%= h(rs.getString("phone"))%></td>
                            <td><%= h(rs.getString("role"))%></td>
                        </tr>
                        <%
                                }

                                if (!hasData) {
                        %>
                        <tr>
                            <td colspan="4" class="text-center">No users found</td>
                        </tr>
                        <%
                                }
                            } catch (Exception e) {
                        %>
                        <tr>
                            <td colspan="4" class="text-danger">Error: <%= h(e.getMessage())%></td>
                        </tr>
                        <%
                            } finally {
                                if (rs != null) {
                                    rs.close();
                                }

                                if (ps != null) {
                                    ps.close();
                                }

                                if (conn != null) {
                                    conn.close();
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>

            <div id="facilitySection">
                <div class="page-top">
                    <div class="page-title">
                        <h2>Facility Management</h2>
                        <p>Manage learning spaces, room availability and facility status.</p>
                    </div>

                    <button class="btn-primary-custom" data-bs-toggle="modal" data-bs-target="#addFacilityModal">
                        <i class="fa-solid fa-plus me-2"></i>Add Facility
                    </button>
                </div>

                <div class="admin-list-container">
                    <div class="table-responsive">
                        <table class="table facility-table">
                            <thead>
                                <tr>
                                    <th>Image</th>
                                    <th>Facility</th>
                                    <th>Unit</th>
                                    <th>Description</th>
                                    <th>Capacity</th>
                                    <th>Status</th>
                                    <th class="text-end">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (facilities == null || facilities.isEmpty()) {
                                %>
                                <tr>
                                    <td colspan="7" class="text-center text-muted py-4">No facilities found.</td>
                                </tr>
                                <%
                                } else {
                                    for (Facility f : facilities) {
                                        boolean active = "AVAILABLE".equalsIgnoreCase(f.getStatus());
                                %>
                                <tr>
                                    <td>
                                        <img src="<%= h(f.getImageUrl())%>" class="facility-thumb" alt="<%= h(f.getFacilityName())%>">
                                    </td>
                                    <td><strong><%= h(f.getFacilityName())%></strong></td>
                                    <td><%= h(f.getUnitName())%></td>
                                    <td>
                                        <%= h(f.getDescription())%>
                                        <% if (!active) { %>
                                        <div class="text-muted small mt-1">
                                            Reason:
                                            <%= h(f.getUnavailableReason() == null || f.getUnavailableReason().isEmpty()
                                                    ? "Deactivated by admin"
                                                    : "Under maintenance - " + f.getUnavailableReason())%>
                                        </div>
                                        <% } %>
                                    </td>
                                    <td><%= f.getCapacity()%></td>
                                    <td>
                                        <span class="<%= active ? "badge-active" : "badge-inactive"%>">
                                            <%= active ? "Active" : "Inactive"%>
                                        </span>
                                    </td>
                                    <td class="text-end">
                                        <div class="d-inline-flex gap-2">
                                            <form action="AdminFacilityServlet" method="POST" class="m-0">
                                                <input type="hidden" name="action" value="status">
                                                <input type="hidden" name="facilityId" value="<%= f.getFacilityId()%>">
                                                <input type="hidden" name="currentStatus" value="<%= h(f.getStatus())%>">
                                                <button type="submit" class="btn-secondary-custom <%= active ? "btn-danger-soft" : ""%>">
                                                    <%= active ? "Deactivate" : "Activate"%>
                                                </button>
                                            </form>

                                            <button type="button"
                                                    class="icon-btn"
                                                    data-bs-toggle="modal"
                                                    data-bs-target="#editFacilityModal"
                                                    data-id="<%= f.getFacilityId()%>"
                                                    data-name="<%= h(f.getFacilityName())%>"
                                                    data-unit="<%= h(f.getUnitName())%>"
                                                    data-description="<%= h(f.getDescription())%>"
                                                    data-capacity="<%= f.getCapacity()%>">
                                                <i class="fa-solid fa-pen text-success"></i>
                                            </button>

                                            <form action="AdminFacilityServlet"
                                                  method="POST"
                                                  class="m-0"
                                                  onsubmit="return confirm('Delete this facility? Existing booking history will remain, but this facility will be removed from the facility list.');">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="facilityId" value="<%= f.getFacilityId()%>">
                                                <button type="submit" class="icon-btn">
                                                    <i class="fa-solid fa-trash text-danger"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                                <%
                                        }
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="addFacilityModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="AdminFacilityServlet" method="POST" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="add">

                        <div class="modal-header">
                            <h5 class="modal-title">Add Facility</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>

                        <div class="modal-body">
                            <label class="form-label">Facility Name</label>
                            <input type="text" name="facilityName" class="form-control mb-3" required>

                            <label class="form-label">Unit Name</label>
                            <input type="text" name="unitName" class="form-control mb-3" placeholder="Example: Study Room A" required>

                            <label class="form-label">Capacity</label>
                            <input type="number" name="capacity" class="form-control mb-3" min="1" required>

                            <label class="form-label">Description</label>
                            <textarea name="description" class="form-control mb-3" rows="3" required></textarea>

                            <label class="form-label">Facility Image</label>
                            <input type="file" name="imageFile" class="form-control" accept="image/*" required>
                        </div>

                        <div class="modal-footer border-0">
                            <button type="button" class="btn-secondary-custom" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn-primary-custom">Save Facility</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="modal fade" id="editFacilityModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="AdminFacilityServlet" method="POST" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="facilityId" id="editFacilityId">

                        <div class="modal-header">
                            <h5 class="modal-title">Edit Facility</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>

                        <div class="modal-body">
                            <label class="form-label">Facility Name</label>
                            <input type="text" name="facilityName" id="editFacilityName" class="form-control mb-3" required>

                            <label class="form-label">Unit Name</label>
                            <input type="text" name="unitName" id="editUnitName" class="form-control mb-3" required>

                            <label class="form-label">Capacity</label>
                            <input type="number" name="capacity" id="editCapacity" class="form-control mb-3" min="1" required>

                            <label class="form-label">Description</label>
                            <textarea name="description" id="editDescription" class="form-control mb-3" rows="3" required></textarea>

                            <label class="form-label">Replace Image</label>
                            <input type="file" name="imageFile" class="form-control" accept="image/*">
                        </div>

                        <div class="modal-footer border-0">
                            <button type="button" class="btn-secondary-custom" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn-primary-custom">Update Facility</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp" />

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function switchTab(tab) {
                const userSection = document.getElementById("userSection");
                const facilitySection = document.getElementById("facilitySection");
                const buttons = document.querySelectorAll(".tab-btn");

                buttons.forEach(btn => btn.classList.remove("active"));

                if (tab === "user") {
                    userSection.style.display = "block";
                    facilitySection.style.display = "none";
                    buttons[0].classList.add("active");
                } else {
                    userSection.style.display = "none";
                    facilitySection.style.display = "block";
                    buttons[1].classList.add("active");
                }
            }

            const editModal = document.getElementById("editFacilityModal");

            editModal.addEventListener("show.bs.modal", function (event) {
                const button = event.relatedTarget;

                document.getElementById("editFacilityId").value = button.getAttribute("data-id");
                document.getElementById("editFacilityName").value = button.getAttribute("data-name");
                document.getElementById("editUnitName").value = button.getAttribute("data-unit");
                document.getElementById("editDescription").value = button.getAttribute("data-description");
                document.getElementById("editCapacity").value = button.getAttribute("data-capacity");
            });
        </script>
    </body>

</html>
