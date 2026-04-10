<%--i create this for when i press view resutls it shoud be show the resutls of the profile--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.onlineexam.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        .results-table {
            margin-top: 20px;
        }
        .results-table th {
            background-color: #007bff;
            color: white;
        }
        .results-table td {
            text-align: center;
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

    <h4 class="mt-4">📊 Exam Results</h4>
    <c:if test="${not empty error}">
        <p class="text-danger">${error}</p>
    </c:if>
    <c:choose>
        <c:when test="${empty results}">
            <p>No exam results found.</p>
        </c:when>
        <c:otherwise>
            <table class="table table-bordered results-table">
                <thead>
                <tr>
                    <th>Exam ID</th>
                    <th>Total Questions</th>
                    <th>Correct Answers</th>
                    <th>Score (%)</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="result" items="${results}">
                    <tr>
                        <td>${result.examId}</td>
                        <td>${result.totalQuestions}</td>
                        <td>${result.correctAnswers}</td>
                        <td>${result.scorePercentage}%</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>