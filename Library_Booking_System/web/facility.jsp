<!-- facility.jsp -->

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="model.Facility"%>
<%@page import="dao.FacilityDAO"%>

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
    List<Facility> facilities
            = (List<Facility>) request.getAttribute("facilities");

    if (facilities == null) {
        facilities = new ArrayList<>();
    }

    String mode = (String) request.getAttribute("mode");

    if (mode == null) {
        mode = "all";
    }

    List<String> facilityTypes = new FacilityDAO().getFacilityTypes();
    String selectedType = request.getParameter("facilityType");
%>

<!DOCTYPE html>
<html>

    <head>

        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>Facility List | EduSpace</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&display=swap"
              rel="stylesheet">

        <style>

            :root{
                --primary:#18352f;
                --soft-bg:#f3f4f6;
                --card-bg:#ffffff;
                --border:#ece6de;
                --text:#222;
                --muted:#777;
            }

            *{
                box-sizing:border-box;
            }

            body{
                margin:0;
                font-family:'DM Sans',sans-serif;
                background:#f3f4f6;
            }

            .content-wrapper{
                padding:50px 70px;
            }

            .page-header{
                margin-bottom:40px;
            }

            .section-tag{
                display:inline-block;
                background:#ebe4dc;
                color:var(--primary);
                padding:8px 16px;
                border-radius:30px;
                font-size:0.82rem;
                font-weight:600;
                margin-bottom:18px;
            }

            .page-header h1{
                font-size:2.5rem;
                font-weight:700;
                color:var(--primary);
                margin-bottom:10px;
            }

            .page-header p{
                color:#666;
                max-width:650px;
                line-height:1.7;
            }

            /* SEARCH */

            .search-container{
                max-width:1400px;
                margin:40px auto 10px;
                padding:0 70px;
            }

            .search-box{
                background:white;
                border-radius:25px;
                padding:25px;
                display:flex;
                gap:20px;
                align-items:flex-end;
                flex-wrap:wrap;
                box-shadow:0 10px 30px rgba(0,0,0,0.05);
            }

            .search-group{
                flex:1;
                min-width:200px;
            }

            .search-group label{
                display:block;
                margin-bottom:10px;
                font-size:0.9rem;
                font-weight:700;
                color:#18352f;
            }

            .search-group select,
            .search-group input{
                width:100%;
                height:55px;
                border:1px solid #ddd;
                border-radius:14px;
                padding:0 16px;
                font-size:0.95rem;
            }

            .btn-search{
                height:55px;
                border:none;
                background:#18352f;
                color:white;
                padding:0 35px;
                border-radius:14px;
                font-weight:700;
            }

            /* GRID */

            .facility-grid{
                display:grid;
                grid-template-columns:repeat(auto-fit,minmax(320px,1fr));
                gap:30px;
            }

            /* CARD */

            .facility-card{
                background:white;
                border-radius:24px;
                overflow:hidden;
                border:1px solid #ece6de;
                transition:0.3s;
                cursor:pointer;
            }

            .facility-card:hover{
                transform:translateY(-5px);
                box-shadow:0 15px 35px rgba(0,0,0,0.08);
            }

            .facility-card.inactive{
                cursor:not-allowed;
                opacity:0.74;
            }

            .facility-card.inactive:hover{
                transform:none;
                box-shadow:none;
            }

            .facility-card.inactive .card-img{
                filter:grayscale(100%);
            }

            .status-tag{
                display:inline-block;
                margin-bottom:12px;
                padding:6px 12px;
                border-radius:30px;
                background:#f3f4f6;
                color:#6b7280;
                font-size:0.78rem;
                font-weight:700;
            }

            .inactive-reason{
                margin-top:12px;
                color:#6b7280;
                font-size:0.9rem;
                line-height:1.5;
            }

            .card-img{
                width:100%;
                height:220px;
                object-fit:cover;
            }

            .facility-content{
                padding:24px;
            }

            .facility-content h3{
                margin:0 0 10px;
                font-size:1.25rem;
                font-weight:700;
                color:#18352f;
            }

            .facility-desc{
                color:#666;
                line-height:1.6;
                margin-bottom:15px;
            }

            .facility-meta{
                margin-top:15px;
            }

            .capacity{
                background:#f5f5f5;
                padding:8px 14px;
                border-radius:30px;
                font-size:0.85rem;
            }

            .booking-info{
                margin-bottom:12px;
                color:#444;
                font-size:0.92rem;
            }

            .no-result{
                font-size:1.2rem;
                font-weight:600;
                color:#666;
            }

            @media(max-width:768px){

                .content-wrapper{
                    padding:30px 20px;
                }

                .search-container{
                    padding:0 20px;
                }

                .search-box{
                    flex-direction:column;
                    align-items:stretch;
                }

                .btn-search{
                    width:100%;
                }

            }

        </style>

    </head>

    <body>

        <jsp:include page="header.jsp" />

        <!-- SEARCH -->
        <div class="search-container">

            <form action="FacilityServlet" method="GET" onsubmit="return validateSearchDuration()">

                <div class="search-box">

                    <!-- FACILITY -->
                    <div class="search-group">

                        <label>Facility</label>

                        <select name="facilityType">

                            <option value="" <%= selectedType == null || selectedType.isEmpty() ? "selected" : ""%>>
                                All Facilities
                            </option>

                            <%
                                for (String type : facilityTypes) {
                            %>
                            <option value="<%= h(type)%>" <%= type.equals(selectedType) ? "selected" : ""%>>
                                <%= h(type)%>
                            </option>
                            <%
                                }
                            %>

                        </select>

                    </div>

                    <!-- DATE -->
                    <div class="search-group">

                        <label>Booking Date</label>

                        <input type="date"
                               name="date"
                               id="bookingDate"
                               required>

                    </div>

                    <!-- START TIME -->
                    <div class="search-group">

                        <label>Start Time</label>

                        <input type="time"
                               name="startTime"
                               required>

                    </div>

                    <!-- END TIME -->
                    <div class="search-group">

                        <label>End Time</label>

                        <input type="time"
                               name="endTime"
                               required>

                    </div>

                    <!-- BUTTON -->
                    <button type="submit"
                            class="btn-search">

                        <i class="fa-solid fa-magnifying-glass"></i>
                        Search

                    </button>

                </div>

            </form>

        </div>

        <!-- CONTENT -->
        <div class="content-wrapper">

            <div class="page-header">

                <span class="section-tag">
                    EduSpace Facilities
                </span>

                <h1>
                    Discover Our Learning Spaces
                </h1>

                <p>
                    Browse modern study environments, collaborative discussion rooms,
                    computer labs, and event spaces available for booking.
                </p>

            </div>

            <!-- FACILITY GRID -->
            <div class="facility-grid">

                <%
                    if (facilities != null && !facilities.isEmpty()) {

                        for (Facility f : facilities) {
                %>

                <%
                    boolean active = "AVAILABLE".equalsIgnoreCase(f.getStatus());
                %>

                <div class="facility-card <%= active ? "" : "inactive"%>"
                     <%= mode.equals("search") && active
                             ? "onclick=\"location.href='booking.jsp?facilityId="
                             + f.getFacilityId()
                             + "&unit=" + java.net.URLEncoder.encode(f.getUnitName(), "UTF-8")
                             + "&date=" + request.getParameter("date")
                             + "&startTime=" + request.getParameter("startTime")
                             + "&endTime=" + request.getParameter("endTime") + "'\""
                             : ""%>>

                    <img src="<%= h(f.getImageUrl())%>" class="card-img">

                    <div class="facility-content">

                        <% if (!active) { %>
                        <span class="status-tag">Not Available</span>
                        <% } %>

                        <h3><%= h(f.getUnitName())%></h3>

                        <p class="facility-desc"><%= h(f.getFacilityName())%> - <%= h(f.getDescription())%></p>

                        <% if (!active) { %>
                        <div class="inactive-reason">
                            Reason:
                            <%= h(f.getUnavailableReason() == null || f.getUnavailableReason().isEmpty()
                                    ? "Deactivated by admin"
                                    : "Under maintenance - " + f.getUnavailableReason())%>
                        </div>
                        <% } %>

                        <div class="facility-meta">
                            <span class="capacity">
                                Capacity: <%= f.getCapacity()%> person
                            </span>
                        </div>

                        <% if (mode.equals("search")) {%>
                        <div class="booking-info">
                            <p><strong>Date:</strong> <%= request.getParameter("date")%></p>
                            <p>
                                <strong>Time:</strong>
                                <%= request.getParameter("startTime")%> - <%= request.getParameter("endTime")%>
                            </p>
                        </div>
                        <% } %>

                    </div>
                </div>

                <%
                    }
                } else {
                %>

                <div class="no-result">
                    No available facilities found.
                </div>

                <%
                    }
                %>

            </div>

        </div>

        <jsp:include page="footer.jsp" />

        <script>

            // DISABLE PAST DATE

            const today =
                    new Date().toISOString().split("T")[0];

            document.getElementById("bookingDate").min = today;

            function validateSearchDuration() {
                const start = document.querySelector("input[name='startTime']").value;
                const end = document.querySelector("input[name='endTime']").value;

                if (!start || !end) {
                    return true;
                }

                const startDate = new Date("2000-01-01T" + start);
                const endDate = new Date("2000-01-01T" + end);
                const diffMinutes = (endDate - startDate) / (1000 * 60);

                if (diffMinutes <= 0) {
                    alert("End time must be after start time.");
                    return false;
                }

                if (diffMinutes > 120) {
                    alert("Maximum booking duration is 2 hours only.");
                    return false;
                }

                return true;
            }

        </script>

    </body>

</html>
