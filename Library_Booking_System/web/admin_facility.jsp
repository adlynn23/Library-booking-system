<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>Admin Portal | Facility Management</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&display=swap"
              rel="stylesheet">
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

            /* PAGE */
            .page-wrapper{
                padding:40px 50px;
            }

            /* TOP */
            .page-top{
                display:flex;
                justify-content:space-between;
                align-items:center;
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

            /* TABS */
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

            /* CARD */
            .admin-list-container{
                background:var(--card);
                border-radius:24px;
                padding:10px 30px;
                border:1px solid var(--border);
                box-shadow:0 10px 30px rgba(15,23,42,0.05);
            }

            /* FACILITY ROW */
            .admin-row{
                display:flex;
                justify-content:space-between;
                align-items:center;
                padding:28px 0;
                border-bottom:1px solid #f1f1f1;
                cursor:pointer;
                transition:0.2s;
            }

            .admin-row:hover{
                background:#fafafa;
            }

            .admin-row:last-child{
                border-bottom:none;
            }

            .facility-info h3{
                font-size:1.2rem;
                margin-bottom:6px;
            }

            .facility-info p{
                font-size:0.9rem;
                color:var(--muted);
                margin-bottom:4px;
            }

            .facility-info small{
                color:#9ca3af;
            }

            /* BADGE */
            .badge-active{
                background:var(--success-bg);
                color:var(--success-text);
                padding:6px 12px;
                border-radius:30px;
                font-size:0.75rem;
                font-weight:700;
                margin-left:10px;
            }

            /* UNIT LIST */
            .admin-unit-list{
                max-height:0;
                overflow:hidden;
                transition:max-height 0.4s ease;
            }

            .admin-row.active + .admin-unit-list{
                max-height:600px;
                padding-bottom:20px;
            }

            /* UNIT */
            .unit-management-row{
                display:flex;
                justify-content:space-between;
                align-items:center;
                padding:16px 10px;
                border-top:1px solid #f3f4f6;
            }

            /* BUTTONS */
            .btn-primary-custom{
                background:var(--primary);
                color:white;
                border:none;
                padding:12px 20px;
                border-radius:12px;
                font-weight:600;
                cursor:pointer;
                transition:0.2s;
            }

            .btn-primary-custom:hover{
                opacity:0.92;
                transform:translateY(-1px);
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

            .icon-btn{
                width:36px;
                height:36px;
                border:none;
                border-radius:10px;
                background:#f9fafb;
                cursor:pointer;
                transition:0.2s;
            }

            .icon-btn:hover{
                background:#f3f4f6;
            }

        </style>

    </head>

    <body>



        <div class="page-wrapper">

            <!-- TABS -->
            <div class="admin-tabs">

                <div class="tabs-wrapper">

                    <button class="tab-btn"
                            onclick="switchTab('user')">
                        User Management
                    </button>

                    <button class="tab-btn active">
                        Facility Management
                    </button>

                </div>

            </div>

            <!-- TOP -->
            <div class="page-top">

                <div class="page-title">
                    <h2>Facility Management</h2>
                    <p>
                        Manage learning spaces, room availability and facility status.
                    </p>
                </div>

                <button class="btn-primary-custom"
                        onclick="addFacility()">
                    + Add Facility
                </button>

            </div>

            <!-- CARD -->
            <div class="admin-list-container">

                <!-- STUDY ROOM -->
                <div class="admin-row"
                     onclick="toggleAccordion(this)">

                    <div class="facility-info">

                        <div class="d-flex align-items-center">

                            <h3>Study Room</h3>

                            <span class="badge-active">
                                Active
                            </span>

                        </div>

                        <p>
                            Quiet individual study room
                        </p>

                        <small>
                            Total: 5 Units
                        </small>

                    </div>

                    <div onclick="event.stopPropagation();">

                        <button class="btn-secondary-custom"
                                onclick="toggleStatus(this, 'Study Room')">
                            Deactivate All
                        </button>

                        <button class="icon-btn"
                                onclick="editFacility('Study Room')">

                            <i class="fa-solid fa-pen text-success"></i>

                        </button>

                    </div>

                </div>

                <div class="admin-unit-list">

                    <% for (int i = 1; i <= 5; i++) {%>

                    <div class="unit-management-row">

                        <span>
                            Study Room <%= (char) ('A' + i - 1)%>
                            <small class="badge-active">Active</small>
                        </span>

                        <div class="d-flex gap-2">

                            <button class="btn-secondary-custom"
                                    onclick="toggleStatus(this, 'Room')">
                                Deactivate
                            </button>

                            <button class="icon-btn">

                                <i class="fa-solid fa-pen text-success"></i>

                            </button>

                            <button class="icon-btn">

                                <i class="fa-solid fa-trash text-danger"></i>

                            </button>

                        </div>

                    </div>

                    <% }%>

                </div>

                <!-- DISCUSSION ROOM -->
                <div class="admin-row"
                     onclick="toggleAccordion(this)">

                    <div class="facility-info">

                        <div class="d-flex align-items-center">

                            <h3>Group Discussion Room</h3>

                            <span class="badge-active">
                                Active
                            </span>

                        </div>

                        <p>
                            Collaborative discussion space
                        </p>

                        <small>
                            Total: 2 Units
                        </small>

                    </div>

                    <div onclick="event.stopPropagation();">

                        <button class="btn-secondary-custom">
                            Deactivate All
                        </button>

                        <button class="icon-btn">

                            <i class="fa-solid fa-pen text-success"></i>

                        </button>

                    </div>

                </div>

                <!-- COMPUTER LAB -->
                <div class="admin-row"
                     onclick="toggleAccordion(this)">

                    <div class="facility-info">

                        <div class="d-flex align-items-center">

                            <h3>Computer Lab</h3>

                            <span class="badge-active">
                                Active
                            </span>

                        </div>

                        <p>
                            High-performance computers with specialized software
                        </p>

                        <small>
                            Total: 2 Units
                        </small>

                    </div>

                    <div onclick="event.stopPropagation();">

                        <button class="btn-secondary-custom">
                            Deactivate All
                        </button>

                        <button class="icon-btn">

                            <i class="fa-solid fa-pen text-success"></i>

                        </button>

                    </div>

                </div>

                <div class="admin-unit-list">

                    <div class="unit-management-row">

                        <span>
                            Computer Lab A
                            <small class="badge-active">Active</small>
                        </span>

                        <div class="d-flex gap-2">

                            <button class="btn-secondary-custom">
                                Deactivate
                            </button>

                            <button class="icon-btn">

                                <i class="fa-solid fa-pen text-success"></i>

                            </button>

                            <button class="icon-btn">

                                <i class="fa-solid fa-trash text-danger"></i>

                            </button>

                        </div>

                    </div>

                    <div class="unit-management-row">

                        <span>
                            Computer Lab B
                            <small class="badge-active">Active</small>
                        </span>

                        <div class="d-flex gap-2">

                            <button class="btn-secondary-custom">
                                Deactivate
                            </button>

                            <button class="icon-btn">

                                <i class="fa-solid fa-pen text-success"></i>

                            </button>

                            <button class="icon-btn">

                                <i class="fa-solid fa-trash text-danger"></i>

                            </button>

                        </div>

                    </div>

                </div>

                <!-- SEMINAR HALL -->
                <div class="admin-row"
                     onclick="toggleAccordion(this)">

                    <div class="facility-info">

                        <div class="d-flex align-items-center">

                            <h3>Seminar Hall</h3>

                            <span class="badge-active">
                                Active
                            </span>

                        </div>

                        <p>
                            Large auditorium for presentations and events
                        </p>

                        <small>
                            Total: 2 Units
                        </small>

                    </div>

                    <div onclick="event.stopPropagation();">

                        <button class="btn-secondary-custom">
                            Deactivate All
                        </button>

                        <button class="icon-btn">

                            <i class="fa-solid fa-pen text-success"></i>

                        </button>

                    </div>

                </div>

                <div class="admin-unit-list">

                    <div class="unit-management-row">

                        <span>
                            Auditorium A
                            <small class="badge-active">Active</small>
                        </span>

                        <div class="d-flex gap-2">

                            <button class="btn-secondary-custom">
                                Deactivate
                            </button>

                            <button class="icon-btn">

                                <i class="fa-solid fa-pen text-success"></i>

                            </button>

                            <button class="icon-btn">

                                <i class="fa-solid fa-trash text-danger"></i>

                            </button>

                        </div>

                    </div>

                    <div class="unit-management-row">

                        <span>
                            Auditorium B
                            <small class="badge-active">Active</small>
                        </span>

                        <div class="d-flex gap-2">

                            <button class="btn-secondary-custom">
                                Deactivate
                            </button>

                            <button class="icon-btn">

                                <i class="fa-solid fa-pen text-success"></i>

                            </button>

                            <button class="icon-btn">

                                <i class="fa-solid fa-trash text-danger"></i>

                            </button>

                        </div>

                    </div>

                </div>

                <!-- MEDIA ROOM -->
                <div class="admin-row"
                     onclick="toggleAccordion(this)">

                    <div class="facility-info">

                        <div class="d-flex align-items-center">

                            <h3>Media Production Room</h3>

                            <span class="badge-active">
                                Active
                            </span>

                        </div>

                        <p>
                            Professional recording and editing equipment
                        </p>

                        <small>
                            Total: 1 Unit
                        </small>

                    </div>

                    <div onclick="event.stopPropagation();">

                        <button class="btn-secondary-custom">
                            Deactivate All
                        </button>

                        <button class="icon-btn">

                            <i class="fa-solid fa-pen text-success"></i>

                        </button>

                    </div>

                </div>

                <div class="admin-unit-list">

                    <div class="unit-management-row">

                        <span>
                            Media Space
                            <small class="badge-active">Active</small>
                        </span>

                        <div class="d-flex gap-2">

                            <button class="btn-secondary-custom">
                                Deactivate
                            </button>

                            <button class="icon-btn">

                                <i class="fa-solid fa-pen text-success"></i>

                            </button>

                            <button class="icon-btn">

                                <i class="fa-solid fa-trash text-danger"></i>

                            </button>

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

                const container =
                        btn.closest('.admin-row')
                        || btn.closest('.unit-management-row');

                const badge =
                        container.querySelector('.badge-active');

                if (btn.innerText.includes("Deactivate")) {

                    badge.innerText = "Inactive";
                    badge.style.background = "#f3f4f6";
                    badge.style.color = "#6b7280";

                    btn.innerText =
                            btn.innerText.includes("All")
                            ? "Activate All"
                            : "Activate";

                } else {

                    badge.innerText = "Active";
                    badge.style.background = "#ecfdf3";
                    badge.style.color = "#027a48";

                    btn.innerText =
                            btn.innerText.includes("All")
                            ? "Deactivate All"
                            : "Deactivate";

                }

            }

            function addFacility() {
                alert("Add Facility");
            }

            function editFacility(name) {
                alert("Editing " + name);
            }

            function switchTab(tab) {

                if (tab === 'user') {
                    alert("Switch to User Management");
                }

            }

        </script>
 <jsp:include page="admin_header.jsp" />

    </body>
</html>