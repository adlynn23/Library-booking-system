<%@page contentType="text/html" pageEncoding="UTF-8"%>



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
    if (endTimeParam == null)
        endTimeParam = "";
%>

<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>Booking | EduSpace</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
              rel="stylesheet">

        <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&display=swap"
              rel="stylesheet">

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <style>

            :root{
                --edu-green:#163832;
                --soft-bg:#f7efe5;
            }

            body{
                background:var(--soft-bg);
                font-family:'DM Sans',sans-serif;
            }

            .booking-container{
                max-width:850px;
                margin:50px auto;
                background:white;
                padding:40px;
                border-radius:25px;
                box-shadow:0 10px 30px rgba(0,0,0,0.05);
            }

            h1{
                font-weight:700;
                color:#2b2b2b;
            }

            .form-label{
                font-weight:700;
                color:#374151;
                margin-bottom:10px;
            }

            .form-control{
                height:60px;
                border-radius:15px;
                border:1px solid #e5d6c7;
            }

            textarea.form-control{
                height:auto;
            }

            .info-box{
                background:#f8f8f8;
                border-left:5px solid var(--edu-green);
                padding:15px;
                border-radius:10px;
                margin-bottom:25px;
            }

            .btn-submit{
                width:100%;
                background:#9a4f0f;
                border:none;
                color:white;
                font-weight:700;
                padding:16px;
                border-radius:12px;
                font-size:1.1rem;
            }

            .btn-submit:hover{
                opacity:0.9;
            }

            #statusBox{
                font-weight:600;
                margin-top:5px;
            }

            .success{
                color:green;
            }

            .error{
                color:red;
            }

        </style>

    </head>

    <body>

        <jsp:include page="header.jsp"/>

        <div class="container">

            <div class="booking-container">

                <h1>Facility Reservation</h1>

                <p class="text-muted mb-4">
                    Fill in your booking details
                </p>

                <form action="BookingServlet"
                      method="POST"
                      onsubmit="return validateBooking()">

                    <!-- FACILITY -->
                    <div class="mb-4">

                        <label class="form-label">
                            Facility
                        </label>

                        <input type="text"
                               class="form-control"
                               value="<%= facilityName%>"
                               readonly>

                        <input type="hidden"
                               name="facilityName"
                               value="<%= facilityName%>">

                    </div>

                    <!-- DATE -->
                    <div class="mb-3">

                        <label class="form-label">
                            Booking Date
                        </label>

                        <input type="date"
                               id="bookingDate"
                               name="bookingDate"
                               class="form-control"
                               value="<%= bookingDate%>"
                               readonly
                               required>

                    </div>

                    <!-- INFO BOX -->
                    <div class="info-box">

                        <div>
                            Selected Day:
                            <b id="selectedDay">-</b>
                        </div>

                        <div>
                            Operating Hours:
                            <b id="operatingHours">-</b>
                        </div>

                    </div>

                    <!-- TIME -->
                    <div class="row">

                        <div class="col-md-6 mb-4">

                            <label class="form-label">
                                Start Time
                            </label>

                            <input type="time"
                                   id="startTime"
                                   name="startTime"
                                   class="form-control"
                                   value="<%= startTimeParam%>"
                                   readonly
                                   required>

                        </div>

                        <div class="col-md-6 mb-4">

                            <label class="form-label">
                                End Time
                            </label>
                            <input type="time"
                                   id="endTime"
                                   name="endTime"
                                   class="form-control"
                                   value="<%= endTimeParam%>"
                                   readonly
                                   required>

                        </div>

                    </div>

                    <!-- STATUS -->
                    <div id="statusBox"></div>

                    <!-- PURPOSE -->
                    <div class="mb-4 mt-3">

                        <label class="form-label">
                            Purpose
                        </label>

                        <textarea name="purpose"
                                  class="form-control"
                                  rows="5"
                                  required></textarea>

                    </div>

                    <button type="submit"
                            class="btn-submit">

                        CONFIRM BOOKING

                    </button>

                </form>

            </div>

        </div>

        <script>

            const bookingDate =
                    document.getElementById("bookingDate");

            const startTime =
                    document.getElementById("startTime");

            const endTime =
                    document.getElementById("endTime");

            const statusBox =
                    document.getElementById("statusBox");

            const selectedDayText =
                    document.getElementById("selectedDay");

            const operatingHoursText =
                    document.getElementById("operatingHours");

            let isSlotAvailable = true;

            // ==========================
            // DISABLE PAST DATE
            // ==========================
            const today =
                    new Date().toISOString().split("T")[0];

            bookingDate.min = today;

            // ==========================
            // DAY + OPERATING HOURS
            // ==========================
            function updateOperatingHours() {

                const value = bookingDate.value;

                if (!value)
                    return;

                const date =
                        new Date(value);

                const day =
                        date.getDay();

                const days =
                        ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

                selectedDayText.innerText =
                        days[day];

                // WEEKDAY
                if (day >= 1 && day <= 5) {

                    operatingHoursText.innerText =
                            "08:00 - 22:00";

                }

                // WEEKEND
                else {

                    operatingHoursText.innerText =
                            "09:00 - 18:00";

                }

            }

            // ==========================
            // MAIN VALIDATION
            // ==========================
            async function validateTimeRules() {

                statusBox.innerHTML = "";

                const date =
                        bookingDate.value;

                const start =
                        startTime.value;

                const end =
                        endTime.value;

                if (!date || !start || !end) {
                    return;
                }

                const selectedDate =
                        new Date(date);

                const now =
                        new Date();

                const day =
                        selectedDate.getDay();

                const startHour =
                        parseInt(start.split(":")[0]);

                const endHour =
                        parseInt(end.split(":")[0]);

                // ==========================
                // END AFTER START
                // ==========================
                if (end <= start) {

                    statusBox.innerHTML =
                            "<span class='error'>⚠ End time must be after start time</span>";

                    return;
                }

                // ==========================
                // MAX 2 HOURS
                // ==========================
                const startDateTime =
                        new Date(date + "T" + start);

                const endDateTime =
                        new Date(date + "T" + end);

                const diffHours =
                        (endDateTime - startDateTime)
                        / (1000 * 60 * 60);

                if (diffHours > 2) {

                    statusBox.innerHTML =
                            "<span class='error'>⚠ Maximum booking is 2 hours only</span>";

                    return;
                }

                // ==========================
                // OPERATING HOURS
                // ==========================

                // WEEKDAY
                if (day >= 1 && day <= 5) {

                    if (startHour < 8 || endHour > 22) {

                        statusBox.innerHTML =
                                "<span class='error'>⚠ Booking allowed only between 8AM - 10PM</span>";

                        return;
                    }

                }

                // WEEKEND
                else {

                    if (startHour < 9 || endHour > 18) {

                        statusBox.innerHTML =
                                "<span class='error'>⚠ Booking allowed only between 9AM - 6PM</span>";

                        return;
                    }

                }

                // ==========================
                // 1 HOUR EARLY RULE
                // ==========================
                const currentDateTime =
                        new Date();

                const oneHourDiff =
                        (startDateTime - currentDateTime)
                        / (1000 * 60);

                if (oneHourDiff < 60) {

                    statusBox.innerHTML =
                            "<span class='error'>⚠ Booking must be made at least 1 hour earlier</span>";

                    return;
                }

                // ==========================
                // CHECK SLOT AVAILABILITY
                // ==========================
                const facility =
                        document.querySelector("input[name='facilityName']").value;

                try {

                    const response =
                            await fetch(
                                    "CheckAvailabilityServlet"
                                    + "?facility=" + encodeURIComponent(facility)
                                    + "&date=" + date
                                    + "&start=" + start
                                    + "&end=" + end
                                    );

                    const data =
                            await response.json();

                    if (data.available) {

                        isSlotAvailable = true;

                        statusBox.innerHTML =
                                "<span class='success'>✔ Slot available</span>";

                    } else {

                        isSlotAvailable = false;

                        statusBox.innerHTML =
                                "<span class='error'>⚠ Slot already booked</span>";

                    }

                } catch (e) {

                    statusBox.innerHTML =
                            "<span class='error'>⚠ Error checking slot</span>";

                }

            }

            // ==========================
            // SUBMIT VALIDATION
            // ==========================
            function validateBooking() {

                if (statusBox.innerText.includes("⚠")) {

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

            // ==========================
            // EVENT LISTENERS
            // ==========================
            bookingDate.addEventListener("change", () => {

                updateOperatingHours();
                validateTimeRules();

            });

            startTime.addEventListener("change", validateTimeRules);

            endTime.addEventListener("change", validateTimeRules);

            const params = new URLSearchParams(window.location.search);

            if (params.get("error") === "pasttime") {
                Swal.fire({
                    icon: "error",
                    title: "Past Time",
                    text: "Selected booking time has already passed."
                });
            }

            window.onload = function () {

                updateOperatingHours();
                validateTimeRules();

            };
        </script>

    </body>
</html>