<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.util.*, com.onlineexam.model.Result, com.onlineexam.service.ResultService" %>

<%
        ResultService service = new ResultService();
        List<Result> results = service.loadResultsFromFile();

        // Selection sort - descending by score
        for (int i = 0; i < results.size() - 1; i++) {
            int maxIndex = i;
            for (int j = i + 1; j < results.size(); j++) {
                if (results.get(j).getScorePercentage() > results.get(maxIndex).getScorePercentage()) {
                    maxIndex = j;
                }
            }
            if (i != maxIndex) {
                Result temp = results.get(i);
                results.set(i, results.get(maxIndex));
                results.set(maxIndex, temp);
            }
        }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title> Rank List </title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>body { background-color: #eef6fd;
        padding: 60px;
        font-family: 'Segoe UI', sans-serif;}    .container {
                                                                max-width: 900px;
                                                                margin: auto;
                                                                background-color: white;
                                                                padding: 40px;
                                                                border-radius: 25px;
                                                                box-shadow: 0 8px 25px rgba(0,0,0,0.08);
                                                            }

    h2 {
        text-align: center;
        color: #0d6efd;
        margin-bottom: 30px;
        font-size: 32px;
    }

    th {
        background-color: #0d6efd;
        color: white;
    }

    td {
        font-size: 16px;
    }
    </style>



</head>
<body>





<div class="container">
    <h2>🏆 Student Rank List</h2>
    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <th>Rank</th>
            <th>Username</th>
            <th>Exam ID</th>
            <th>Score (%)</th>
        </tr>
        </thead>
        <tbody> <% int rank = 1; for (Result r : results) { %>
        <tr>
            <td><%= rank++ %></td>
            <td><%= r.getUsername() %></td>
            <td><%= r.getExamId() %></td>
            <td><%= r.getScorePercentage() %></td>
        </tr><% } %>
        </tbody>
    </table>
</div>

<div class="text-center mt-3"> <a href="/top-ranks" class="btn btn-outline-success">🏅 View Top 3 Students</a>



    <a href="/dashboard" class="btn btn-secondary">
        <i class="fas fa-arrow-left"></i> Back to Dashboard
    </a>


</div>



</body>
</html>

