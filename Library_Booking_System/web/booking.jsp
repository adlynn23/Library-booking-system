<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>

<%
    String facilityName = request.getParameter("unit");
    String bookingDate = request.getParameter("date");
    String startTimeParam = request.getParameter("startTime");
    String endTimeParam = request.getParameter("endTime");

    if (facilityName == null) {
        facilityName = "";
    }
    if (bookingDate == null) {
        bookingDate = "";
    }
    if (startTimeParam == null) {
        startTimeParam = "";
    }
    if (endTimeParam == null) {
        endTimeParam = "";
    }

    String displayDate = bookingDate;

    try {
        displayDate = LocalDate.parse(bookingDate)
                .format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    } catch (Exception e) {
        displayDate = bookingDate;
    }

    String backUrl = "AvailabilityServlet?facilityType=All Facilities&date="
            + URLEncoder.encode(bookingDate, "UTF-8");
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Booking | EduSpace</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        :root{
            --edu-green:#163832;
            --soft-bg:#f3f4f6;
            --border:#e5d6c7;
            --muted:#6b7280;
        }

        body{
            background:var(--soft-bg);
            font-family:'DM Sans',sans-serif;
            color:#111827;
        }

        .back-container{
            width:100%;
            max-width:1400px;
            margin:0 auto;
            padding:55px 35px 22px;
        }

        .back-btn{
            display:inline-flex;
            align-items:center;
            gap:8px;
            padding:12px 22px;
            background:var(--edu-green);
            color:white;
            text-decoration:none;
            border-radius:12px;
            font-weight:700;
            box-shadow:0 5px 15px rgba(0,0,0,.15);
        }

        .back-btn:hover{
            color:white;
            background:#0f2f2a;
        }

        .page-wrap{
            max-width:850px;
            margin:0 auto 60px;
        }

        .booking-container{
            background:white;
            padding:42px;
            border-radius:26px;
            box-shadow:0 12px 34px rgba(15,23,42,0.07);
        }

        h1{
            font-weight:800;
            color:var(--edu-green);
            font-size:2.4rem;
            margin-bottom:8px;
        }

        .subtitle{
            color:var(--muted);
            margin-bottom:28px;
            font-size:1rem;
        }

        .form-label{
            font-weight:700;
            color:#374151;
            margin-bottom:10px;
        }

        .form-control,
        .form-select{
            height:58px;
            border-radius:14px;
            border:1px solid var(--border);
            font-size:1rem;
        }

        textarea.form-control{
            height:auto;
            min-height:130px;
            padding:14px;
        }

        .summary-box{
            background:#f8fafc;
            border:1px solid #e5e7eb;
            border-radius:18px;
            padding:18px;
            margin:22px 0;
        }

        .summary-grid{
            display:grid;
            grid-template-columns:repeat(2,1fr);
            gap:14px;
        }

        .summary-item{
            background:white;
            border:1px solid #e5e7eb;
            border-radius:14px;
            padding:14px 16px;
        }

        .summary-item span{
            display:block;
            color:#6b7280;
            font-size:0.82rem;
            margin-bottom:6px;
            font-weight:600;
        }

        .summary-item strong{
            color:#163832;
            font-size:1.02rem;
        }

        .info-box{
            background:#f8f8f8;
            border-left:5px solid var(--edu-green);
            padding:16px 18px;
            border-radius:12px;
            margin-bottom:24px;
            line-height:1.7;
        }

        .btn-submit{
            width:100%;
            background:var(--edu-green);
            border:none;
            color:white;
            font-weight:800;
            padding:16px;
            border-radius:14px;
            font-size:1.05rem;
            letter-spacing:0.3px;
        }

        .btn-submit:hover{
            opacity:0.94;
        }

        .btn-submit:disabled{
            background:#9ca3af;
            cursor:not-allowed;
        }

        #statusBox{
            font-weight:700;
            margin-top:5px;
            margin-bottom:12px;
        }

        .success{
            color:#15803d;
        }

        .error{
            color:#dc2626;
        }

        @media(max-width:768px){
            .back-container{
                padding:35px 18px 18px;
            }

            .page-wrap{
                margin:0 15px 40px;
            }

            .booking-container{
                padding:28px;
            }

            .summary-grid{
                grid-template-columns:1fr;
            }

            h1{
                font-size:2rem;
            }
        }
    </style>
