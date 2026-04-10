<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.onlineexam.model.ManualResult, java.util.*" %>
<%
    List<ManualResult> results = (List<ManualResult>) request.getAttribute("results");
%>
<html>
<head>
    <title>Final Results</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --light-bg: #f8f9fa;
            --table-header: #2c3e50;
            --table-row-even: #ffffff;
            --table-row-odd: #f8f9fa;
            --success-color: #28a745;
            --shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--light-bg);
            padding: 2rem;
            color: #333;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            box-shadow: var(--shadow);
            padding: 2rem;
        }

        h2 {
            color: var(--table-header);
            margin-bottom: 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid var(--primary-color);
            display: inline-block;
        }

        .results-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-bottom: 2rem;
            overflow: hidden;
            border-radius: 8px;
            box-shadow: var(--shadow);
        }

        .results-table th {
            background-color: var(--primary-color);
            color: white;
            padding: 1rem;
            text-align: left;
            font-weight: 500;
        }

        .results-table td {
            padding: 0.8rem 1rem;
            border-bottom: 1px solid #e9ecef;
        }

        .results-table tr:nth-child(even) {
            background-color: var(--table-row-even);
        }

        .results-table tr:nth-child(odd) {
            background-color: var(--table-row-odd);
        }

        .results-table tr:hover {
            background-color: rgba(67, 97, 238, 0.05);
        }

        .btn {
            padding: 0.6rem 1.2rem;
            border-radius: 6px;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
            border: none;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .grade-A { color: var(--success-color); font-weight: bold; }
        .grade-B { color: #17a2b8; font-weight: bold; }
        .grade-C { color: #ffc107; font-weight: bold; }
        .grade-D { color: #fd7e14; font-weight: bold; }
        .grade-F { color: #dc3545; font-weight: bold; }

        .table-responsive {
            overflow-x: auto;
        }

        @media (max-width: 768px) {
            body {
                padding: 1rem;
            }
            .container {
                padding: 1rem;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h2><i class="fas fa-list-check"></i> All Final Results</h2>

    <div class="table-responsive">
        <table class="results-table">
            <thead>
            <tr>
                <th><i class="fas fa-id-card"></i> Student ID</th>
                <th><i class="fas fa-file-alt"></i> Exam ID</th>
                <th><i class="fas fa-check-circle"></i> MCQ Marks</th>
                <th><i class="fas fa-edit"></i> Written Marks</th>
                <th><i class="fas fa-calculator"></i> Total</th>
                <th><i class="fas fa-star"></i> Grade</th>
            </tr>
            </thead>
            <tbody>
            <% for (ManualResult r : results) { %>
            <tr>
                <td><%= r.getStudentId() %></td>
                <td><%= r.getExamId() %></td>
                <td><%= r.getMcqMarks() %></td>
                <td><%= r.getWrittenMarks() %></td>
                <td><%= r.getTotalMarks() %></td>
                <td class="grade-<%= r.getGrade() %>"><%= r.getGrade() %></td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>

    <a href="/manual/enter" class="btn btn-secondary">
        <i class="fas fa-arrow-left"></i> Back to Entry
    </a>
</div>

<div>
<a href="/dashboard" class="btn btn-secondary">
    <i class="fas fa-arrow-left"></i> Return to Dashboard
</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
