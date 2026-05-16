<%@page import="java.sql.*"%>

<%
int id = Integer.parseInt(request.getParameter("id"));
String status = request.getParameter("status");

Connection conn = DriverManager.getConnection(
    "jdbc:mysql://localhost:3307/librarydb",
    "root",
    ""
);

PreparedStatement ps = conn.prepareStatement(
    "UPDATE facility SET status=? WHERE facility_id=?"
);

ps.setString(1, status);
ps.setInt(2, id);

ps.executeUpdate();

ps.close();
conn.close();

response.sendRedirect("admin_facility.jsp");
%>