<html>
<head>
    <style>
        .navbar {
            background-color: #1a1a1a;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0;
            height: 60px;
        }

        .navbar-brand {
            color: #fff;
            font-size: 24px;
            font-weight: bold;
            text-decoration: none;
            display: flex;
            align-items: center;
        }

        .navbar-brand span {
            color: #948742;
        }

        .navbar-links {
            display: flex;
            align-items: center;
            height: 100%;
        }

        .navbar a {
            color: #f2f2f2;
            text-align: center;
            padding: 0 15px;
            text-decoration: none;
            font-size: 16px;
            transition: all 0.3s;
            height: 100%;
            display: flex;
            align-items: center;
            line-height: normal;
        }

        .navbar a:hover {
            background-color: #333;
            color: #8f8467;
        }
    </style>
</head>
<body>
<div class="navbar">
    <a href="index.jsp" class="navbar-brand">MY<span>EXAM</span>360</a>
    <div class="navbar-links">
        <a href="index.jsp">Home</a>
        <a href="examList.jsp">Exams</a>
        <a href="results.jsp">Results</a>
        <a href="profile.jsp">Profile</a>
        <a href="logout.jsp">Logout</a>
    </div>
</div>
</body>
</html>
