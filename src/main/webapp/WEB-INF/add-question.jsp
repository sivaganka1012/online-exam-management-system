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
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Question</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(to right, #d4f1f9, #f5fafd);
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding-top: 80px;
        }

        .navbar {
            background-color: #1a1a1a;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 60px;
            z-index: 1000;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0;
        }

        .navbar-brand {
            color: #fff;
            font-size: 24px;
            font-weight: bold;
            text-decoration: none;
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
            padding: 0 15px;
            text-decoration: none;
            font-size: 16px;
            display: flex;
            align-items: center;
            height: 100%;
        }

        .navbar a:hover {
            background-color: #333;
            color: #8f8467;
        }

        .form-box {
            max-width: 800px;
            margin: 40px auto;
            background: #ffffff;
            padding: 45px;
            border-radius: 35px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.08);
        }

        .form-title {
            background-color: #0d6efd;
            color: white;
            padding: 20px 30px;
            border-radius: 25px;
            text-align: center;
            font-size: 36px;
            font-weight: bold;
            margin-bottom: 40px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        }

        .section-box {
            background-color: #f4f4f4;
            border-radius: 20px;
            padding: 25px 30px;
            margin-bottom: 25px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.03);
        }

        .form-control {
            border-radius: 25px;
            padding: 12px 18px;
            font-size: 16px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
        }

        .btn-pill {
            border-radius: 30px;
            padding: 12px 28px;
            font-size: 16px;
            font-weight: 500;
            text-decoration: none;
        }

        .btn-primary {
            background-color: #0d6efd;
            color: white;
            border: none;
        }

        .btn-outline-primary {
            background-color: transparent;
            border: 2px solid #0d6efd;
            color: #0d6efd;
        }

        .btn-outline-primary:hover {
            background-color: #0d6efd;
            color: white;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
            border: none;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
        }

        .button-row {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 30px;
            flex-wrap: wrap;
        }

        .button-single {
            display: flex;
            justify-content: center;
            margin-top: 15px;
        }

        @media (max-width: 576px) {
            .form-title {
                font-size: 28px;
            }

            .btn-pill {
                width: 100%;
                text-align: center;
            }

            .button-row {
                flex-direction: column;
                align-items: center;
            }

            .button-single {
                margin-top: 20px;
            }
        }
    </style>
</head>
<body>

<!-- 🔷 Navbar -->
<div class="navbar">
    <a href="/dashboard" class="navbar-brand">MY<span>EXAM</span>360</a>
    <div class="navbar-links">
        <a href="/dashboard">Home</a>
        <a href="/take-exam"></a>
        <a href="/result">Results</a>
        <a href="/profile">Profile</a>
        <a href="/logout">Logout</a>
    </div>
</div>

<!-- 🔷 Form Box -->
<div class="form-box">
    <div class="form-title">➕ Add Questions</div>

    <form action="/exams/add-question" method="post">
        <div class="section-box">
            <label for="examId">Exam ID</label>
            <input type="text" class="form-control" id="examId" name="examId" value="${param.examId}" required>
        </div>

        <div class="section-box">
            <label for="question">Question</label>
            <input type="text" class="form-control" id="question" name="question" required>
        </div>

        <div class="section-box">
            <label for="opt1">Option 1</label>
            <input type="text" class="form-control" id="opt1" name="opt1" required>

            <label for="opt2">Option 2</label>
            <input type="text" class="form-control" id="opt2" name="opt2" required>

            <label for="opt3">Option 3</label>
            <input type="text" class="form-control" id="opt3" name="opt3" required>

            <label for="opt4">Option 4</label>
            <input type="text" class="form-control" id="opt4" name="opt4" required>
        </div>

        <div class="section-box">
            <label for="correct">Correct Option (1–4)</label>
            <input type="number" class="form-control" id="correct" name="correct" min="1" max="4" required>
        </div>

        <div class="text-center mt-4">
            <button type="submit" class="btn btn-primary btn-pill">Add Question</button>
        </div>
    </form>

    <!-- 🔘 Button Row 1 -->
    <div class="button-row">
        <a href="/add-question?examId=${param.examId}" class="btn btn-outline-primary btn-pill">➕ Add Another Question</a>
        <a href="/create-exam" class="btn btn-secondary btn-pill">⬅ Back to Create Exam</a>
    </div>

    <!-- 🔘 Button Row 2 -->
    <div class="button-single">
        <a href="/exams/view-all" class="btn btn-outline-primary btn-pill">👁️ View All Exams & Questions</a>
    </div>
</div>

</body>
</html>
