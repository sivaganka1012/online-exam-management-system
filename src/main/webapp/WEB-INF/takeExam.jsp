<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Take Exam - MYEXAM360</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f7f9fc;
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding-top: 70px; /* space for fixed header */
        }

        .navbar {
            background-color: #1a1a1a;
            color: white;
            height: 60px;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 25px;
        }

        .navbar-title {
            font-size: 22px;
            font-weight: bold;
        }

        .logout-link {
            color: #f2f2f2;
            text-decoration: none;
            font-weight: 500;
        }

        .logout-link:hover {
            color: #dc3545;
        }

        .exam-container {
            max-width: 800px;
            margin: auto;
            background: white;
            padding: 40px;
            border-radius: 25px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            text-align: left;
        }

        .question {
            margin-bottom: 20px;
        }

        .question h4 {
            font-size: 18px;
            font-weight: bold;
        }

        .question-options {
            margin-left: 20px;
        }
    </style>
</head>
<body>

<!-- 🔷 Header Bar -->
<div class="navbar">
    <div class="navbar-title">MYEXAM360 - Take Exam</div>
    <a href="../logout.jsp" class="logout-link">Logout</a>
</div>

<!-- 🔷 Main Content -->
<div class="exam-container">
    <h3>Take the Exam: <%= exam.getExamName() %></h3>
    <form action="/submitExam" method="POST">

        <!-- Dynamically Display Questions -->
        <c:forEach var="question" items="${exam.questions}">
            <div class="question">
                <h4>${question.questionText}</h4>
                <div class="question-options">
                    <c:if test="${question instanceof MCQQuestion}">
                        <!-- Multiple Choice Question Options -->
                        <c:forEach var="option" items="${question.options}">
                            <div>
                                <input type="radio" name="answer${question.id}" value="${option}" required> ${option}
                            </div>
                        </c:forEach>
                    </c:if>

                    <c:if test="${question instanceof TrueFalseQuestion}">
                        <!-- True/False Question Options -->
                        <div>
                            <input type="radio" name="answer${question.id}" value="True" required> True
                        </div>
                        <div>
                            <input type="radio" name="answer${question.id}" value="False" required> False
                        </div>
                    </c:if>
                </div>
            </div>
        </c:forEach>

        <button type="submit" class="btn btn-primary mt-3">Submit Exam</button>
    </form>
</div>

</body>
</html>
