<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.onlineexam.model.User" %>
<%
    User user = (User) request.getAttribute("user");
    if (user == null) {
        response.sendRedirect("view-users.jsp");
        return;
    }
%>

<!DOCTYPE html> <html> <head> <meta charset="UTF-8"> <title>Edit User</title> <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"> <style> body { background-color: #f9f9f9; padding: 80px; font-family: 'Segoe UI', sans-serif; } .form-box { max-width: 600px; margin: auto; background: white; padding: 40px; border-radius: 20px; box-shadow: 0 8px 25px rgba(0,0,0,0.1); } .form-title { font-size: 28px; font-weight: bold; margin-bottom: 30px; text-align: center; color: #0d6efd; } .btn-custom { border-radius: 30px; padding: 12px 30px; font-size: 18px; } </style> </head> <body>


<%@ include file="header.jsp" %>



<div class="form-box"> <div class="form-title">📝 Edit User</div>


    <form action="/users/update" method="post">
        <input type="hidden" name="userId" value="<%= user.getUserId() %>">

        <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <input type="text" class="form-control" name="username" id="username"
                   value="<%= user.getUsername() %>" required>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="text" class="form-control" name="password" id="password"
                   value="<%= user.getPassword() %>" required>
        </div>

        <div class="mb-3">
            <label for="role" class="form-label">Role</label>
            <input type="text" class="form-control" name="role" id="role"
                   value="<%= user.getRole() %>" required>
        </div>

        <div class="text-center">
            <button type="submit" class="btn btn-primary btn-custom">Update User</button>
        </div>
    </form>




    <!-- Delete Form -->
    <form action="/users/delete" method="post" onsubmit="return confirm('Are you sure you want to delete this user?')" style="margin-top: 20px; text-align: center;">
        <input type="hidden" name="userId" value="<%= user.getUserId() %>">
        <button type="submit" class="btn btn-danger btn-custom">🗑 Delete User</button>
    </form>
</div> </body> </html>

