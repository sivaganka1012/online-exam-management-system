<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



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



<html>
<head>
  <title>Manual Result Entry</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
  <style>
    :root {
      --primary: #4361ee;
      --primary-dark: #3a56d4;
      --secondary: #3f37c9;
      --light: #f8f9fa;
      --dark: #212529;
      --success: #4cc9f0;
      --border-radius: 12px;
      --shadow: 0 10px 20px rgba(0,0,0,0.1);
      --secondary-btn: #6c757d;
      --secondary-btn-dark: #5a6268;
    }

    body {
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
      margin: 0;
      padding: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
    }

    .form-container {
      background: white;
      border-radius: var(--border-radius);
      box-shadow: var(--shadow);
      padding: 2.5rem;
      width: 100%;
      max-width: 500px;
      position: relative;
      overflow: hidden;
    }

    .form-container::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 6px;
      background: linear-gradient(90deg, var(--primary), var(--secondary));
    }

    h2 {
      color: var(--dark);
      margin: 0 0 1.5rem 0;
      text-align: center;
      font-weight: 600;
      font-size: 1.8rem;
    }

    .form-group {
      margin-bottom: 1.5rem;
      position: relative;
    }

    label {
      display: block;
      margin-bottom: 0.5rem;
      color: var(--dark);
      font-weight: 500;
      font-size: 0.9rem;
    }

    select, input[type="number"] {
      width: 100%;
      padding: 0.8rem 1rem;
      border: 2px solid #e9ecef;
      border-radius: 8px;
      font-size: 1rem;
      transition: all 0.3s ease;
      background-color: #f8f9fa;
      appearance: none;
    }

    select {
      background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
      background-repeat: no-repeat;
      background-position: right 1rem center;
      background-size: 1em;
    }

    select:focus, input[type="number"]:focus {
      border-color: var(--primary);
      box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.2);
      outline: none;
      background-color: white;
    }

    button {
      background: var(--primary);
      color: white;
      border: none;
      padding: 1rem;
      width: 100%;
      border-radius: 8px;
      font-size: 1rem;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.3s ease;
      margin-top: 0.5rem;
      letter-spacing: 0.5px;
      text-transform: uppercase;
    }

    button:hover {
      background: var(--primary-dark);
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(67, 97, 238, 0.3);
    }

    button:active {
      transform: translateY(0);
    }

    .floating-label {
      position: absolute;
      pointer-events: none;
      left: 1rem;
      top: 0.8rem;
      transition: 0.2s ease all;
      color: #6c757d;
      font-size: 1rem;
    }

    select:focus ~ .floating-label,
    select:not([value=""]):valid ~ .floating-label,
    input:focus ~ .floating-label,
    input:not(:placeholder-shown) ~ .floating-label {
      top: -0.5rem;
      left: 0.8rem;
      font-size: 0.75rem;
      background: white;
      padding: 0 0.2rem;
      color: var(--primary);
    }

    .btn-secondary {
      display: inline-block;
      background: var(--secondary-btn);
      color: white;
      text-align: center;
      padding: 0.8rem;
      border-radius: 8px;
      text-decoration: none;
      font-weight: 500;
      margin-top: 1rem;
      width: 100%;
      transition: all 0.3s ease;
      border: none;
      cursor: pointer;
      font-family: 'Poppins', sans-serif;
      font-size: 1rem;
    }

    .btn-secondary:hover {
      background: var(--secondary-btn-dark);
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }

    .btn-secondary:active {
      transform: translateY(0);
    }

    .button-container {
      display: flex;
      flex-direction: column;
      gap: 0.5rem;
    }

    @media (max-width: 576px) {
      .form-container {
        padding: 1.5rem;
        margin: 1rem;
      }
    }
  </style>
</head>
<body>
<div class="form-container">
  <h2>Enter Written Marks</h2>
  <form action="/manual/submit" method="post">
    <div class="form-group">
      <select name="studentId" id="studentId" required>
        <option value="" selected disabled></option>
        <% for (String s : (List<String>) request.getAttribute("students")) { %>
        <option value="<%= s %>"><%= s %></option>
        <% } %>
      </select>
      <span class="floating-label">Student ID</span>
    </div>

    <div class="form-group">
      <select name="examId" id="examId" required>
        <option value="" selected disabled></option>
        <% for (String e : (List<String>) request.getAttribute("exams")) { %>
        <option value="<%= e %>"><%= e %></option>
        <% } %>
      </select>
      <span class="floating-label">Exam ID</span>
    </div>

    <div class="form-group">
      <input type="number" name="written" id="written" required placeholder=" ">
      <span class="floating-label">Written Marks</span>
    </div>

    <div class="button-container">
      <button type="submit">
        <span>Submit Result</span>
      </button>
      <a href="/dashboard" class="btn-secondary">⬅ Back to Dashboard</a>
    </div>
  </form>
</div>
</body>
</html>