</head>

<body>

<jsp:include page="header.jsp"/>

<div class="back-container">
    <a href="<%= backUrl%>" class="back-btn">
        ← Back to Time Slots
    </a>
</div>

<div class="page-wrap">

    <div class="booking-container">
        <h1>Facility Reservation</h1>

        <p class="subtitle">
            Review your selected slot, choose duration, add your purpose, then confirm the booking.
        </p>

        <form action="BookingServlet"
              method="POST"
              onsubmit="return validateBooking()">

            <div class="mb-4">
                <label class="form-label">Facility</label>

                <input type="text"
                       class="form-control"
                       value="<%= facilityName%>"
                       readonly>

                <input type="hidden"
                       name="unit"
                       value="<%= facilityName%>">
            </div>

            <input type="hidden"
                   id="bookingDate"
                   name="bookingDate"
                   value="<%= bookingDate%>">

            <input type="hidden"
                   id="startTime"
                   name="startTime"
                   value="<%= startTimeParam%>">

            <input type="hidden"
                   id="endTime"
                   name="endTime">

            <div class="summary-box">
                <div class="summary-grid">

                    <div class="summary-item">
                        <span>Booking Date</span>
                        <strong><%= displayDate%></strong>
                    </div>

                    <div class="summary-item">
                        <span>Selected Day</span>
                        <strong id="selectedDay">-</strong>
                    </div>

                    <div class="summary-item">
                        <span>Start Time</span>
                        <strong><%= startTimeParam%></strong>
                    </div>

                    <div class="summary-item">
                        <span>End Time</span>
                        <strong id="displayEnd">-</strong>
                    </div>

                </div>
            </div>

            <div class="info-box">
                <div>
                    Operating Hours:
                    <b id="operatingHours">-</b>
                </div>
                <div>
                    Booking Rule:
                    <b>Maximum 2 hours and at least 2 hours before start time</b>
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label">Duration</label>

                <select id="duration"
                        class="form-select">

                    <option value="1">1 Hour</option>
                    <option value="2">2 Hours</option>

                </select>
            </div>

            <div id="statusBox"></div>

            <div class="mb-4 mt-3">
                <label class="form-label">Purpose</label>

                <textarea name="purpose"
                          class="form-control"
                          rows="5"
                          placeholder="Enter your booking purpose..."
                          required></textarea>
            </div>

            <button type="submit"
                    id="bookingButton"
                    class="btn-submit">
                CONFIRM BOOKING
            </button>

        </form>

    </div>

</div>

