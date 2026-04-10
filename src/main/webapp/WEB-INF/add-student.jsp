<%@ page contentType="text/html;charset=UTF-8" language="java" %>




<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Student</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-blue: #0d6efd;
            --primary-dark: #0b5ed7;
            --secondary-gray: #6c757d;
            --light-bg: #eef2f7;
            --form-shadow: 0 10px 30px rgba(0,0,0,0.1);
            --transition: all 0.3s ease;
        }

        body {
            background-color: var(--light-bg);
            padding: 80px 20px;
            font-family: 'Segoe UI', sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .form-box {
            max-width: 800px;  /* Increased from 600px */
            margin: 0 auto;
            background: white;
            padding: 50px 60px;  /* Increased horizontal padding */
            border-radius: 20px;
            box-shadow: var(--form-shadow);
            position: relative;
            overflow: hidden;
        }

        .form-box::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, var(--primary-blue), #4facfe);
        }

        .form-title {
            font-size: 32px;  /* Slightly larger */
            font-weight: 700;
            margin-bottom: 35px;
            text-align: center;
            color: var(--primary-blue);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }

        .form-label {
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 10px;
            font-size: 18px;  /* Slightly larger */
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-control {
            padding: 14px 22px;  /* Slightly larger */
            border-radius: 12px;
            border: 2px solid #e9ecef;
            font-size: 17px;  /* Slightly larger */
            transition: var(--transition);
        }

        .form-control:focus {
            border-color: var(--primary-blue);
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
        }

        .btn-container {
            display: flex;
            flex-direction: row;
            gap: 20px;
            margin-top: 40px;
            justify-content: center;
        }

        .btn-custom {
            border-radius: 35px;
            padding: 14px 35px;  /* Slightly larger */
            font-size: 18px;
            font-weight: 600;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            min-width: 220px;
        }

        .btn-primary {
            background-color: var(--primary-blue);
            border-color: var(--primary-blue);
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
            transform: translateY(-3px);
            box-shadow: 0 7px 20px rgba(13, 110, 253, 0.3);
        }

        .btn-secondary {
            background-color: var(--secondary-gray);
            border-color: var(--secondary-gray);
        }

        .btn-secondary:hover {
            background-color: #5a6268;
            border-color: #5a6268;
            transform: translateY(-3px);
            box-shadow: 0 7px 20px rgba(108, 117, 125, 0.2);
        }

        @media (max-width: 992px) {
            .form-box {
                max-width: 700px;
                padding: 40px 50px;
            }
        }

        @media (max-width: 768px) {
            body {
                padding: 60px 15px;
            }

            .form-box {
                max-width: 90%;
                padding: 35px;
            }

            .btn-container {
                flex-direction: column;
                gap: 15px;
            }

            .btn-custom {
                width: 100%;
            }
        }

        @media (max-width: 576px) {
            .form-title {
                font-size: 26px;
            }

            .form-control {
                padding: 12px 18px;
            }

            .btn-custom {
                padding: 12px 25px;
                font-size: 16px;
            }
        }
    </style>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="form-box">
    <div class="form-title">
        <i class="fas fa-user-graduate"></i> Add New Student
    </div>

    <form action="/users/add-student" method="post">
        <div class="mb-4">
            <label for="id" class="form-label">
                <i class="fas fa-id-card"></i> Student ID
            </label>
            <input type="text" class="form-control" id="id" name="id" required placeholder="Enter student ID (e.g., STU2023001)">
        </div>

        <div class="mb-4">
            <label for="username" class="form-label">
                <i class="fas fa-user"></i> Username
            </label>
            <input type="text" class="form-control" id="username" name="username" required placeholder="Enter student username">
        </div>

        <div class="mb-4">
            <label for="password" class="form-label">
                <i class="fas fa-lock"></i> Password
            </label>
            <input type="text" class="form-control" id="password" name="password" required placeholder="Create student password">
        </div>

        <!-- Role is fixed as 'student' -->
        <input type="hidden" name="role" value="student">

        <div class="btn-container">
            <button type="submit" class="btn btn-primary btn-custom">
                <i class="fas fa-user-plus"></i> Register Student
            </button>

            <a href="/dashboard" class="btn btn-secondary btn-custom">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

