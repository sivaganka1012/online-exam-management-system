<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



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
  <title>View Exams & Questions</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    body {
      background-color: #f0f4f8;
      font-family: 'Segoe UI', sans-serif;
      margin: 0;
      padding-top: 80px;
    }

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
      height: 60px;
    }

    .navbar-brand {
      color: #fff;
      font-size: 24px;
      font-weight: bold;
      text-decoration: none;
      padding: 0 20px;
      display: flex;
      align-items: center;
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
      transition: all 0.3s;
      height: 100%;
      display: flex;
      align-items: center;
    }

    .navbar a:hover {
      background-color: #333;
      color: #8f8467;
    }

    .content {
      max-width: 1000px;
      margin: 40px auto;
      background: white;
      border-radius: 30px;
      padding: 40px;
      box-shadow: 0 0 20px rgba(0,0,0,0.05);
    }

    .title-box {
      background-color: #0d6efd;
      color: white;
      font-size: 30px;
      font-weight: bold;
      padding: 20px 35px;
      border-radius: 25px;
      box-shadow: 0 6px 15px rgba(0,0,0,0.1);
      margin-bottom: 40px;
      width: 100%;
      text-align: left;
    }

    .exam-title {
      font-size: 24px;
      font-weight: 600;
      color: #0d6efd;
      margin-bottom: 20px;
      border-bottom: 2px solid #ddd;
      padding-bottom: 10px;
    }

    .question-box {
      background-color: #f9f9f9;
      border-radius: 20px;
      padding: 20px;
      margin-bottom: 25px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.03);
    }

    .question-box p {
      font-size: 18px;
      margin-bottom: 8px;
    }

    .option {
      padding-left: 20px;
      font-size: 16px;
    }

    .divider {
      border-top: 2px dashed #ccc;
      margin: 40px 0;
    }

    .correct {
      font-style: italic;
      color: #28a745;
    }

    .back-btn-container {
      text-align: center;
      margin-top: 30px;
    }

    .btn-back {
      background-color: #6c757d;
      border: none;
      color: white;
      padding: 12px 30px;
      border-radius: 30px;
      font-size: 16px;
      font-weight: 500;
      transition: background-color 0.3s;
      text-decoration: none;
    }

    .btn-back:hover {
      background-color: #5a6268;
    }
  </style>
</head>
<body>

<!-- 🔷 Navbar -->
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

<!-- 🔷 Main Content -->
<div class="content">
  <div class="title-box">View Exams & Questions</div>

  <c:forEach var="exam" items="${examMap}">
    <div class="exam-title">${exam.value.examId} - ${exam.value.title}




      <form action="delete-exam" method="post" style="display:inline;">
        <input type="hidden" name="examId" value="${exam.value.examId}">
        <button type="submit" class="btn btn-danger btn-sm"
                onclick="return confirm('Are you sure you want to delete this exam?')">
          🗑 Delete Exam
        </button>
      </form>




    </div>

    <c:forEach var="q" items="${exam.value.questions}">




      <form action="delete-question" method="post" style="display:inline-block;">
        <input type="hidden" name="examId" value="${exam.value.examId}">
        <input type="hidden" name="questionText" value="${q.questionText}">
        <button class="btn btn-danger btn-sm" onclick="return confirm('Delete this question?')">🗑 Delete Question</button>
      </form>







      <div class="question-box">
        <p><strong>Q:</strong> ${q.questionText}</p>
        <p class="option">1. ${q.options[0]}</p>
        <p class="option">2. ${q.options[1]}</p>
        <p class="option">3. ${q.options[2]}</p>
        <p class="option">4. ${q.options[3]}</p>
        <p class="correct">✔ Correct Option: ${q.correctIndex+1}</p>
      </div>
    </c:forEach>



    <div class="divider"></div>
  </c:forEach>

  <!-- ✅ Working Back Button -->
  <div class="back-btn-container">
    <a href="/add-question" class="btn btn-back">⬅ Back to Add Question</a>
  </div>
</div>

</body>
</html>

