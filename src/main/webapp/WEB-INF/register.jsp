<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: url('images/background.jpeg') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Segoe UI', sans-serif;
        }
        .container {
            max-width: 500px;
            margin-top: 80px;
            background: white;
            padding: 30px;
            border-radius: 25px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 25px;
            font-weight: bold;
        }
        .alert {
            text-align: center;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>MY EXAM360</h2>
    <c:if test="${param.error == 'username-exists'}">
        <div class="alert alert-danger">⚠️ Username already exists. Please choose another.</div>
    </c:if>
    <c:if test="${param.error == 'invalid-username'}">
        <div class="alert alert-danger">⚠️ Username must be 3-20 characters, alphanumeric only.</div>
    </c:if>
    <c:if test="${param.error == 'invalid-password'}">
        <div class="alert alert-danger">⚠️ Password must be 8+ characters with uppercase, lowercase, digit, and special character.</div>
    </c:if>
    <form action="/users/register" method="post">
        <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <input type="text" class="form-control" id="username" name="username" value="" autocomplete="off" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password" value="" autocomplete="new-password" required>
        </div>
        <div class="mb-3">
            <label for="role" class="form-label">Role</label>
            <input type="text" class="form-control" id="role" name="role" value="student" readonly>
        </div>
        <button type="submit" class="btn btn-primary w-100">Register</button>
        <div class="mt-3 text-center">
            Already have an account? <a href="/"> Login</a>
        </div>
    </form>
</div>
</body>
</html>