<%@page import="model.Facility"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Map<String, List<String>> bookedMap
            = (Map<String, List<String>>) request.getAttribute("bookedMap");

    List<Facility> facilities
            = (List<Facility>) request.getAttribute("facilities");

    Integer sh = (Integer) request.getAttribute("startHour");
    Integer eh = (Integer) request.getAttribute("endHour");

    int startHour = (sh != null) ? sh : 8;
    int endHour = (eh != null) ? eh : 18;

    String facilityType
            = (String) request.getAttribute("facilityType");

    String date
            = (String) request.getAttribute("date");
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Facility Availability</title>


        <style>

            body{
                font-family: Arial, sans-serif;
                background:#f3f4f6;
                margin:0;
                padding:30px;
            }

            .page-header{
                background:white;
                padding:25px;
                border-radius:15px;
                box-shadow:0 4px 10px rgba(0,0,0,0.1);
                margin-bottom:25px;
            }

            .page-header h1{
                margin:0;
                color:#18352f;
            }

            .meta{
                margin-top:15px;
                display:flex;
                gap:10px;
                flex-wrap:wrap;
            }

            .badge{
                background:#e5e7eb;
                padding:8px 14px;
                border-radius:20px;
                font-size:13px;
                font-weight:bold;
            }

            .facility-card{
                background:white;
                padding:20px;
                border-radius:15px;
                margin-bottom:25px;
                box-shadow:0 4px 10px rgba(0,0,0,0.08);
            }

            .facility-name{
                font-size:20px;
                font-weight:bold;
                margin-bottom:15px;
                color:#111827;
            }

            .slot-grid{
                display:grid;
                grid-template-columns:repeat(auto-fit,minmax(90px,1fr));
                gap:10px;
            }

            .slot{
                padding:12px;
                text-align:center;
                border-radius:10px;
                background:#d1fae5;
                font-weight:bold;
                cursor:pointer;
                transition:0.2s;
            }

            .slot:hover{
                background:#10b981;
                color:white;
                transform:scale(1.05);
            }

            .slot.booked{
                background:#ef4444;
                color:white;
                cursor:not-allowed;
                pointer-events:none;
                opacity:0.85;
            }
            .slot{
                display:block;
                text-decoration:none;
                color:black;
            }
            .back-btn{
                display:inline-block;
                margin-bottom:20px;
                padding:10px 18px;
                background:#18352f;
                color:white;
                text-decoration:none;
                border-radius:8px;
                font-weight:bold;
            }

        </style>
    <a href="FacilityServlet"
       class="back-btn">
        ← Back
    </a>
</head>

<body>

    <div class="page-header">

        <h1>
            <%= facilityType != null ? facilityType : "Facility Availability"%>
        </h1>

        <div class="meta">

            <span class="badge">
                📅 Date:
                <%= date != null ? date : "-"%>
            </span>

            <span class="badge">
                ⏰ Operating Hours:
                <%= startHour%>:00 - <%= endHour%>:00
            </span>

        </div>

    </div>

    <%
        if (facilities != null && !facilities.isEmpty()) {

            for (Facility f : facilities) {

                String unitName = f.getUnitName();

                List<String> bookedTimes
                        = bookedMap != null
                                ? bookedMap.get(unitName)
                                : null;
    %>

    <div class="facility-card">

        <div class="facility-name">
            <%= unitName%>
        </div>

        <div class="slot-grid">

            <%
                for (int hour = startHour; hour < endHour; hour++) {

                    String time
                            = (hour < 10 ? "0" + hour : String.valueOf(hour))
                            + ":00";

                    boolean isBooked
                            = bookedTimes != null
                            && bookedTimes.contains(time);
            %>

            <% if (isBooked) {%>

            <div class="slot booked">
                <%=time%><br>
                Booked
            </div>

            <% } else { %>

            <%
                String endTime
                        = (hour + 1 < 10
                                ? "0" + (hour + 1)
                                : String.valueOf(hour + 1))
                        + ":00";
            %>

            <a class="slot"
               href="booking.jsp?unit=<%=java.net.URLEncoder.encode(f.getUnitName(), "UTF-8")%>&date=<%=date%>&startTime=<%=time%>&endTime=<%=endTime%>">
                <%=time%>
            </a>

            <% } %>

            <%
                }
            %>

        </div>

    </div>

    <%
        }
    } else {
    %>

    <div class="facility-card">
        <h3>No facilities found.</h3>
    </div>

    <%
        }
    %>

</body>
</html>