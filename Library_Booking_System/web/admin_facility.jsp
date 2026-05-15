<%-- 
    Document   : admin_facility
    Created on : 8 May 2026, 11:49:30 pm
    Author     : H O N O R
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Portal | Facility Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&display=swap" rel="stylesheet">

        <style>
            :root{
                --edu-green:#163832;
                --soft-bg:#f7efe5;
                --danger:#ff4d4d;
            }
            /* BODY */
            body{
                margin:0;
                font-family:'DM Sans',sans-serif;
                background:var(--soft-bg);
            }
            /* NAVBAR */
            .top-admin-nav{
                height:85px;
                background:white;
                border-bottom:2px solid var(--edu-green);
                display:flex;
                justify-content:space-between;
                align-items:center;
                padding:0 60px;
            }
            .navbar-brand{
                font-weight: 700;
                color: var(--edu-green) !important;
                font-size: 1.5rem;
            }

            /* MENU */
            .admin-menu-horizontal{
                display:flex;
                gap:15px;
                list-style:none;
            }
            .admin-menu-horizontal li{
                padding:12px 18px;
                border-radius:12px;
                cursor:pointer;
                font-weight:600;
            }
            .admin-menu-horizontal li.active{
                background:var(--edu-green);
                color:white;
            }
            /* CONTENT */
            .content-wrapper{
                padding:50px 60px;
            }
            /* CONTAINER */
            .admin-list-container{
                background:white;
                border-radius:25px;
                padding:20px 30px;
                box-shadow:0 10px 25px rgba(0,0,0,0.05);
            }
            /* ROW */
            .admin-row{
                display:flex;
                justify-content:space-between;
                align-items:center;
                padding:22px 0;
                border-bottom:1px solid #eee;
                cursor:pointer;
            }
            .admin-row:last-child{
                border-bottom:none;
            }
            /* UNIT LIST */
            .admin-unit-list{
                max-height:0;
                overflow:hidden;
                transition:max-height 0.4s ease;
                background:#fcfaf7;
            }
            .admin-row.active + .admin-unit-list{
                max-height:600px;
                padding:15px 0;
            }
            /* UNIT ROW */
            .unit-management-row{
                display:flex;
                justify-content:space-between;
                align-items:center;
                padding:14px 0;
                border-bottom:1px dashed #ddd;
            }
            /* BUTTONS */
            .btn-add{
                background:var(--edu-green);
                color:white;
                border:none;
                padding:12px 18px;
                border-radius:12px;
                cursor:pointer;
                font-weight:600;
            }
            .btn-delete-unit{
                background:white;
                color:var(--danger);
                border:1px solid var(--danger);
                padding:8px 12px;
                border-radius:10px;
                cursor:pointer;
            }
            /* BUTTONS */
            .btn-signup{
                background:var(--edu-green);
                color:white;
                border:none;
                padding:10px 14px;
                border-radius:10px;
                cursor:pointer;
                font-weight:600;
            }
            .btn-google{
                background:white;
                border:1px solid #ddd;
                padding:10px 18px;
                border-radius:12px;
                cursor:pointer;
            }
            /* ACTIVE BADGE */
            .badge-active{
                background:#e6fcf5;
                color:#20c997;
                padding:4px 10px;
                border-radius:20px;
                font-size:0.75rem;
                font-weight:bold;
                margin-left:10px;
            }
            /* DEACTIVATE BUTTON */
            .btn-deactivate{
                background:#f1f3f5;
                color:#495057;
                border:none;
                padding:8px 14px;
                border-radius:10px;
                cursor:pointer;
            }
            /* EDIT BUTTON */
            .btn-edit-icon{
                background:var(--edu-green);
                color:white;
                border:none;
                width:36px;
                height:36px;
                border-radius:10px;
                cursor:pointer;
            }
            /* FOOTER */
            footer{
                text-align:center;
                padding:30px;
                color:#666;
            }
            .btn-light:hover{
                transform:translateY(-2px);
                transition:0.2s;
            }
        </style>
    </head>
    <body>
        <jsp:include page="admin_header.jsp" />
        <div style="margin-top: 70px; padding: 0 50px;">
            <div style="display:flex; justify-content:center; margin-bottom:30px;">
                <div style="background:white; padding:8px; border-radius:12px; display:flex; box-shadow:0 2px 10px rgba(0,0,0,0.05);">
                    <button onclick="switchTab('user')" style="background:none; border:none; padding:10px 25px; cursor:pointer; color:#999;">User Management</button>
                    <button style="background:#163832; color:white; border:none; padding:10px 25px; border-radius:8px; font-weight:bold;">Facility Management</button>
                </div>
            </div>

            <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
                <h2 style="margin:0;">Facility List</h2>
                <button class="btn-add" onclick="addFacility()">+ Add Facility</button>
            </div>
            <div class="admin-list-container">

                <div class="admin-row" onclick="toggleAccordion(this)">
                    <div style="display:flex; gap:20px; align-items:center;">            
                        <div>
                            <div style="display:flex; align-items:center;">
                                <h3 style="margin:0;">Study Room</h3>
                                <span class="badge-active">Active</span>
                            </div>
                            <p style="margin:5px 0; color:#666; font-size:0.85rem;">Quiet individual study room</p>
                            <small style="color:#999;">Total: 5 Units</small>
                        </div>
                    </div>
                    <div onclick="event.stopPropagation();">
                        <button class="btn-deactivate" onclick="toggleStatus(this, 'Study Room')">Deactivate All</button>
                        <button class="btn btn-light border btn-sm rounded-3" onclick="editFacility('Study Room')">
                            <i class="fa-solid fa-pen text-success"></i>️</button>
                    </div>
                </div>
                <div class="admin-unit-list">
                    <% for (int i = 1; i <= 5; i++) {%>
                    <div class="unit-management-row">
                        <span>Study Room <%= (char) ('A' + i - 1)%> <small class="badge-active">Active</small></span>
                        <div>
                            <button class="btn-deactivate" style="font-size:0.7rem; padding:4px 8px;" onclick="toggleStatus(this, 'Study Room <%= (char) ('A' + i - 1)%>')">Deactivate</button>
                            <button style="background:none; border:none; cursor:pointer;" onclick="editRoom('Study Room <%= (char) ('A' + i - 1)%>')"><i class="fa-solid fa-pen text-success"></i>️</button>
                            <button class="btn btn-light border-danger btn-sm rounded-3" onclick="deleteRoom('Study Room <%= (char) ('A' + i - 1)%>')"><i class="fa-solid fa-trash text-danger"></i>️</button>
                        </div>
                    </div>
                    <% }%>
                </div>

                <div class="admin-row" onclick="toggleAccordion(this)">
                    <div style="display:flex; gap:20px; align-items:center;">

                        <div>
                            <div style="display:flex; align-items:center;">
                                <h3 style="margin:0;">Group Discussion Room</h3>
                                <span class="badge-active">Active</span>
                            </div>
                            <p style="margin:5px 0; color:#666; font-size:0.85rem;">Collaborative space</p>
                            <small style="color:#999;">Total: 2 Units</small>
                        </div>
                    </div>
                    <div onclick="event.stopPropagation();">
                        <button class="btn-deactivate" onclick="toggleStatus(this, 'Group Discussion')">Deactivate All</button>
                        <button class="btn btn-light border btn-sm rounded-3" onclick="editFacility('Group Discussion')"><i class="fa-solid fa-pen text-success"></i>️</button>
                    </div>
                </div>
                <div class="admin-unit-list">
                    <div class="unit-management-row">
                        <span>Discussion Room 1 <small class="badge-active">Active</small></span>
                        <div>
                            <button class="btn-deactivate" style="font-size:0.7rem; padding:4px 8px;" onclick="toggleStatus(this, 'Room 1')">Deactivate</button>
                            <button style="background:none; border:none; cursor:pointer;" onclick="editRoom('Room 1')"><i class="fa-solid fa-pen text-success"></i>️</button>
                            <button class="btn btn-light border-danger btn-sm rounded-3" onclick="deleteRoom('Room 1')"><i class="fa-solid fa-trash text-danger"></i>️</button>
                        </div>
                    </div>
                    <div class="unit-management-row">
                        <span>Discussion Room 2 <small class="badge-active">Active</small></span>
                        <div>
                            <button class="btn-deactivate" style="font-size:0.7rem; padding:4px 8px;" onclick="toggleStatus(this, 'Room 2')">Deactivate</button>
                            <button style="background:none; border:none; cursor:pointer;" onclick="editRoom('Room 2')"><i class="fa-solid fa-pen text-success"></i>️</button>
                            <button class="btn btn-light border-danger btn-sm rounded-3" onclick="deleteRoom('Room 2')"><i class="fa-solid fa-trash text-danger"></i>️</button>
                        </div>
                    </div>
                </div>

                <div class="admin-row" onclick="toggleAccordion(this)">
                    <div style="display:flex; gap:20px; align-items:center;">           
                        <div>
                            <div style="display:flex; align-items:center;">
                                <h3 style="margin:0;">Computer Lab</h3>
                                <span class="badge-active">Active</span>
                            </div>
                            <p style="margin:5px 0; color:#666; font-size:0.85rem;">High-performance computers</p>
                            <small style="color:#999;">Total: 2 Units</small>
                        </div>
                    </div>
                    <div onclick="event.stopPropagation();">
                        <button class="btn-deactivate" onclick="toggleStatus(this, 'Computer Lab')">Deactivate All</button>
                        <button class="btn btn-light border btn-sm rounded-3" onclick="editFacility('Computer Lab')"><i class="fa-solid fa-pen text-success"></i>️</button>
                    </div>
                </div>
                <div class="admin-unit-list">
                    <div class="unit-management-row">
                        <span>Computer Lab 1 <small class="badge-active">Active</small></span>
                        <div>
                            <button class="btn-deactivate" style="font-size:0.7rem; padding:4px 8px;" onclick="toggleStatus(this, 'Lab 1')">Deactivate</button>
                            <button style="background:none; border:none; cursor:pointer;" onclick="editRoom('Lab 1')"><i class="fa-solid fa-pen text-success"></i>️️</button>
                            <button class="btn btn-light border-danger btn-sm rounded-3" onclick="deleteRoom('Lab 1')"><i class="fa-solid fa-trash text-danger"></i>️️</button>
                        </div>
                    </div>
                    <div class="unit-management-row">
                        <span>Computer Lab 2 <small class="badge-active">Active</small></span>
                        <div>
                            <button class="btn-deactivate" style="font-size:0.7rem; padding:4px 8px;" onclick="toggleStatus(this, 'Lab 2')">Deactivate</button>
                            <button style="background:none; border:none; cursor:pointer;" onclick="editRoom('Lab 2')"><i class="fa-solid fa-pen text-success"></i>️</button>
                            <button class="btn btn-light border-danger btn-sm rounded-3" onclick="deleteRoom('Lab 2')"><i class="fa-solid fa-trash text-danger"></i>️</button>
                        </div>
                    </div>
                </div>

                <div class="admin-row" onclick="toggleAccordion(this)">
                    <div style="display:flex; gap:20px; align-items:center;">

                        <div>
                            <div style="display:flex; align-items:center;">
                                <h3 style="margin:0;">Seminar Hall</h3>
                                <span class="badge-active">Active</span>
                            </div>
                            <p style="margin:5px 0; color:#666; font-size:0.85rem;">Large auditorium for events</p>
                            <small style="color:#999;">Total: 1 Unit</small>
                        </div>
                    </div>
                    <div onclick="event.stopPropagation();">
                        <button class="btn-deactivate" onclick="toggleStatus(this, 'Seminar Hall')">Deactivate All</button>
                        <button class="btn btn-light border btn-sm rounded-3" onclick="editFacility('Seminar Hall')"><i class="fa-solid fa-pen text-success"></i>️</button>
                    </div>
                </div>
                <div class="admin-unit-list">
                    <div class="unit-management-row">
                        <span>Main Seminar Hall <small class="badge-active">Active</small></span>
                        <div>
                            <button class="btn-deactivate" style="font-size:0.7rem; padding:4px 8px;" onclick="toggleStatus(this, 'Main Hall')">Deactivate</button>
                            <button style="background:none; border:none; cursor:pointer;" onclick="editRoom('Main Hall')"><i class="fa-solid fa-pen text-success"></i>️</button>
                            <button class="btn btn-light border-danger btn-sm rounded-3" onclick="deleteRoom('Main Hall')"><i class="fa-solid fa-trash text-danger"></i>️</button>
                        </div>
                    </div>
                </div>

            </div>

        </div>

        <script>
            function toggleAccordion(row) {
                row.classList.toggle('active');
            }

            function toggleStatus(btn, name) {
                const container = btn.closest('.admin-row') || btn.closest('.unit-management-row');
                const badge = container.querySelector('.badge-active');

                if (btn.innerText.includes("Deactivate")) {
                    if (confirm("Deactivate " + name + "?")) {
                        badge.innerText = "Inactive";
                        badge.style.background = "#f1f3f5";
                        badge.style.color = "#495057";
                        btn.innerText = (btn.innerText.includes("All")) ? "Activate All" : "Activate";
                        btn.style.background = "#20c997";
                        btn.style.color = "white";
                    }
                } else {
                    badge.innerText = "Active";
                    badge.style.background = "#e6fcf5";
                    badge.style.color = "#20c997";
                    btn.innerText = (btn.innerText.includes("All")) ? "Deactivate All" : "Deactivate";
                    btn.style.background = "#f1f3f5";
                    btn.style.color = "#495057";
                }
            }

            function editRoom(n) {
                alert("Editing Room: " + n);
            }
            function deleteRoom(n) {
                if (confirm("Confirm DELETE " + n + "?"))
                    alert("Deleted");
            }
            function addRoom(f) {
                alert("Add room for " + f);
            }
            function logout() {
                if (confirm("Logout?"))
                    window.location.href = 'login.jsp';
            }
            function addFacility() {
                alert("Add Facility Modal");
            }
            function editFacility(n) {
                alert("Editing Facility: " + n);
            }
            function switchTab(t) {
                if (t === 'user')
                    alert("Switch to User Management");
            }
        </script>
        <footer class="text-center">
            <div class="container">
                <p>&copy; 2026 EduSpace System. Developed for Application Development Course.</p>
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>