<!-- facility.jsp -->

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>

<%@page import="model.Facility"%>

<%
    List<Facility> facilities =
        (List<Facility>) request.getAttribute("facilities");

    if (facilities == null) {
        facilities = new ArrayList<>();
    }
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
                --success:#2e9d62;
            }

            *{
                box-sizing:border-box;
            }

            body{
                margin:0;
                font-family:'DM Sans',sans-serif;
                background: #f3f4f6;
                color:var(--text);
            }

            .content-wrapper{
                padding:50px 70px;
                background-color:#f3f4f6 !important;

            }

            h1{
                font-size:2.2rem;
                font-weight:700;
                color:var(--primary);
                margin-bottom:35px;
                letter-spacing:-1px;
            }
            .page-header{
                margin-bottom:45px;
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
                font-size:2.7rem;
                font-weight:700;
                color:var(--primary);
                letter-spacing:-1.5px;
                margin-bottom:12px;
                line-height:1.1;
            }

            .page-header p{
                max-width:650px;
                color:#666;
                font-size:1rem;
                line-height:1.7;
                margin:0;
            }
            /* GRID */
            .facility-grid{
                display:grid;
                grid-template-columns:repeat(auto-fit,minmax(320px,1fr));
                gap:30px;
            }

            /* CARD */
            .facility-card{
                background:var(--card-bg);
                border-radius:26px;
                overflow:hidden;
                border:1px solid var(--border);
                transition:all 0.3s ease;
                cursor:pointer;
                position:relative;
            }

            .facility-card:hover{
                transform:translateY(-6px);
                box-shadow:0 18px 40px rgba(0,0,0,0.06);
            }

            /* IMAGE */
            .card-img{
                width:100%;
                height:230px;
                object-fit:cover;
                display:block;
            }

            /* CONTENT */
            .facility-content{
                padding:24px;
            }

            .facility-content h3{
                margin:0 0 10px;
                font-size:1.25rem;
                font-weight:700;
                color:var(--primary);
            }

            .facility-desc{
                font-size:0.92rem;
                color:var(--muted);
                line-height:1.6;
                margin-bottom:18px;
            }

            .facility-meta{
                display:flex;
                justify-content:space-between;
                align-items:center;
                margin-bottom:20px;
            }

            .capacity{
                font-size:0.85rem;
                color:#666;
                background:#f5f5f5;
                padding:7px 12px;
                border-radius:30px;
            }

            .status{
                font-size:0.85rem;
                font-weight:600;
                color:var(--success);
            }

            /* BUTTON */
            .btn-book{
                width:100%;
                border:none;
                background:var(--primary);
                color:white;
                padding:13px;
                border-radius:14px;
                font-weight:600;
                font-size:0.95rem;
                transition:0.25s;
            }

            .btn-book:hover{
                background:#0f2722;
            }

            /* EXPANDABLE UNIT LIST */
            .unit-list{
                max-height:0;
                overflow:hidden;
                transition:max-height 0.35s ease;
                background:#fcfaf8;
            }

            .facility-card.active .unit-list{
                max-height:500px;
            }

            .unit-row{
                display:flex;
                justify-content:space-between;
                align-items:center;
                padding:18px 24px;
                border-top:1px solid #eee;
            }

            .unit-row span{
                font-size:0.92rem;
                font-weight:500;
            }

            .unit-row .btn-book{
                width:auto;
                padding:10px 18px;
                border-radius:10px;
                font-size:0.85rem;
            }

            /* FOOTER */
            footer{
                margin-top:60px;
                text-align:center;
                padding:30px;
                color:#777;
                font-size:0.9rem;
            }

            /* RESPONSIVE */
            @media(max-width:768px){

                .content-wrapper{
                    padding:30px 20px;
                }

                h1{
                    font-size:1.8rem;
                }

                .card-img{
                    height:210px;
                }

            }

            /* =========================
     SEARCH SECTION
  ========================= */

            .search-container{
                max-width:1300px;
                margin:40px auto 30px;
                padding:0 70px;
            }

            .search-box{
                background:white;
                border-radius:24px;
                padding:25px;
                display:flex;
                align-items:flex-end;
                gap:18px;
                box-shadow:0 10px 30px rgba(0,0,0,0.05);
                border:1px solid #ece6de;
                flex-wrap:nowrap;
            }

            /* EACH INPUT GROUP */
            .search-group{
                flex:1 1 200px;
            }

            .search-group label{
                display:block;
                font-size:0.9rem;
                font-weight:700;
                color:#18352f;
                margin-bottom:10px;
            }

            /* INPUT + SELECT */
            .search-box select,
            .search-box input{
                width:100%;
                height:55px;
                border:1px solid #ddd;
                border-radius:14px;
                padding:0 16px;
                font-size:0.95rem;
                outline:none;
                transition:0.25s;
                background:white;
            }

            .search-box select:focus,
            .search-box input:focus{
                border-color:#18352f;
                box-shadow:0 0 0 4px rgba(24,53,47,0.08);
            }

            /* BUTTON CONTAINER */
            .search-btn-group{
                flex:0 0 auto;
            }

            /* SEARCH BUTTON */
            .btn-search{
                height:55px;
                border:none;
                background:#18352f;
                color:white;
                padding:0 32px;
                border-radius:14px;
                font-weight:700;
                font-size:0.95rem;
                transition:0.25s;
                min-width:150px;
                white-space:nowrap;
            }

            .btn-search:hover{
                background:#0f2722;
                transform:translateY(-2px);
            }

            /* MOBILE */
            @media(max-width:992px){

                .search-box{
                    flex-wrap:wrap;
                }

                .search-group{
                    flex:1 1 45%;
                }

            }

            @media(max-width:768px){

                .search-container{
                    padding:0 20px;
                }

                .search-box{
                    flex-direction:column;
                    align-items:stretch;
                }

                .search-group{
                    width:100%;
                }

                .search-btn-group{
                    width:100%;
                }

                .btn-search{
                    width:100%;
                }

            }
        </style>

    </head>

    <body>

        <jsp:include page="header.jsp" />


        <div class="search-container">

            <form action="SearchFacilityServlet" method="GET">

                <div class="search-box">

                    <!-- FACILITY -->
                    <div class="search-group">

                        <label>
                            Facility
                        </label>

                        <select name="facilityType">

                            <option value="">
                                All Facilities
                            </option>

                            <option value="Study Room">
                                Study Room
                            </option>

                            <option value="Group Discussion Room">
                                Group Discussion Room
                            </option>

                            <option value="Computer Lab">
                                Computer Lab
                            </option>

                            <option value="Seminar Hall">
                                Seminar Hall
                            </option>

                            <option value="Media Production Room">
                                Media Production Room
                            </option>

                        </select>

                    </div>

                    <!-- DATE -->
                    <div class="search-group">

                        <label>
                            Booking Date
                        </label>

                        <input type="date" name="date">

                    </div>

                    <!-- START TIME -->
                    <div class="search-group">

                        <label>
                            Start Time
                        </label>

                        <select name="startTime">

                            <option value="">
                                Select Start Time
                            </option>

                            <option value="08:00">08:00 AM</option>
                            <option value="09:00">09:00 AM</option>
                            <option value="10:00">10:00 AM</option>
                            <option value="11:00">11:00 AM</option>
                            <option value="12:00">12:00 PM</option>
                            <option value="13:00">01:00 PM</option>
                            <option value="14:00">02:00 PM</option>
                            <option value="15:00">03:00 PM</option>
                            <option value="16:00">04:00 PM</option>
                            <option value="17:00">05:00 PM</option>
                            <option value="18:00">06:00 PM</option>
                            <option value="19:00">07:00 PM</option>
                            <option value="20:00">08:00 PM</option>

                        </select>

                    </div>

                    <!-- END TIME -->
                    <div class="search-group">

                        <label>
                            End Time
                        </label>

                        <select name="endTime">

                            <option value="">
                                Select End Time
                            </option>

                            <option value="09:00">09:00 AM</option>
                            <option value="10:00">10:00 AM</option>
                            <option value="11:00">11:00 AM</option>
                            <option value="12:00">12:00 PM</option>
                            <option value="13:00">01:00 PM</option>
                            <option value="14:00">02:00 PM</option>
                            <option value="15:00">03:00 PM</option>
                            <option value="16:00">04:00 PM</option>
                            <option value="17:00">05:00 PM</option>
                            <option value="18:00">06:00 PM</option>
                            <option value="19:00">07:00 PM</option>
                            <option value="20:00">08:00 PM</option>
                            <option value="21:00">09:00 PM</option>

                        </select>

                    </div>

                    <!-- BUTTON -->
                    <div class="search-btn-group">

                        <button type="submit"
                                class="btn-search">

                            <i class="fa-solid fa-magnifying-glass"></i>
                            Search

                        </button>

                    </div>

                </div>

            </form>

        </div>
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

         

