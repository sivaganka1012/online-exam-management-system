<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ page import="com.onlineexam.model.*, com.onlineexam.service.ExamService, java.util.*" %>--%>

<%--<%@ page session="true" %>--%>
<%--<%--%>
<%--    User user = (User) session.getAttribute("user");--%>
<%--    if (user == null || !"student".equals(user.getRole())) {--%>
<%--        response.sendRedirect("login.jsp");--%>
<%--        return;--%>
<%--    }--%>

<%--    String examId = request.getParameter("examId");--%>
<%--    int qIndex = request.getParameter("qIndex") == null ? 0 : Integer.parseInt(request.getParameter("qIndex"));--%>

<%--    ExamService examService = new ExamService();--%>
<%--    List<Question> questions = examService.getQuestionsByExamId(examId);--%>

<%--    if (questions == null || questions.size() == 0) {--%>
<%--        out.println("<h4>No questions found for this exam.</h4>");--%>
<%--        return;--%>
<%--    }--%>

<%--    if (qIndex >= questions.size()) {--%>
<%--        response.sendRedirect("thank-you.jsp"); // after last question--%>
<%--        return;--%>
<%--    }--%>

<%--    Question q = questions.get(qIndex);--%>
<%--%>--%>
<%--<!DOCTYPE html>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <title>Question <%= (qIndex + 1) %></title>--%>
<%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">--%>
<%--</head>--%>
<%--<body style="background-color: #f4f7fb; padding: 50px; font-family: 'Segoe UI';">--%>

<%--<div class="container bg-white p-5 rounded shadow" style="max-width: 700px;">--%>
<%--    <h4>Question <%= (qIndex + 1) %>:</h4>--%>
<%--    <p><strong><%= q.getQuestionText() %></strong></p>--%>

<%--    <form action="/submit-answer" method="post">--%>
<%--        <input type="hidden" name="examId" value="<%= examId %>">--%>
<%--        <input type="hidden" name="qIndex" value="<%= qIndex %>">--%>
<%--        <input type="hidden" name="username" value="<%= user.getUsername() %>">--%>

<%--        <%--%>
<%--            String[] opts = q.getOptions();--%>
<%--            for (int i = 0; i < opts.length; i++) {--%>
<%--        %>--%>
<%--        <div class="form-check">--%>
<%--            <input class="form-check-input" type="radio" name="answer" value="<%= i %>" required>--%>
<%--            <label class="form-check-label"><%= opts[i] %></label>--%>
<%--        </div>--%>
<%--        <% } %>--%>

<%--        <br>--%>
<%--        <button type="submit" class="btn btn-primary">--%>
<%--            <%= (qIndex == questions.size() - 1) ? "Submit" : "Next" %>--%>
<%--        </button>--%>
<%--    </form>--%>
<%--</div>--%>

