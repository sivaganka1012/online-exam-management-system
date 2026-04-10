<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.onlineexam.model.Result" %>
<%@ include file="header.jsp" %>

<%
    List<Result> topResults = (List<Result>) request.getAttribute("topResults");
%>

<!DOCTYPE html>
<html>
<head>
    <title>🏆 Top 3 Ranks</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/> </head>
<body
<%--        style="padding: 60px;--%>
 background-color: #f5f5f5;
  font-family: 'Segoe UI'">




<div class="container bg-white p-4 rounded shadow">
    <h2 class="mb-4">🏆 Top 3 Students</h2>
    <table class="table table-bordered table-hover">
        <thead class="table-dark">
        <tr>
            <th>Rank</th>
            <th>Username</th>
            <th>Exam ID</th>
            <th>Score (%)</th>
        </tr>
        </thead>
        <tbody> <% int rank = 1; for (Result r : topResults) { %> <tr>
            <td><%= rank++ %></td>
            <td><%= r.getUsername() %></td>
            <td><%= r.getExamId() %></td>
            <td><%= r.getScorePercentage() %></td>
        </tr> <% } %>
        </tbody>
    </table>


    <a href="/dashboard" class="btn btn-secondary">
        <i class="fas fa-arrow-left"></i> Back to Dashboard
    </a>

</div>
</body>
</html>