<%

    if (facilities == null) {
        facilities = new ArrayList<>();
    }

    String date = request.getParameter("date");
    String startTime = request.getParameter("startTime");
    String endTime = request.getParameter("endTime");
%>

<div class="facility-grid">

<% if (facilities.isEmpty()) { %>

    <p style="color:#777;font-size:1rem;">
        No available facilities found for selected time.
    </p>

<% } else { %>

    <% for (Facility f : facilities) { %>

        <div class="facility-card">

            <div style="padding:20px;">

                <!-- IMAGE -->
                <img src="<%= f.getImageUrl() %>" class="card-img">

                <!-- NAME -->
                <h3><%= f.getUnitName() %></h3>

                <!-- DESCRIPTION -->
                <p class="facility-desc">
                    <%= f.getDescription() %>
                </p>

                <!-- CAPACITY -->
                <p style="font-size:0.85rem;color:#666;">
                    Capacity: <%= f.getCapacity() %>
                </p>

                <!-- STATUS -->
                <span style="color:#28a745;font-weight:bold;font-size:0.85rem;">
                    ● Available
                </span>

                <br><br>

                <!-- BOOK BUTTON -->
                <button class="btn-book"
                    onclick="location.href='booking.jsp?
                    unit=<%= f.getUnitName() %>
                    &date=<%= date %>
                    &startTime=<%= startTime %>
                    &endTime=<%= endTime %>'">
                    Book
                </button>

            </div>

        </div>

    <% } %>

<% } %>

</div>
    </body>

    <jsp:include page="footer.jsp" />
</html>