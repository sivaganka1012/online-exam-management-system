<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page import="com.onlineexam.model.User" %>
<%
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        // Use session user
        String username = user.getUsername();

        String examId = request.getParameter("examId");
        String scoreStr = request.getParameter("score");
        String totalStr = request.getParameter("total");

        int score = 0;
        int total = 0;
        int percentage = 0;

        try {
            score = Integer.parseInt(scoreStr);
            total = Integer.parseInt(totalStr);
            percentage = (int)(((double) score / total) * 100);
        } catch (Exception e) {
            out.println("<h3 style='color:red;'>Invalid score or total. Please retry.</h3>");
            return;
        }

        if (examId == null || examId.isEmpty()) {
            out.println("<h3 style='color:red;'>Exam ID is missing.</h3>");
            return;
        }
%>

<!DOCTYPE html> <html> <head> <meta charset="UTF-8"> <title>Exam Result</title> <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"> <style> body { background-color: #f5f9ff; font-family: 'Segoe UI', sans-serif; padding: 60px; }
.result-box {
    max-width: 600px;
    margin: auto;
    background: white;
    padding: 50px;
    border-radius: 25px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.08);
    text-align: center;
}

.result-box h2 {
    color: #0d6efd;
    font-weight: bold;
    margin-bottom: 30px;
}

.result-box p {
    font-size: 20px;
    margin: 10px 0;
}

.btn-home {
    margin-top: 30px;
}
</style>
</head>

<body>


<%@ include file="header.jsp" %>


<div class="result-box"> <h2>🎉 Exam Result</h2> <p><strong>Student:</strong> <%= username %></p> <p><strong>Exam ID:</strong> <%= examId %></p> <p><strong>Score:</strong> <%= score %> out of <%= total %></p> <p><strong>Percentage:</strong> <%= percentage %>%</p>
    <a href="dashboard" class="btn btn-outline-primary btn-home">🔙 Back to Dashboard</a>
</div> </body> </html>


