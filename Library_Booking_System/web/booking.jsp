<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String facilityName = request.getParameter("unit");

    if (facilityName == null) {
        facilityName = "";
    }
%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Booking | EduSpace</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&display=swap" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <style>
            :root {
                --edu-green: #1a3a32;
                --soft-peach: #fff5eb;
            }

            body {
                font-family: 'DM Sans', sans-serif;
                background: var(--soft-peach);
            }

            .booking-container {
                max-width: 750px;
                margin: 60px auto;
                background: white;
                padding: 40px;
                border-radius: 20px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            }

            .form-label {
                font-weight: 600;
                color: var(--edu-green);
            }

            .form-control {
                border-radius: 10px;
            }

            .btn-submit {
                background: var(--edu-green);
                color: white;
                border: none;
                padding: 15px;
                width: 100%;
                border-radius: 10px;
                font-weight: 700;
            }

            .btn-submit:hover {
                opacity: 0.9;
            }

            .info-box {
                background: #f8f8f8;
                padding: 10px;
                border-left: 4px solid var(--edu-green);
                border-radius: 8px;
                margin-bottom: 15px;
                font-size: 13px;
            }
        </style>
    </head>

    <body>

        <jsp:include page="header.jsp" />

        <div class="container">

            <div class="booking-container">

                <h2 class="fw-bold">Facility Reservation</h2>
                <p class="text-muted">Fill in your booking details</p>

                <form action="BookingServlet" method="POST" onsubmit="return validateBooking()">

                    <!-- FACILITY -->
                    <div class="mb-3">

                        <label class="form-label">Facility</label>

                        <input type="text"
                               class="form-control"
                               value="<%= facilityName%>"
                               readonly>

                        <input type="hidden"
                               name="facilityName"
                               value="<%= facilityName%>">
                    </div>

                    <!-- DATE -->
                    <div class="mb-2">

                        <label class="form-label">Booking Date</label>

                        <input type="date"
                               id="bookingDate"
                               name="bookingDate"
                               class="form-control"
                               onchange="validateDateNotPast(); updateRules()"
                               required>
                    </div>

                    <!-- INFO -->
                    <div class="info-box">
                        Selected Day: <b id="selectedDay">-</b><br>
                        Operating Hours: <b id="operatingHours">-</b>
                    </div>

                    <!-- TIME -->
                    <div class="row">

                        <div class="col-md-6 mb-3">

                            <label class="form-label">Start Time</label>

                            <input type="time"
                                   id="startTime"
                                   name="startTime"
                                   class="form-control"
                                   oninput="liveValidate()"
                                   required>
                        </div>

                        <div class="col-md-6 mb-3">

                            <label class="form-label">End Time</label>

                            <input type="time"
                                   id="endTime"
                                   name="endTime"
                                   class="form-control"
                                   oninput="liveValidate()"
                                   required>
                        </div>
                    </div>

                    <!-- STATUS -->
                    <div id="statusBox" class="mb-3 small"></div>

                    <!-- PURPOSE -->
                    <div class="mb-3">

                        <label class="form-label">Purpose</label>

                        <textarea class="form-control"
                                  name="purpose"
                                  rows="4"
                                  required></textarea>
                    </div>

                    <button type="submit" class="btn-submit">
                        CONFIRM BOOKING
                    </button>

                </form>

            </div>

        </div>

        <script>



            const days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

            let allowedStart = 8;
            let allowedEnd = 22;
            let selectedDay = -1;
            let isSlotAvailable = true;

        // ==========================
        // UPDATE RULES
        // ==========================
            function updateRules() {

                const dateVal = document.getElementById("bookingDate").value;

                if (!dateVal)
                    return;

                const d = new Date(dateVal);

                selectedDay = d.getDay();

                document.getElementById("selectedDay").innerText =
                        days[selectedDay];

                // WEEKDAY
                if (selectedDay >= 1 && selectedDay <= 5) {

                    allowedStart = 8;
                    allowedEnd = 22;

                }

                // WEEKEND
                else {

                    allowedStart = 9;
                    allowedEnd = 18;

                }

                document.getElementById("operatingHours").innerText =
                        format(allowedStart) + " - " + format(allowedEnd);

                liveValidate();
            }

            function format(h) {

                return (h < 10 ? "0" + h : h) + ":00";

            }

        // ==========================
        // LIVE VALIDATION
        // ==========================
           function liveValidate() {

    const start = document.getElementById("startTime").value;
    const end = document.getElementById("endTime").value;

    const box = document.getElementById("statusBox");

    if (!start || !end || selectedDay === -1) return;

    const s = parseInt(start.split(":")[0]);
    const e = parseInt(end.split(":")[0]);

    const selectedDate =
        document.getElementById("bookingDate").value;

    const now = new Date();

    const bookingDateTime =
        new Date(selectedDate + "T" + start);

    const oneHourLater =
        new Date(now.getTime() + (60 * 60 * 1000));

    let error = "";

    // =========================
    // 1 HOUR EARLY RULE
    // =========================
    if (bookingDateTime < oneHourLater) {

        error =
            "Booking must be made at least 1 hour earlier";
    }

    else if (e <= s) {

        error =
            "End time must be after start time";
    }

    else if ((e - s) > 2) {

        error =
            "Maximum booking duration is 2 hours only";
    }

    else if (s < allowedStart || e > allowedEnd) {

        error =
            "Outside operating hours";
    }

    if (error === "") {

        box.innerHTML =
            "<span class='text-success'>✔ Valid booking time</span>";

    } else {

        box.innerHTML =
            "<span class='text-danger'>⚠ " + error + "</span>";
    }
}

                // CHECK SLOT
                checkAvailability();
            }

        // ==========================
        // DATE VALIDATION
        // ==========================
            function validateDateNotPast() {

                const dateInput = document.getElementById("bookingDate");

                const selectedDate = new Date(dateInput.value);

                const today = new Date();

                selectedDate.setHours(0, 0, 0, 0);

                today.setHours(0, 0, 0, 0);

                if (selectedDate < today) {

                    Swal.fire({
                        icon: "error",
                        title: "Invalid Date",
                        text: "You cannot book past dates"
                    });

                    dateInput.value = "";

                    return false;
                }

                return true;
            }

        // ==========================
        // MIN DATE
        // ==========================
            document.getElementById("bookingDate").min =
                    new Date().toISOString().split("T")[0];

        // ==========================
        // CHECK SLOT AVAILABILITY
        // ==========================
            async function checkAvailability() {

                const facility =
                        document.querySelector("input[name='facilityName']").value;

                const date =
                        document.getElementById("bookingDate").value;

                const start =
                        document.getElementById("startTime").value;

                const end =
                        document.getElementById("endTime").value;

                const box =
                        document.getElementById("statusBox");

                if (!facility || !date || !start || !end) {
                    return;
                }

                try {

                    const response = await fetch(
                            "CheckAvailabilityServlet?facility="
                            + encodeURIComponent(facility)
                            + "&date=" + encodeURIComponent(date)
                            + "&start=" + encodeURIComponent(start)
                            + "&end=" + encodeURIComponent(end)
                            );

                    const data = await response.json();

                    if (data.available) {

                        isSlotAvailable = true;

                        box.innerHTML =
                                "<span class='text-success'>✔ Slot available</span>";

                    } else {

                        isSlotAvailable = false;

                        box.innerHTML =
                                "<span class='text-danger'>⚠ Slot already booked</span>";
                    }

                } catch (error) {

                    console.log(error);

                    box.innerHTML =
                            "<span class='text-danger'>⚠ Error checking availability</span>";
                }
            }

        // ==========================
        // FINAL SUBMIT VALIDATION
        // ==========================
            function validateBooking() {

                const box = document.getElementById("statusBox");

                // SLOT TAK AVAILABLE
                if (!isSlotAvailable) {

                    Swal.fire({
                        icon: "error",
                        title: "Slot Not Available",
                        text: "Please choose another booking time"
                    });

                    return false;
                }

                // OTHER ERROR
                if (box.innerText.includes("⚠")) {

                    Swal.fire({
                        icon: "error",
                        title: "Invalid Booking",
                        text: "Please fix booking details"
                    });

                    return false;
                }

                return true;
            }

        // ==========================
        // ALERT MESSAGE
        // ==========================
            const params = new URLSearchParams(window.location.search);

            if (params.get("success") === "1") {

                Swal.fire({
                    icon: "success",
                    title: "Booking Submitted",
                    text: "Waiting for admin approval"
                });

            }

            if (params.get("error") === "conflict") {

                Swal.fire({
                    icon: "error",
                    title: "Slot Unavailable",
                    text: "Selected slot has already been booked"
                });

            }

            if (params.get("error") === "session") {

                Swal.fire({
                    icon: "warning",
                    title: "Session Expired",
                    text: "Please login again"
                });

            }

        // ==========================
        // EVENT LISTENER
        // ==========================
            document.getElementById("bookingDate")
                    .addEventListener("change", function () {

                        validateDateNotPast();

                        updateRules();

                    });

            document.getElementById("startTime")
                    .addEventListener("input", liveValidate);

            document.getElementById("endTime")
                    .addEventListener("input", liveValidate);


            document.getElementById("bookingDate")
                    .addEventListener("change", checkAvailability);

            document.getElementById("startTime")
                    .addEventListener("change", checkAvailability);

            document.getElementById("endTime")
                    .addEventListener("change", checkAvailability);
       
        
        if (params.get("error") === "onehourrule") {

    Swal.fire({
        icon: "error",
        title: "Booking Too Late",
        text: "Bookings must be made at least 1 hour earlier"
    });
}</script>
    </body>
</html>