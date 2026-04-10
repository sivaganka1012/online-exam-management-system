<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page import="com.onlineexam.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String examId = request.getParameter("examId");
    String score = request.getParameter("score");
    String total = request.getParameter("total");
%>





<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thank You</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f7f9fc;
            padding: 100px;
            font-family: 'Segoe UI', sans-serif;
        }

        .box {
            max-width: 600px;
            margin: auto;
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .btn-custom {
            margin-top: 25px;
        }
    </style>
</head>
<body>


<%@ include file="header.jsp" %>




<div class="box">
    <h2>✅ Thank You for Taking the Exam!</h2>
    <p>Your responses have been recorded.</p>

    <form action="/result" method="get">
        <input type="hidden" name="username" value="<%= user.getUsername() %>">
        <input type="hidden" name="examId" value="<%= examId %>">
        <input type="hidden" name="score" value="<%= request.getParameter("score") %>">
        <input type="hidden" name="total" value="<%= request.getParameter("total") %>">
        <button type="submit" class="btn btn-primary btn-custom">View My Result</button>
    </form>




    <form action="/rank-list" method="get">
        <input type="hidden" name="examId" value="<%= examId %>">
        <button type="submit" class="btn btn-success btn-custom">🏆 View Rank List</button>
    </form>



</div>

</body>
</html>
