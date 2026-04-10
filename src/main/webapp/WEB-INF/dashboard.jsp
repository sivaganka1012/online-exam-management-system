<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.onlineexam.model.User" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - MYEXAM360</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous">
    <style>
        :root {
            --primary: #8f8467;
            --secondary: #948742;
            --light-bg: #f9f8f5;
            --card-bg: #ffffff;
            --text-dark: #000000;
            --text-muted: #555555;
            --btn-primary: #4a7c4a;
            --btn-secondary: #3a6ea5;
            --btn-warning: #e6a800;
            --btn-danger: #c82333;
            --btn-info: #17a2b8;
        }

        body {
            background-color: var(--light-bg);
            font-family: 'Segoe UI', sans-serif;
            color: var(--text-dark);
            padding-top: 70px;
            line-height: 1.6;
        }

        a {
            text-decoration: none !important;
        }

        .navbar {
            background-color: #1a1a1a;
            color: white;
            height: 60px;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
            padding: 0 25px;
            --bs-navbar-padding-y: 0.75rem;
        }

        .navbar-brand {
            font-size: 22px;
            font-weight: bold;
        }

        .dashboard-container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }

        .user-card {
            background: var(--card-bg);
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            border-top: 4px solid var(--secondary);
            margin-bottom: 20px;
        }

        .user-info {
            text-align: center;
            margin-bottom: 20px;
        }

        .user-name {
            font-size: 1.8rem;
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 5px;
        }

        .role-badge {
            display: inline-block;
            background: var(--primary);
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 500;
            text-transform: capitalize;
        }

        .actions-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            width: 100%;
        }

        .action-card {
            background: var(--card-bg);
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
            transition: transform 0.2s ease-in-out;
            border: 1px solid rgba(0,0,0,0.05);
            color: var(--text-dark);
        }

        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--bs-box-shadow-lg);
        }

        .action-icon {
            font-size: 1.8rem;
            margin-bottom: 12px;
        }

        .action-title {
            font-weight: 600;
            margin-bottom: 8px;
            color: var(--text-dark);
        }

        .action-btn {
            width: 100%;
            padding: 8px;
            border: none;
            border-radius: 5px;
            font-weight: 500;
            transition: all 0.2s;
            color: white;
            cursor: pointer;
        }

        .action-btn i {
            margin-right: 0.5rem;
        }

        .btn-primary {
            background-color: var(--btn-primary);
        }

        .btn-primary:hover {
            background-color: #3a6a3a;
        }

        .btn-secondary {
            background-color: var(--btn-secondary);
        }

        .btn-secondary:hover {
            background-color: #2d5a8a;
        }

        .btn-warning {
            background-color: var(--btn-warning);
        }

        .btn-warning:hover {
            background-color: #d99a00;
        }

        .btn-danger {
            background-color: var(--btn-danger);
        }

        .btn-danger:hover {
            background-color: #b21f2d;
        }

        .btn-info {
            background-color: var(--btn-info);
        }

        .btn-info:hover {
            background-color: #138496;
        }

        .role-section {
            background: var(--card-bg);
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }

        .section-title {
            color: var(--primary);
            font-weight: 600;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">MYEXAM360</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="/profile"><i class="fas fa-user-circle me-1"></i> <%= user.getUsername() %></a>
                </li>
                <li class="nav-item">
                    <a class="btn btn-outline-danger ms-2" href="/logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="dashboard-container">
    <!-- User Profile Card -->
    <div class="user-card">
        <div class="user-info">
            <h1 class="user-name">Welcome, <%= user.getUsername() %>!</h1>
            <span class="role-badge"><%= user.getRole() %></span>
        </div>
        <div class="actions-container">
            <a href="/profile" class="action-card">
                <div class="action-icon" style="color: var(--btn-secondary);"><i class="fas fa-user-circle"></i></div>
                <div class="action-title">My Profile</div>
                <button class="action-btn btn-secondary"><i class="fas fa-user-circle"></i> View</button>
            </a>
        </div>
    </div>

    <!-- Role-Specific Actions -->
    <div class="role-section">
        <h3 class="section-title">Your Dashboard</h3>
        <div class="actions-container">
            <% if ("admin".equals(user.getRole())) { %>
            <a href="/create-exam" class="action-card">
                <div class="action-icon" style="color: var(--btn-primary);"><i class="fas fa-edit"></i></div>
                <div class="action-title">Create Exam</div>
                <button class="action-btn btn-primary"><i class="fas fa-edit"></i> Create</button>
            </a>
            <a href="/exams/view-all" class="action-card">
                <div class="action-icon" style="color: var(--btn-secondary);"><i class="fas fa-eye"></i></div>
                <div class="action-title">View Exams</div>
                <button class="action-btn btn-secondary"><i class="fas fa-eye"></i> View</button>
            </a>
            <a href="/add-teacher" class="action-card">
                <div class="action-icon" style="color: var(--btn-danger);"><i class="fas fa-chalkboard-teacher"></i></div>
                <div class="action-title">Add Teacher</div>
                <button class="action-btn btn-danger"><i class="fas fa-chalkboard-teacher"></i> Add</button>
            </a>
            <a href="/users/view-users" class="action-card">
                <div class="action-icon" style="color: var(--btn-info);"><i class="fas fa-users"></i></div>
                <div class="action-title">View Users</div>
                <button class="action-btn btn-info"><i class="fas fa-users"></i> View</button>
            </a>
            <a href="/add-student" class="action-card">
                <div class="action-icon" style="color: var(--btn-primary);"><i class="fas fa-user-graduate"></i></div>
                <div class="action-title">Add Student</div>
                <button class="action-btn btn-primary"><i class="fas fa-user-graduate"></i> Add</button>
            </a>
            <a href="/add-admin" class="action-card">
                <div class="action-icon" style="color: var(--btn-warning);"><i class="fas fa-user-shield"></i></div>
                <div class="action-title">Add Admin</div>
                <button class="action-btn btn-warning"><i class="fas fa-user-shield"></i> Add</button>
            </a>
            <a href="/rank-list" class="action-card">
                <div class="action-icon" style="color: var(--btn-warning);"><i class="fas fa-trophy"></i></div>
                <div class="action-title">Rank List</div>
                <button class="action-btn btn-warning"><i class="fas fa-trophy"></i> View</button>
            </a>



            <a href="/students/view" class="action-card">
                <div class="action-icon" style="color: var(--btn-warning);"><i class="fas fa-trophy"></i></div>
                <div class="action-title">View Students</div>
                <button class="action-btn btn-warning"><i class="fas fa-trophy"></i> 📖 View Students</button>
            </a>


            <a href="/manual/enter" class="action-card">
                <div class="action-icon" style="color: var(--btn-primary);"><i class="fas fa-edit"></i></div>
                <div class="action-title">Enter Final Result</div>
                <button class="action-btn btn-primary"><i class="fas fa-edit"></i>Add Result</button>
            </a>


            <% } else if ("teacher".equals(user.getRole())) { %>
            <a href="/create-exam" class="action-card">
                <div class="action-icon" style="color: var(--btn-primary);"><i class="fas fa-edit"></i></div>
                <div class="action-title">Create Exam</div>
                <button class="action-btn btn-primary"><i class="fas fa-edit"></i> Create</button>
            </a>
            <a href="/exams/view-all" class="action-card">
                <div class="action-icon" style="color: var(--btn-secondary);"><i class="fas fa-eye"></i></div>
                <div class="action-title">View Exams</div>
                <button class="action-btn btn-secondary"><i class="fas fa-eye"></i> View</button>
            </a>

            <a href="/manual/enter" class="action-card">
                <div class="action-icon" style="color: var(--btn-primary);"><i class="fas fa-edit"></i></div>
                <div class="action-title">Enter Final Result</div>
                <button class="action-btn btn-primary"><i class="fas fa-edit"></i>Add Result</button>
            </a>




            <% } else if ("student".equals(user.getRole())) { %>
            <a href="/take-exam" class="action-card">
                <div class="action-icon" style="color: var(--btn-primary);"><i class="fas fa-book-open"></i></div>
                <div class="action-title">Take Exam</div>
                <button class="action-btn btn-primary"><i class="fas fa-book-open"></i> Start</button>
            </a>
            <a href="/users/view-results" class="action-card">
                <div class="action-icon" style="color: var(--btn-secondary);"><i class="fas fa-chart-bar"></i></div>
                <div class="action-title">View Results</div>
                <button class="action-btn btn-secondary"><i class="fas fa-chart-bar"></i> View</button>
            </a>
            <a href="/rank-list" class="action-card">
                <div class="action-icon" style="color: var(--btn-warning);"><i class="fas fa-trophy"></i></div>
                <div class="action-title">Rank List</div>
                <button class="action-btn btn-warning"><i class="fas fa-trophy"></i> View</button>
            </a>


            <a href="/manual/view" class="action-card">
                <div class="action-icon" style="color: var(--btn-secondary);"><i class="fas fa-chart-bar"></i></div>
                <div class="action-title">View Final Results</div>
                <button class="action-btn btn-secondary"><i class="fas fa-chart-bar"></i> View</button>
            </a>



            <% } %>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>