<script>
    const bookingDate = document.getElementById("bookingDate");
    const startTime = document.getElementById("startTime");
    const endTime = document.getElementById("endTime");
    const duration = document.getElementById("duration");
    const statusBox = document.getElementById("statusBox");
    const selectedDayText = document.getElementById("selectedDay");
    const operatingHoursText = document.getElementById("operatingHours");
    const bookingButton = document.getElementById("bookingButton");
    const displayEnd = document.getElementById("displayEnd");

    let isSlotAvailable = true;
    let hasInvalidTime = false;

    function updateOperatingHours() {
        const value = bookingDate.value;

        if (!value)
            return;

        const date = new Date(value);
        const day = date.getDay();

        const days = [
            "Sunday", "Monday", "Tuesday", "Wednesday",
            "Thursday", "Friday", "Saturday"
        ];

        selectedDayText.innerText = days[day];

        if (day >= 1 && day <= 5) {
            operatingHoursText.innerText = "08:00 - 22:00";
        } else {
            operatingHoursText.innerText = "09:00 - 18:00";
        }
    }

    function updateEndTime() {
        const start = startTime.value;
        const selectedDuration = parseInt(duration.value);

        if (!start)
            return;

        let hour = parseInt(start.split(":")[0]);
        hour += selectedDuration;

        let end = (hour < 10 ? "0" + hour : hour) + ":00";

        endTime.value = end;
        displayEnd.innerText = end;
    }

    async function validateTimeRules() {
        statusBox.innerHTML = "";
        hasInvalidTime = false;
        bookingButton.disabled = false;

        const date = bookingDate.value;
        const start = startTime.value;
        const end = endTime.value;

        if (!date || !start || !end)
            return;

        const selectedDate = new Date(date);
        const day = selectedDate.getDay();

        const startHour = parseInt(start.split(":")[0]);
        const endHour = parseInt(end.split(":")[0]);

        if (end <= start) {
            statusBox.innerHTML =
                    "<span class='error'>Warning: End time must be after start time</span>";
            hasInvalidTime = true;
            bookingButton.disabled = true;
            return;
        }

        const startDateTime = new Date(date + "T" + start);
        const endDateTime = new Date(date + "T" + end);

        const diffHours =
                (endDateTime - startDateTime) / (1000 * 60 * 60);

        if (diffHours > 2) {
            statusBox.innerHTML =
                    "<span class='error'>Warning: Maximum booking is 2 hours only</span>";
            hasInvalidTime = true;
            bookingButton.disabled = true;
            return;
        }

        if (day >= 1 && day <= 5) {
            if (startHour < 8 || endHour > 22) {
                statusBox.innerHTML =
                        "<span class='error'>Warning: Booking allowed only between 8AM - 10PM</span>";
                hasInvalidTime = true;
                bookingButton.disabled = true;
                return;
            }
        } else {
            if (startHour < 9 || endHour > 18) {
                statusBox.innerHTML =
                        "<span class='error'>Warning: Booking allowed only between 9AM - 6PM</span>";
                hasInvalidTime = true;
                bookingButton.disabled = true;
                return;
            }
        }

        const now = new Date();

        const minuteDiff =
                (startDateTime - now) / (1000 * 60);

        if (minuteDiff < 120) {
            statusBox.innerHTML =
                    "<span class='error'>Warning: Booking must be made at least 2 hours earlier</span>";
            hasInvalidTime = true;
            bookingButton.disabled = true;
            return;
        }

        const facility = document.querySelector("input[name='unit']").value;

        try {
            const response =
                    await fetch(
                            "CheckAvailabilityServlet"
                            + "?facility=" + encodeURIComponent(facility)
                            + "&date=" + date
                            + "&start=" + start
                            + "&end=" + end
                    );

            const data = await response.json();

            if (data.available) {
                isSlotAvailable = true;
                statusBox.innerHTML =
                        "<span class='success'>Slot available</span>";
            } else {
                isSlotAvailable = false;
                bookingButton.disabled = true;
                statusBox.innerHTML =
                        "<span class='error'>Warning: Slot already booked</span>";
            }

        } catch (e) {
            statusBox.innerHTML =
                    "<span class='error'>Warning: Error checking slot</span>";
            bookingButton.disabled = true;
        }
    }

    function validateBooking() {
        if (hasInvalidTime || statusBox.innerText.includes("Warning:")) {
            Swal.fire({
                icon: "error",
                title: "Invalid Booking",
                text: "Please fix the booking details first"
            });

            return false;
        }

        if (!isSlotAvailable) {
            Swal.fire({
                icon: "error",
                title: "Slot Unavailable",
                text: "Please choose another time"
            });

            return false;
        }

        return true;
    }

    duration.addEventListener("change", function () {
        updateEndTime();
        validateTimeRules();
    });

    window.onload = function () {
        updateOperatingHours();
        updateEndTime();
        validateTimeRules();
    };
</script>

</body>
</html>