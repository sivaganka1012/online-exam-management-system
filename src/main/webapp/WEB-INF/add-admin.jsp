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
    <title>Add Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #4361ee;
            --primary-dark: #3a56d4;
            --secondary-color: #6c757d;
            --light-bg: #f8f9fa;
            --form-shadow: 0 15px 35px rgba(0,0,0,0.1);
            --transition: all 0.3s ease;
        }

        body {
            background-color: var(--light-bg);
            padding: 3rem 1rem;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .form-container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 3rem 4rem;
            border-radius: 20px;
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
            height: 6px;
            background: linear-gradient(90deg, var(--primary-color), var(--primary-dark));
        }

        .form-header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .form-title {
            font-size: 2.2rem;
            font-weight: 700;
            color: var(--primary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1rem;
            margin-bottom: 0.5rem;
        }

        .form-subtitle {
            color: #6c757d;
            font-size: 1.1rem;
            max-width: 600px;
            margin: 0 auto;
        }

        .form-group {
            margin-bottom: 2rem;
        }

        .form-label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 0.8rem;
            display: flex;
            align-items: center;
            gap: 0.8rem;
            font-size: 1.1rem;
        }

        .form-control {
            padding: 1rem 1.5rem;
            border-radius: 10px;
            border: 2px solid #e9ecef;
            font-size: 1.1rem;
            transition: var(--transition);
            height: auto;
            width: 100%;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.3rem rgba(67, 97, 238, 0.2);
        }

        .form-footer {
            display: flex;
            flex-direction: row;
            gap: 1.5rem;
            margin-top: 3rem;
            justify-content: center;
        }

        .btn {
            padding: 1rem 2rem;
            border-radius: 10px;
            font-weight: 600;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.8rem;
            min-width: 220px;
            font-size: 1.1rem;
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(67, 97, 238, 0.3);
        }

        .btn-secondary {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
        }

        .btn-secondary:hover {
            background-color: #5a6268;
            border-color: #5a6268;
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(108, 117, 125, 0.2);
        }

        @media (max-width: 768px) {
            .form-container {
                padding: 2.5rem;
                max-width: 90%;
            }

            .form-footer {
                flex-direction: column;
                gap: 1rem;
            }

            .btn {
                width: 100%;
            }
        }

        @media (max-width: 576px) {
            body {
                padding: 1.5rem 0.5rem;
            }

            .form-container {
                padding: 2rem 1.5rem;
            }

            .form-title {
                font-size: 1.8rem;
            }

            .form-control {
                padding: 0.8rem 1.2rem;
            }
        }
    </style>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="form-container">
    <div class="form-header">
        <h1 class="form-title">
            <i class="fas fa-user-shield"></i> Add New Administrator
        </h1>
        <p class="form-subtitle">Please fill in all required fields to register a new system administrator</p>
    </div>

    <form action="/users/add-admin" method="post">
        <div class="form-group">
            <label for="id" class="form-label">
                <i class="fas fa-id-card"></i> Administrator ID
            </label>
            <input type="text" class="form-control" id="id" name="id" required placeholder="Enter unique admin ID (e.g. ADM001)">
        </div>

        <div class="form-group">
            <label for="username" class="form-label">
                <i class="fas fa-user-tie"></i> Username
            </label>
            <input type="text" class="form-control" id="username" name="username" required placeholder="Enter admin username">
        </div>

        <div class="form-group">
            <label for="password" class="form-label">
                <i class="fas fa-key"></i> Password
            </label>
            <input type="text" class="form-control" id="password" name="password" required placeholder="Create secure password">
        </div>

        <!-- Fixed role -->
        <input type="hidden" name="role" value="admin">

        <div class="form-footer">
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-user-plus"></i> Register Administrator
            </button>

            <a href="/dashboard" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Return to Dashboard
            </a>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

