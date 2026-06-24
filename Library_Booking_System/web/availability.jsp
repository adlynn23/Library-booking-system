<%@page import="model.Facility"%>
<%@page import="java.util.*"%>
<%@page import="java.time.*"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Map<String, List<String>> bookedMap =
            (Map<String, List<String>>) request.getAttribute("bookedMap");

    List<Facility> facilities =
            (List<Facility>) request.getAttribute("facilities");

    Integer sh = (Integer) request.getAttribute("startHour");
    Integer eh = (Integer) request.getAttribute("endHour");

    int startHour = (sh != null) ? sh : 8;
    int endHour = (eh != null) ? eh : 18;

    String facilityType = (String) request.getAttribute("facilityType");
    String date = (String) request.getAttribute("date");
    String dayName = (String) request.getAttribute("dayName");

    LocalDate selectedDate = LocalDate.parse(date);
    LocalDateTime now = LocalDateTime.now();

    String displayDate =
            selectedDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));

    int availableUnits = 0;
    int unavailableUnits = 0;

    if (facilities != null) {
        for (Facility f : facilities) {
            if ("AVAILABLE".equalsIgnoreCase(f.getStatus())) {
                availableUnits++;
            } else {
                unavailableUnits++;
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Facility Availability</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        body{
            font-family:'Inter', sans-serif;
            background:#f4f6f8;
            margin:0;
            padding:28px;
            color:#111827;
        }

        .back-btn{
            display:inline-block;
            margin-bottom:18px;
            padding:11px 20px;
            background:#123c35;
            color:white;
            text-decoration:none;
            border-radius:10px;
            font-weight:700;
            box-shadow:0 4px 10px rgba(0,0,0,0.12);
        }

        .page-header{
            background:white;
            padding:28px 30px;
            border-radius:18px;
            box-shadow:0 8px 20px rgba(15,23,42,0.06);
            margin-bottom:24px;
        }

        .page-header h1{
            margin:0;
            color:#123c35;
            font-size:30px;
            font-weight:800;
        }

        .subtitle{
            margin-top:8px;
            color:#6b7280;
            font-size:15px;
        }

        .meta{
            margin-top:20px;
            display:flex;
            gap:10px;
            flex-wrap:wrap;
        }

        .badge{
            background:#f1f5f9;
            padding:8px 14px;
            border-radius:999px;
            font-size:13px;
            font-weight:700;
            color:#111827;
        }

        .legend{
            display:flex;
            gap:20px;
            margin-top:20px;
            flex-wrap:wrap;
        }

        .legend-item{
            display:flex;
            align-items:center;
            gap:8px;
            color:#4b5563;
            font-weight:600;
            font-size:14px;
        }

        .legend-box{
            width:16px;
            height:16px;
            border-radius:5px;
        }

        .legend-available{
            background:#bbf7d0;
        }

        .legend-booked{
            background:#f87171;
        }

        .legend-disabled{
            background:#d1d5db;
        }

        .facility-card{
            background:white;
            padding:20px 24px;
            border-radius:18px;
            margin-bottom:22px;
            box-shadow:0 8px 20px rgba(15,23,42,0.06);
        }

        .facility-name{
            font-size:21px;
            font-weight:800;
            color:#0f172a;
        }

        .facility-info{
            margin-top:6px;
            margin-bottom:16px;
            color:#64748b;
            font-size:14px;
            font-weight:600;
        }

        .slot-grid{
            display:grid;
            grid-template-columns:repeat(auto-fill,minmax(82px,1fr));
            gap:10px;
        }

        .slot{
            display:flex;
            justify-content:center;
            align-items:center;
            height:54px;
            border-radius:10px;
            background:#bbf7d0;
            font-size:15px;
            font-weight:800;
            text-decoration:none;
            color:#111827;
            transition:0.18s;
        }

        .slot:hover{
            background:#22c55e;
            color:white;
            transform:translateY(-2px);
        }

        .slot.booked{
            background:#f87171;
            color:white;
            cursor:not-allowed;
            pointer-events:none;
        }

        .slot.disabled{
            background:#d1d5db;
            color:#6b7280;
            cursor:not-allowed;
            pointer-events:none;
        }

        .facility-disabled{
            display:inline-flex;
            align-items:center;
            gap:8px;
            background:#fff1f2;
            color:#991b1b;
            padding:10px 16px;
            border-radius:999px;
            font-weight:700;
            font-size:14px;
        }

        .empty-card{
            background:white;
            padding:25px;
            border-radius:16px;
            box-shadow:0 8px 20px rgba(15,23,42,0.06);
        }
    </style>
</head>

<body>

<a href="FacilityServlet" class="back-btn">← Back</a>

<div class="page-header">
    <h1><%= facilityType != null ? facilityType : "Facility Availability" %></h1>

    <div class="subtitle">
        Select an available time slot to continue your booking.
    </div>

    <div class="meta">
        <span class="badge">📅 Date: <%= displayDate %></span>
        <span class="badge">🗓 Day: <%= dayName != null ? dayName : "-" %></span>
        <span class="badge">⏰ Operating Hours: <%= startHour %>:00 - <%= endHour %>:00</span>
        <span class="badge">✅ Available Units: <%= availableUnits %></span>
        <span class="badge">🚫 Unavailable Units: <%= unavailableUnits %></span>
    </div>

    <div class="legend">
        <div class="legend-item">
            <span class="legend-box legend-available"></span>
            Available
        </div>

        <div class="legend-item">
            <span class="legend-box legend-booked"></span>
            Booked
        </div>

        <div class="legend-item">
            <span class="legend-box legend-disabled"></span>
            Not Available
        </div>
    </div>
</div>

<%
    if (facilities != null && !facilities.isEmpty()) {
        for (Facility f : facilities) {

            String unitName = f.getUnitName();

            List<String> bookedTimes =
                    bookedMap != null ? bookedMap.get(unitName) : null;

            boolean isAvailable =
                    "AVAILABLE".equalsIgnoreCase(f.getStatus());
%>

<div class="facility-card">

    <div class="facility-name"><%= unitName %></div>

    <div class="facility-info">
        Capacity: <%= f.getCapacity() %> Persons
    </div>

    <% if (!isAvailable) { %>

        <div class="facility-disabled">
            🔒 Not Available
            (<%= f.getUnavailableReason() != null
                    ? f.getUnavailableReason()
                    : "Deactivated by admin" %>)
        </div>

    <% } else { %>

        <div class="slot-grid">

            <%
                for (int hour = startHour; hour < endHour; hour++) {

                    String time =
                            (hour < 10 ? "0" + hour : String.valueOf(hour)) + ":00";

                    String endTime =
                            (hour + 1 < 10 ? "0" + (hour + 1) : String.valueOf(hour + 1)) + ":00";

                    boolean isBooked =
                            bookedTimes != null && bookedTimes.contains(time);

                    LocalTime slotTime = LocalTime.of(hour, 0);
                    LocalDateTime slotDateTime = LocalDateTime.of(selectedDate, slotTime);

                    boolean isPast = slotDateTime.isBefore(now);
                    boolean isTooSoon = slotDateTime.isBefore(now.plusHours(2));

                    if (isBooked) {
            %>

                <div class="slot booked"><%= time %></div>

            <%
                    } else if (isPast || isTooSoon) {
            %>

                <div class="slot disabled"><%= time %></div>

            <%
                    } else {
            %>

                <a class="slot"
                   href="booking.jsp?unit=<%= java.net.URLEncoder.encode(f.getUnitName(), "UTF-8") %>&date=<%= date %>&startTime=<%= time %>&endTime=<%= endTime %>">
                    <%= time %>
                </a>

            <%
                    }
                }
            %>

        </div>

    <% } %>

</div>

<%
        }
    } else {
%>

<div class="empty-card">
    <h3>No facilities found.</h3>
</div>

<%
    }
%>

</body>
</html>