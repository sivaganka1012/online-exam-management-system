<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.onlineexam.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Allow both admin and teacher
    if (!"admin".equals(user.getRole()) && !"teacher".equals(user.getRole())) {
        response.sendRedirect("dashboard");
        return;
    }

%>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Exam</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f0f2f5;
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding-top: 70px; /* space for fixed navbar */
        }

        /* 🔷 Shared Navigation Header */
        .navbar {
            background-color: #1a1a1a;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0;
            height: 60px;
        }

        .navbar-brand {
            color: #fff;
            font-size: 24px;
            font-weight: bold;
            text-decoration: none;
            display: flex;
            align-items: center;
            padding: 0 20px;
        }

        .navbar-brand span {
            color: #948742;
        }

        .navbar-links {
            display: flex;
            align-items: center;
            height: 100%;
        }

        .navbar a {
            color: #f2f2f2;
            text-align: center;
            padding: 0 15px;
            text-decoration: none;
            font-size: 16px;
            transition: all 0.3s;
            height: 100%;
            display: flex;
            align-items: center;
            line-height: normal;
        }

        .navbar a:hover {
            background-color: #333;
            color: #8f8467;
        }

        /* 🔷 Exam Form Styling */
        .outer-box {
            max-width: 900px;
            margin: 30px auto;
            background: linear-gradient(145deg, #e3f2fd, #fdfbff);
            border-radius: 40px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            padding: 50px 40px;
            position: relative;
        }

        .form-label {
            font-size: 26px;
            font-weight: 700;
            margin-bottom: 10px;
            color: #2c3e50;
        }

        .form-control {
            height: 65px;
            font-size: 22px;
            font-weight: 500;
            padding: 0 25px;
            border-radius: 50px;
            border: 2px solid #ced4da;
            background-color: #ffffff;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: #0d6efd;
            background-color: #ffffff;
            box-shadow: 0 0 0 0.2rem rgba(13,110,253,.25);
        }

        .button-row {
            display: flex;
            flex-direction: column;
            gap: 15px;
            margin-top: 30px;
        }

        @media (min-width: 576px) {
            .button-row {
                flex-direction: row;
                gap: 20px;
            }
        }

        .btn-pill {
            height: 60px;
            font-size: 22px;
            font-weight: bold;
            border-radius: 50px;
            border: none;
            width: 100%;
            transition: 0.3s ease;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .btn-create {
            background-color: #0d6efd;
        }

        .btn-create:hover {
            background-color: #004aad;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(13, 110, 253, 0.3);
        }

        .btn-clear {
            background-color: #6c757d;
        }

        .btn-clear:hover {
            background-color: #495057;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(108, 117, 125, 0.3);
        }

        /* 🔷 Back Button Styling */
        .btn-back {
            display: inline-block;
            background-color: #6c757d;
            color: white;
            text-align: center;
            padding: 15px 25px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            font-size: 18px;
            margin-top: 30px;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            width: 100%;
            max-width: 300px;
        }

        .btn-back:hover {
            background-color: #495057;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(108, 117, 125, 0.3);
            text-decoration: none;
        }

        .btn-back i {
            margin-right: 10px;
        }

        .back-button-container {
            display: flex;
            justify-content: center;
            width: 100%;
            margin-top: 30px;
        }

        @media (max-width: 768px) {
            .outer-box {
                padding: 30px 20px;
                border-radius: 30px;
                margin: 20px 15px;
            }

            .form-label {
                font-size: 22px;
            }

            .form-control {
                height: 55px;
                font-size: 18px;
            }

            .btn-pill {
                height: 50px;
                font-size: 18px;
            }

            .btn-back {
                padding: 12px 20px;
                font-size: 16px;
            }
        }
    </style>
</head>
<body>

<!-- 🔷 Team Navigation Header -->
<div class="navbar">
    <a href="index.jsp" class="navbar-brand">MY<span>EXAM</span>360</a>
    <div class="navbar-links">
        <a href="/dashboard">Home</a>
        <a href="/take-exam">Exams</a>
        <a href="/result">Results</a>
        <a href="/profile">Profile</a>
        <a href="/logout">Logout</a>
    </div>
</div>

<!-- 🔷 Create Exam Form -->
<div class="outer-box">
    <form id="examForm" action="/exams/create" method="get">
        <div class="mb-4">
            <label for="id" class="form-label">Exam ID</label>
            <input type="text" class="form-control" name="id" id="id" placeholder="e.g., EX001" required>
        </div>

        <div class="mb-4">
            <label for="title" class="form-label">Exam Title</label>
            <input type="text" class="form-control" name="title" id="title" placeholder="e.g., Grade 11 Term Test" required>
        </div>

        <div class="button-row">
            <button type="submit" class="btn btn-pill btn-create">
                <i class="fas fa-plus-circle"></i> Create Exam
            </button>
            <button type="button" class="btn btn-pill btn-clear" onclick="document.getElementById('examForm').reset();">
                <i class="fas fa-eraser"></i> Clear
            </button>
        </div>

        <div class="back-button-container">
            <a href="/dashboard" class="btn-back">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