<%--</body>--%>
<%--</html>--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.onlineexam.model.*, com.onlineexam.service.ExamService, java.util.*" %>
<%@ page session="true" %>
<%@ include file="header.jsp" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"student".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    String examId = request.getParameter("examId");
    int qIndex = request.getParameter("qIndex") == null ? 0 : Integer.parseInt(request.getParameter("qIndex"));

    ExamService examService = new ExamService();
    List<Question> questions = examService.getQuestionsByExamId(examId);

    // Store questions in session to persist across requests
    session.setAttribute("questions", questions);
    session.setAttribute("examId", examId);

    if (questions == null || questions.isEmpty()) {
        out.println("<h4>No questions found for this exam.</h4>");
        return;
    }

    if (qIndex >= questions.size()) {
        response.sendRedirect("thank-you.jsp"); // after last question
        return;
    }

    if (qIndex < 0) {
        qIndex = 0; // Prevent going below 0
    }

    Question q = questions.get(qIndex);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Take Question</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            /*background-color: #efeeee; !* Light grayish tone *!*/
            font-family: 'Segoe UI', sans-serif;
        }
        .question-container {
            max-width: 800px;
            margin: auto;
            background: #e4e6e8; /* Light sand color */
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }
        .question-number {
            font-size: 16px;
            color: #000000; /* Gray tone */
            margin-bottom: 10px;
            padding-bottom: 8px;
            border-bottom: 1px solid #6C757D; /* Line under question number */
        }
        .question-text {
            font-size: 18px;
            color: #000000; /* Black text */
            margin-bottom: 20px;
        }
        .options {
            margin-bottom: 20px;
        }
        .options .form-check {
            margin: 10px 0;
        }
        .options .form-check-label {
            color: #000000; /* Black text for options */
        }
        .nav-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        .number-pad {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 20px;
        }
        .number-pad a {
            text-decoration: none;
            color: #007BFF; /* Blue for numbers */
            background: #E9ECEF; /* Light gray background */
            border: 1px solid #CED4DA;
            border-radius: 5px;
            padding: 5px 10px;
            margin: 5px;
            font-size: 16px;
        }
        .number-pad a:hover {
            background: #DEE2E6; /* Slightly darker on hover */
        }
        .number-pad a.active {
            background: #007BFF; /* Blue for active */
            color: white;
        }
        .btn-primary {
            background-color: #007BFF; /* Blue for Next */
            border-color: #007BFF;
        }
        .btn-primary:hover {
            background-color: #0056B3;
            border-color: #0056B3;
        }
        .btn-secondary {
            background-color: #6C757D; /* Gray for Previous */
            border-color: #6C757D;
        }
        .btn-secondary:hover {
            background-color: #5A6268;
            border-color: #5A6268;
        }
        .btn-success {
            background-color: #28A745; /* Green for Submit */
            border-color: #28A745;
        }
        .btn-success:hover {
            background-color: #218838;
            border-color: #218838;
        }
        .exam-container h3 {
            text-align: center;
            font-weight: bold;
            margin-bottom: 40px;
        }
    </style>
</head>
<body>
<div class="exam-container">
    <h3>YOUR EXAM YOUR WAY</h3>
    <div class="question-container">
        <div class="question-number">
            Question <%= (qIndex + 1) %>
        </div>
        <div class="question-text">
            <strong><%= q.getQuestionText() %></strong>
        </div>

        <form id="questionForm" action="/submit-answer" method="post">
            <input type="hidden" name="examId" value="<%= examId %>">
            <input type="hidden" name="qIndex" value="<%= qIndex %>">
            <input type="hidden" name="username" value="<%= user.getUsername() %>">
            <input type="hidden" name="action" value="submit">

            <div class="options">
                <%
                    String[] opts = q.getOptions();
                    for (int i = 0; i < opts.length; i++) {
                %>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="answer" value="<%= i %>" required>
                    <label class="form-check-label"><%= opts[i] %></label>
                </div>
                <% } %>
            </div>

            <div class="nav-buttons">
                <% if (qIndex > 0) { %>
                <a href="/take-question?examId=<%= examId %>&qIndex=<%= (qIndex - 1) %>" class="btn btn-secondary">Previous</a>
                <% } else { %>
                <button type="button" class="btn btn-secondary" disabled>Previous</button>
                <% } %>

                <% if (qIndex < questions.size() - 1) { %>
                <a href="/take-question?examId=<%= examId %>&qIndex=<%= (qIndex + 1) %>" class="btn btn-primary">Next</a>
                <% } else { %>
                <button type="submit" class="btn btn-success">Submit</button>
                <% } %>
            </div>

            <div class="number-pad">
                <% for (int i = 0; i < questions.size(); i++) { %>
                <a href="/take-question?examId=<%= examId %>&qIndex=<%= i %>" class="<%= (i == qIndex) ? "active" : "" %>">
                    <%= (i + 1) %>
                </a>
                <% } %>
            </div>
        </form>
    </div>
</body>
</html>