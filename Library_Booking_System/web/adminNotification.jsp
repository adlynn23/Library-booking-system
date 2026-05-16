<%-- 
    Document   : adminNotification
    Created on : 16 May 2026, 8:53:41?pm
    Author     : ASUS
--%>

<%@page import="java.sql.*"%>

<h2>Notifications</h2>

<%
Connection conn = DriverManager.getConnection(
    "jdbc:mysql://localhost:3307/librarydb",
    "root",
    ""
);

String sql =
    "SELECT * FROM notification ORDER BY created_at DESC";

PreparedStatement ps = conn.prepareStatement(sql);
ResultSet rs = ps.executeQuery();

while(rs.next()){
%>

<div style="padding:12px; border:1px solid #ddd; margin-bottom:10px; border-radius:10px;">
    <p><%= rs.getString("message") %></p>
    <small><%= rs.getTimestamp("created_at") %></small>

    <% if(rs.getString("status").equals("UNREAD")) { %>
        <a href="MarkNotificationReadServlet?id=<%= rs.getInt("id") %>">
            Mark as read
        </a>
    <% } %>
</div>

<%
}
conn.close();
%>