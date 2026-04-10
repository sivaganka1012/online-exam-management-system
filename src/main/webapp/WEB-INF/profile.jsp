<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.onlineexam.model.User" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', sans-serif;
            padding: 60px;
        }
        .profile-box {
            max-width: 600px;
            margin: auto;
            background: white;
            padding: 40px;
            border-radius: 25px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>



<%@ include file="header.jsp" %>



<div class="profile-box">
    <h3 class="mb-4">👤 My Profile</h3>
    <p><strong>User ID:</strong> <%= user.getUserId() %></p>
    <p><strong>Username:</strong> <%= user.getUsername() %></p>
    <p><strong>Role:</strong> <%= user.getRole() %></p>

    <a href="dashboard" class="btn btn-primary mt-4">⬅ Back to Dashboard</a>




</div>

</body>
</html>
