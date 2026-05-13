<%-- 
    Document   : facility
    Created on : 8 May 2026, 11:46:50 pm
    Author     : H O N O R
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
        <jsp:include page="header.jsp" />

    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Facility List| EduSpace</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&display=swap" rel="stylesheet">
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
        .navbar{
            height:80px;
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
        .btn-signup{
            background:var(--edu-green);
            color:white;
            border:none;
            padding:8px 14px;
            border-radius:10px;
            cursor:pointer;
            font-weight:600;
            font-size:0.85rem;
        }
        .btn-google{
            background:white;
            border:1px solid #ddd;
            padding:8px 14px;
            border-radius:10px;
            cursor:pointer;
            display:flex;
            align-items:center;
            gap:10px;
            font-size:0.85rem;
        }
        .content-wrapper{
            padding:50px 60px;
        }
        .tab-bar-white{
            background:white;
            padding:18px;
            border-radius:20px;
            display:flex;
            justify-content:center;
            gap:25px;
            margin-bottom:45px;
        }
        .tab-btn{
            padding:12px 24px;
            border-radius:12px;
            font-weight:600;
            cursor:pointer;
        }
        .tab-btn.active{
            background:var(--edu-green);
            color:white;
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
   <div class="content-wrapper">  
        <div class="tab-bar-white">
            <div class="tab-btn active">Browse Facilities</div>
            <div class="tab-btn">Book Now</div>
            <div class="tab-btn">My Bookings</div>
        </div>
        <h1 style="color:#333; margin-bottom:25px;">Available Facilities</h1>

<div class="facility-grid">

    <div class="facility-card" onclick="this.classList.toggle('active')">
        <img src="https://tse4.mm.bing.net/th/id/OIP.JTEo6YgELkZDiQTjcfo4mQHaGm?rs=1&pid=ImgDetMain&o=7&rm=3" class="card-img">
        <div style="padding:20px;">
            <h3 style="margin:0;">Study Room</h3>           
            <p style="margin: 5px 0; font-size: 0.85rem; color: #555; line-height: 1.4;">
                Quiet individual study room with desk and comfortable seating
            </p>
            <p style="color:#666; font-size:0.85rem; margin:10px 0;">Capacity: 1 person</p>
            <span style="color:#28a745; font-weight:bold; font-size:0.85rem;">● Available</span>
        </div>
        <div class="unit-list">
            <div class="unit-row">
                <span>Study Room A</span>
                <button class="btn-book" onclick="event.stopPropagation(); window.location.href='booking.jsp?unit=Study Room A'">Book</button>
            </div>
            <div class="unit-row">
                <span>Study Room B</span>
                <button class="btn-book" onclick="event.stopPropagation(); window.location.href='booking.jsp?unit=Study Room B'">Book</button>
            </div>
            <div class="unit-row">
                <span>Study Room C</span>
                <button class="btn-book" onclick="event.stopPropagation(); window.location.href='booking.jsp?unit=Study Room C'">Book</button>
            </div>
            <div class="unit-row">
                <span>Study Room D</span>
                <button class="btn-book" onclick="event.stopPropagation(); window.location.href='booking.jsp?unit=Study Room D'">Book</button>
            </div>
            <div class="unit-row">
                <span>Study Room E</span>
                <button class="btn-book" onclick="event.stopPropagation(); window.location.href='booking.jsp?unit=Study Room E'">Book</button>
            </div>
        </div>
    </div>

    <div class="facility-card" onclick="this.classList.toggle('active')">
        <img src="https://images.unsplash.com/photo-1517502884422-41eaead166d4?q=80&w=500" class="card-img">
        <div style="padding:20px;">
            <h3 style="margin:0;">Group Discussion Room</h3>
            <p style="margin: 5px 0; font-size: 0.85rem; color: #555; line-height: 1.4;">
                Collaborative space with whiteboard and projector
            </p>
            <p style="color:#666; font-size:0.85rem; margin:10px 0;">Capacity: 8 people</p>
            <span style="color:#28a745; font-weight:bold; font-size:0.85rem;">● Available</span>
        </div>
        <div class="unit-list">
            <div class="unit-row"><span>Room 1</span><button class="btn-book" onclick="event.stopPropagation(); window.location.href='booking.jsp?unit=Room 1'">Book</button></div>
            <div class="unit-row"><span>Room 2</span><button class="btn-book" onclick="event.stopPropagation(); window.location.href='booking.jsp?unit=Room 2'">Book</button></div>
            <div class="unit-row"><span>Room 3</span><button class="btn-book" onclick="event.stopPropagation(); window.location.href='booking.jsp?unit=Room 3'">Book</button></div>
            <div class="unit-row"><span>Room 4</span><button class="btn-book" onclick="event.stopPropagation(); window.location.href='booking.jsp?unit=Room 4'">Book</button></div>
            <div class="unit-row"><span>Room 5</span><button class="btn-book" onclick="event.stopPropagation(); window.location.href='booking.jsp?unit=Room 5'">Book</button></div>
        </div>
    </div>
    
    <div class="facility-card" onclick="this.classList.toggle('active')">
        <img src="https://tse1.mm.bing.net/th/id/OIP.a-4Za8X48nmRYDFbCRoTZwHaFK?rs=1&pid=ImgDetMain&o=7&rm=3" class="card-img">
        <div style="padding:20px;">
            <h3 style="margin:0;">Computer Lab</h3>
            <p style="margin: 5px 0; font-size: 0.85rem; color: #555; line-height: 1.4;">
                High-performance computers with specialized software
            </p>
            <p style="color:#666; font-size:0.85rem; margin:10px 0;">Capacity: 20-30 people</p>
            <span style="color:#28a745; font-weight:bold; font-size:0.85rem;">● Available</span>
        </div>
        <div class="unit-list">
            <div class="unit-row">
                <span>Computer Lab A</span>
                <button class="btn-book" onclick="event.stopPropagation(); window.location.href='booking.jsp?unit=Lab Section A'">Book</button>
            </div>
            <div class="unit-row">
                <span>Computer Lab B</span>
                <button class="btn-book" onclick="event.stopPropagation(); window.location.href='booking.jsp?unit=Lab Section B'">Book</button>
            </div>
        </div>
    </div>
    
    <div class="facility-card" onclick="this.classList.toggle('active')">
        <img src="https://d3211p0nhvzn27.cloudfront.net/wp-content/uploads/2018/09/22071109/how-to-make-a-university-seminar-hall-world-class.jpg" class="card-img">
        <div style="padding:20px;">
            <h3 style="margin:0;">Seminar Hall</h3>
            <p style="margin: 5px 0; font-size: 0.85rem; color: #555; line-height: 1.4;">
                Large auditorium for presentations and events
            </p>
            <p style="color:#666; font-size:0.85rem; margin:10px 0;">Capacity: 100 people</p>
            <span style="color:#28a745; font-weight:bold; font-size:0.85rem;">● Available</span>
        </div>
        <div class="unit-list">
            <div class="unit-row">
                <span>Auditorium A</span>
                <button class="btn-book" onclick="event.stopPropagation(); window.location.href='booking.jsp?unit= Auditorium A'">Book</button>
            </div>
        </div>
        <div class="unit-list">
            <div class="unit-row">
                <span> Auditorium B</span>
                <button class="btn-book" onclick="event.stopPropagation(); window.location.href='booking.jsp?unit= Auditorium B'">Book</button>
            </div>
        </div>
    </div>
    
    <div class="facility-card" onclick="this.classList.toggle('active')">
        <img src="https://th.bing.com/th/id/OIP.ynhQU5b4y_hPy0O5Fq9fHAHaE_?o=7rm=3&rs=1&pid=ImgDetMain&o=7&rm=3" class="card-img">
        <div style="padding:20px;">
            <h3 style="margin:0;">Media Production Room</h3>
            <p style="margin: 5px 0; font-size: 0.85rem; color: #555; line-height: 1.4;">
                Professional recording and editing equipment
            </p>
            <p style="color:#666; font-size:0.85rem; margin:10px 0;">Capacity: 8 people</p>
            <span style="color:#28a745; font-weight:bold; font-size:0.85rem;">● Available</span>
        </div>
        <div class="unit-list">
            <div class="unit-row"><span>Media Space</span><button class="btn-book" onclick="event.stopPropagation(); window.location.href='booking.jsp?unit=Media Space'">Book</button></div>
            
        </div>
    </div>

</div>
    </div>
        <script>
            function continueWithGoogle() {
                alert("Connecting to Google Services...");
                window.location.href = 'index.jsp'; 
            }
        </script>

        <footer class="text-center">
            <div class="container">
                <p>&copy; 2026 EduSpace System. Developed for Application Development Course.</p>
            </div>
        </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        function toggleCard(card){
            card.classList.toggle("active");
        }
    </script>
</body>
</html>