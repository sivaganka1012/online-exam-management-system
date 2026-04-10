<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.onlineexam.model.User" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>



<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Teacher</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #4361ee;
            --primary-dark: #3a56d4;
            --secondary-color: #6c757d;
            --light-bg: #f8f9fa;
            --form-shadow: 0 10px 30px rgba(0,0,0,0.1);
            --transition: all 0.3s ease;
        }

        body {
            background-color: var(--light-bg);
            padding: 2rem;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .form-container {
            max-width: 700px;
            margin: 0 auto;
            background: white;
            padding: 2.5rem;
            border-radius: 15px;
            box-shadow: var(--form-shadow);
            position: relative;
            overflow: hidden;
        }

        .form-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, var(--primary-color), var(--primary-dark));
        }

        .form-header {
            text-align: center;
            margin-bottom: 2.5rem;
        }

        .form-title {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
            margin-bottom: 0.5rem;
        }

        .form-subtitle {
            color: #6c757d;
            font-size: 1rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-control {
            padding: 0.75rem 1.25rem;
            border-radius: 8px;
            border: 2px solid #e9ecef;
            font-size: 1rem;
            transition: var(--transition);
            height: auto;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(67, 97, 238, 0.25);
        }

        .form-footer {
            display: flex;
            flex-direction: column;
            gap: 1rem;
            margin-top: 2rem;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
            width: 100%;
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.3);
        }

        .btn-secondary {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
        }

        .btn-secondary:hover {
            background-color: #5a6268;
            border-color: #5a6268;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(108, 117, 125, 0.2);
        }

        @media (min-width: 768px) {
            .form-footer {
                flex-direction: row;
                justify-content: center;
            }
            .btn {
                width: auto;
                min-width: 200px;
            }
        }

        @media (max-width: 576px) {
            body {
                padding: 1.5rem;
            }
            .form-container {
                padding: 1.5rem;
            }
            .form-title {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="form-container">
    <div class="form-header">
        <h1 class="form-title">
            <i class="fas fa-chalkboard-teacher"></i> Add New Teacher
        </h1>
        <p class="form-subtitle">Enter teacher details below</p>
    </div>

    <form action="/users/add-teacher" method="post">
        <div class="form-group">
            <label for="id" class="form-label">
                <i class="fas fa-id-card"></i> Teacher ID
            </label>
            <input type="text" class="form-control" id="id" name="id" required placeholder="Enter teacher ID (e.g., TEA001)">
        </div>

        <div class="form-group">
            <label for="username" class="form-label">
                <i class="fas fa-user"></i> Username
            </label>
            <input type="text" class="form-control" id="username" name="username" required placeholder="Enter username">
        </div>

        <div class="form-group">
            <label for="password" class="form-label">
                <i class="fas fa-lock"></i> Password
            </label>
            <input type="text" class="form-control" id="password" name="password" required placeholder="Enter password">
        </div>

        <!-- Role is fixed as 'teacher' -->
        <input type="hidden" name="role" value="teacher">

        <div class="form-footer">
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-user-plus"></i> Add Teacher
            </button>

            <a href="/dashboard" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

