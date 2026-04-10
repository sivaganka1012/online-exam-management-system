


<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ page import="java.util.*, com.onlineexam.model.Exam" %>--%>
<%--<%@ page session="true" %>--%>
<%--<%--%>
<%--    com.onlineexam.model.User user = (com.onlineexam.model.User) session.getAttribute("user");--%>
<%--    if (user == null || !"student".equals(user.getRole())) {--%>
<%--        response.sendRedirect("login.jsp");--%>
<%--        return;--%>
<%--    }--%>

<%--    java.util.List<Exam> exams = new com.onlineexam.service.ExamService().getAllExams();--%>
<%--%>--%>





<%--<!DOCTYPE html>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <title>Take Exam</title>--%>
<%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">--%>
<%--    <style>--%>


<%--        body {--%>
<%--            background-color: #f4f7fb;--%>
<%--            padding-top: 60px;--%>

<%--            font-family: 'Segoe UI', sans-serif;--%>
<%--        }--%>



<%--        .exam-box {--%>
<%--            max-width: 600px;--%>
<%--            margin: auto;--%>
<%--            background: white;--%>
<%--            padding: 40px;--%>
<%--            border-radius: 20px;--%>
<%--            box-shadow: 0 10px 25px rgba(0,0,0,0.1);--%>
<%--        }--%>
<%--    </style>--%>



<%--</head>--%>
<%--<body>--%>


<%--<%@ include file="header.jsp" %>--%>


<%--<div class="exam-box">--%>
<%--    <h3>Select an Exam</h3>--%>

<%--    <form action="/take-question" method="get">--%>
<%--        <label for="examId" class="form-label mt-3">Choose Exam:</label>--%>
<%--        <select class="form-select" name="examId" id="examId" required>--%>
<%--            <% for (Exam e : exams) { %>--%>
<%--            <option value="<%= e.getExamId() %>"><%= e.getTitle() %></option>--%>
<%--            <% } %>--%>
<%--        </select>--%>

<%--        <button type="submit" class="btn btn-primary mt-4">Start Exam</button>--%>
<%--    </form>--%>


<%--</div>--%>

<%--</body>--%>
<%--</html>--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.onlineexam.model.Exam" %>
<%@ page session="true" %>
<%
    com.onlineexam.model.User user = (com.onlineexam.model.User) session.getAttribute("user");
    if (user == null || !"student".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    java.util.List<Exam> exams = new com.onlineexam.service.ExamService().getAllExams();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Take Exam</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f7fb;
            padding-top: 60px;
            font-family: 'Segoe UI', sans-serif;
        }
        .exam-container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 20px;
        }
        .exam-card {
            text-decoration: none; /* Removes underline */
            color: inherit; /* Inherit text color instead of link blue */
        }

        .exam-card {
            background: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 20px;
            margin: 15px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            display: inline-block;
            width: 200px;
            vertical-align: top;
            cursor: pointer;
        }
        .exam-container h2 {
            text-align: center;
            font-weight: bold;
            margin-bottom: 40px;
        }

        .exam-card {
            background: #f9f9f9;
            border: 1px solid #ddd;
            border-left: 5px solid #b5bba1; /* Add side line */
            border-radius: 10px;
            padding: 20px;
            margin: 15px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            display: inline-block;
            width: 200px;
            vertical-align: top;
            cursor: pointer;
        }
        .exam-card h5 {
            color: #2c3e50;
            margin: 0;
        }
        .exam-card:hover {
            background-color: #e9ecef;
        }
        .exam-cards-wrapper {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            padding: 20px;
            background-color: #e4e6e8;
            border-radius: 12px;
        }

    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<div class="exam-container">
    <h2>Available Exams</h2>
    <div class="exam-cards-wrapper">
        <% for (Exam exam : exams) { %>
        <a href="/take-question?examId=<%= exam.getExamId() %>" class="exam-card">
            <h5><%= exam.getTitle() %></h5>
        </a>
        <% } %>
    </div>




</div>


<a href="/dashboard" class="btn btn-secondary">
    <i class="fas fa-arrow-left"></i> Return to Dashboard
</a>

</body>
</html>
