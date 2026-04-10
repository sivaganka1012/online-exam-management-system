<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: url('images/background.jpeg') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Segoe UI', sans-serif;
        }
        .container {
            max-width: 400px;
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
        .error {
            color: red;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>MY EXAM360</h2>
    <c:if test="${param.error eq 'true'}">
        <p class="error">Invalid username or password</p>
    </c:if>
    <c:if test="${param.error eq 'invalid-username'}">
        <p class="error">Username must be 3-20 characters, alphanumeric only</p>
    </c:if>
    <c:if test="${param.error eq 'invalid-password'}">
        <p class="error">Password must be 8+ characters with uppercase, lowercase, digit, and special character</p>
    </c:if>
    <form action="/users/login" method="post">
        <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <input type="text" class="form-control" name="username" id="username" value="" autocomplete="off" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" name="password" id="password" value="" autocomplete="new-password" required>
        </div>
        <button type="submit" class="btn btn-success w-100">Login</button>
        <div class="mt-3 text-center">
            Don't have an account? <a href="/register"> Register</a>
        </div>
    </form>
</div>
</body>
</html>