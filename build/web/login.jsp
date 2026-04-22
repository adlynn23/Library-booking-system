<%-- 
    Document   : login
    Created on : 19 Apr 2026, 6:15:37 pm
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="head.jsp" %>
<div class="container mt-5">
  <h2 class="text-center">Login</h2>
  <form>
    <div class="mb-3">
      <label class="form-label">Username</label>
      <input type="text" class="form-control">
    </div>
    <div class="mb-3">
      <label class="form-label">Password</label>
      <input type="password" class="form-control">
    </div>
    <button type="submit" class="btn btn-primary w-100">Login</button>
  </form>
</div>
