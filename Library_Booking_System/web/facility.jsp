<!-- facility.jsp -->

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>

<%
    List<Map<String,String>> facilities =
        (List<Map<String,String>>) request.getAttribute("facilities");

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
                --edu-green:#163832;
                --soft-bg:#f7efe5;
                --border:#e8e2d9;
            }

            body{
                margin:0;
                font-family:'DM Sans',sans-serif;
                background:var(--soft-bg);
                color:#222;
            }

            .content-wrapper{
                padding:50px 60px;
            }

            h1{
                color:var(--edu-green);
                font-size:2rem;
            }

            .facility-grid{
                display:grid;
                grid-template-columns:repeat(3,1fr);
                gap:35px;
            }

            .facility-card{
                background:white;
                border-radius:28px;
                overflow:hidden;
                cursor:pointer;
                transition:0.3s;
                border:1px solid var(--border);
            }

            .facility-card:hover{
                transform:translateY(-8px);
                box-shadow:0 15px 35px rgba(0,0,0,0.08);
            }

            .card-img{
                width:100%;
                height:240px;
                object-fit:cover;
            }

            .unit-list{
                max-height:0;
                overflow:hidden;
                transition:max-height 0.4s ease;
                background:#fcfaf7;
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

            .btn-book{
                background:var(--edu-green);
                color:white;
                border:none;
                padding:10px 18px;
                border-radius:10px;
                cursor:pointer;
                font-weight:600;
            }

            .btn-book:hover{
                opacity:0.9;
            }

            footer{
                text-align:center;
                padding:30px;
                color:#666;
            }

            @media(max-width:992px){

                .facility-grid{
                    grid-template-columns:1fr;
                }

                .content-wrapper{
                    padding:30px 20px;
                }

            }

        </style>

    </head>

    <body>

        <jsp:include page="header.jsp" />

        <div class="content-wrapper">

            <h1 class="fw-bold mb-4" style="color:#333;">
                Available Facilities
            </h1>

            <div class="facility-grid">

                <!-- ================= DB FACILITIES ================= -->
                <%
                    if (!facilities.isEmpty()) {
                        for (Map<String,String> f : facilities) {
                %>

                <div class="facility-card">

                    <div style="padding:20px;">

                        <h3><%= f.get("unit") %></h3>

                        <p style="font-size:0.85rem;color:#555;">
                            <%= f.get("desc") %>
                        </p>

                        <p style="font-size:0.85rem;color:#666;">
                            Capacity: <%= f.get("capacity") %>
                        </p>

                        <span style="color:#28a745;font-weight:bold;font-size:0.85rem;">
                            ● Available
                        </span>

                        <br><br>

                        <button class="btn-book"
                                onclick="location.href='booking.jsp?unit=<%= f.get("unit") %>'">
                            Book
                        </button>

                    </div>

                </div>

                <%
                        }
                    }
                %>

                <!-- STUDY ROOM -->
                <div class="facility-card" onclick="this.classList.toggle('active')">

                    <img src="https://tse4.mm.bing.net/th/id/OIP.JTEo6YgELkZDiQTjcfo4mQHaGm?rs=1&pid=ImgDetMain&o=7&rm=3"
                         class="card-img">

                    <div style="padding:20px;">

                        <h3>Study Room</h3>

                        <p style="font-size:0.85rem;color:#555;">
                            Quiet individual study room with desk and comfortable seating
                        </p>

                        <p style="font-size:0.85rem;color:#666;">
                            Capacity: 1 person
                        </p>

                        <span style="color:#28a745;font-weight:bold;font-size:0.85rem;">
                            ● Available
                        </span>

                    </div>

                    <div class="unit-list">

                        <div class="unit-row">
                            <span>Study Room A</span>
                            <button class="btn-book"
                                    onclick="event.stopPropagation(); location.href='booking.jsp?unit=Study Room A'">
                                Book
                            </button>
                        </div>

                        <div class="unit-row">
                            <span>Study Room B</span>
                            <button class="btn-book"
                                    onclick="event.stopPropagation(); location.href='booking.jsp?unit=Study Room B'">
                                Book
                            </button>
                        </div>

                        <div class="unit-row">
                            <span>Study Room C</span>
                            <button class="btn-book"
                                    onclick="event.stopPropagation(); location.href='booking.jsp?unit=Study Room C'">
                                Book
                            </button>
                        </div>

                        <div class="unit-row">
                            <span>Study Room D</span>
                            <button class="btn-book"
                                    onclick="event.stopPropagation(); location.href='booking.jsp?unit=Study Room D'">
                                Book
                            </button>
                        </div>

                        <div class="unit-row">
                            <span>Study Room E</span>
                            <button class="btn-book"
                                    onclick="event.stopPropagation(); location.href='booking.jsp?unit=Study Room E'">
                                Book
                            </button>
                        </div>

                    </div>

                </div>

                <!-- DISCUSSION ROOM -->
                <div class="facility-card" onclick="this.classList.toggle('active')">

                    <img src="https://images.unsplash.com/photo-1517502884422-41eaead166d4?q=80&w=500"
                         class="card-img">

                    <div style="padding:20px;">

                        <h3>Group Discussion Room</h3>

                        <p style="font-size:0.85rem;color:#555;">
                            Collaborative discussion space with whiteboard and projector
                        </p>

                        <p style="font-size:0.85rem;color:#666;">
                            Capacity: 8 people
                        </p>

                        <span style="color:#28a745;font-weight:bold;font-size:0.85rem;">
                            ● Available
                        </span>

                    </div>

                    <div class="unit-list">

                        <div class="unit-row">
                            <span>Room 1</span>
                            <button class="btn-book"
                                    onclick="event.stopPropagation(); location.href='booking.jsp?unit=Room 1'">
                                Book
                            </button>
                        </div>

                        <div class="unit-row">
                            <span>Room 2</span>
                            <button class="btn-book"
                                    onclick="event.stopPropagation(); location.href='booking.jsp?unit=Room 2'">
                                Book
                            </button>
                        </div>

                        <div class="unit-row">
                            <span>Room 3</span>
                            <button class="btn-book"
                                    onclick="event.stopPropagation(); location.href='booking.jsp?unit=Room 3'">
                                Book
                            </button>
                        </div>

                        <div class="unit-row">
                            <span>Room 4</span>
                            <button class="btn-book"
                                    onclick="event.stopPropagation(); location.href='booking.jsp?unit=Room 4'">
                                Book
                            </button>
                        </div>

                        <div class="unit-row">
                            <span>Room 5</span>
                            <button class="btn-book"
                                    onclick="event.stopPropagation(); location.href='booking.jsp?unit=Room 5'">
                                Book
                            </button>
                        </div>

                    </div>

                </div>

                <!-- COMPUTER LAB -->
                <div class="facility-card" onclick="this.classList.toggle('active')">

                    <img src="https://tse1.mm.bing.net/th/id/OIP.a-4Za8X48nmRYDFbCRoTZwHaFK?rs=1&pid=ImgDetMain&o=7&rm=3"
                         class="card-img">

                    <div style="padding:20px;">

                        <h3>Computer Lab</h3>

                        <p style="font-size:0.85rem;color:#555;">
                            High-performance computers with specialized software
                        </p>

                        <p style="font-size:0.85rem;color:#666;">
                            Capacity: 20-30 people
                        </p>

                        <span style="color:#28a745;font-weight:bold;font-size:0.85rem;">
                            ● Available
                        </span>

                    </div>

                    <div class="unit-list">

                        <div class="unit-row">
                            <span>Computer Lab A</span>
                            <button class="btn-book"
                                    onclick="event.stopPropagation(); location.href='booking.jsp?unit=Computer Lab A'">
                                Book
                            </button>
                        </div>

                        <div class="unit-row">
                            <span>Computer Lab B</span>
                            <button class="btn-book"
                                    onclick="event.stopPropagation(); location.href='booking.jsp?unit=Computer Lab B'">
                                Book
                            </button>
                        </div>

                    </div>

                </div>

                <!-- SEMINAR HALL -->
                <div class="facility-card" onclick="this.classList.toggle('active')">

                    <img src="https://d3211p0nhvzn27.cloudfront.net/wp-content/uploads/2018/09/22071109/how-to-make-a-university-seminar-hall-world-class.jpg"
                         class="card-img">

                    <div style="padding:20px;">

                        <h3>Seminar Hall</h3>

                        <p style="font-size:0.85rem;color:#555;">
                            Large auditorium for presentations and events
                        </p>

                        <p style="font-size:0.85rem;color:#666;">
                            Capacity: 100 people
                        </p>

                        <span style="color:#28a745;font-weight:bold;font-size:0.85rem;">
                            ● Available
                        </span>

                    </div>

                    <div class="unit-list">

                        <div class="unit-row">
                            <span>Auditorium A</span>

                            <button class="btn-book"
                                    onclick="event.stopPropagation(); location.href='booking.jsp?unit=Auditorium A'">
                                Book
                            </button>
                        </div>

                        <div class="unit-row">
                            <span>Auditorium B</span>

                            <button class="btn-book"
                                    onclick="event.stopPropagation(); location.href='booking.jsp?unit=Auditorium B'">
                                Book
                            </button>
                        </div>

                    </div>

                </div>

                <!-- MEDIA PRODUCTION ROOM -->
                <div class="facility-card" onclick="this.classList.toggle('active')">

                    <img src="https://th.bing.com/th/id/OIP.ynhQU5b4y_hPy0O5Fq9fHAHaE_?o=7rm=3&rs=1&pid=ImgDetMain&o=7&rm=3"
                         class="card-img">

                    <div style="padding:20px;">

                        <h3>Media Production Room</h3>

                        <p style="font-size:0.85rem;color:#555;">
                            Professional recording and editing equipment
                        </p>

                        <p style="font-size:0.85rem;color:#666;">
                            Capacity: 8 people
                        </p>

                        <span style="color:#28a745;font-weight:bold;font-size:0.85rem;">
                            ● Available
                        </span>

                    </div>

                    <div class="unit-list">

                        <div class="unit-row">
                            <span>Media Space</span>

                            <button class="btn-book"
                                    onclick="event.stopPropagation(); location.href='booking.jsp?unit=Media Space'">
                                Book
                            </button>
                        </div>

                    </div>

                </div>

            </div>

        </div>

        <footer>
            <p>&copy; 2026 EduSpace System</p>
        </footer>

    </body>
</html>