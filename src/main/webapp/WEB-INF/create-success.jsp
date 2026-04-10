<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Exam Created</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #eef6ff;
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding-top: 80px; /* space for fixed navbar */
        }

        /* ✅ Header Navbar */
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

        /* ✅ Success Box */
        .success-box {
            max-width: 700px;
            margin: 60px auto;
            background: #ffffff;
            padding: 50px 40px;
            border-radius: 35px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            text-align: center;
        }

        h2 {
            color: #198754;
            font-size: 38px;
            font-weight: bold;
            margin-bottom: 30px;
        }

        .btn-custom {
            border-radius: 35px;
            padding: 14px 40px;
            font-size: 20px;
            margin: 15px 20px;
            font-weight: 500;
        }

        .btn-primary {
            background-color: #0d6efd;
            border: none;
        }

        .btn-outline-success {
            border: 2px solid #198754;
            color: #198754;
        }

        .btn-outline-success:hover {
            background-color: #198754;
            color: white;
        }

        @media (max-width: 600px) {
            h2 {
                font-size: 30px;
            }
            .btn-custom {
                font-size: 18px;
                padding: 12px 24px;
                margin: 10px 10px;
            }
        }
    </style>
</head>
<body>

<!-- ✅ Shared Header -->
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

<!-- ✅ Main Success Box -->
<div class="success-box">
    <h2>✅ Exam Created Successfully!</h2>

    <div class="d-flex justify-content-center flex-wrap">
        <a href="/create-exam" class="btn btn-primary btn-custom">➕ Create Another Exam</a>
        <a href="/add-question?examId=${param.examId}" class="btn btn-outline-success btn-custom">➕ Add Question</a>
    </div>
</div>

</body>
</html>
