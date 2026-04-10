<%@ page import="com.onlineexam.model.StudentNode" %>
<%
    StudentNode student = (StudentNode) request.getAttribute("student");
%>


<html>
<head>
    <title>Student Viewer</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary: #7c4dff;  /* Vibrant purple */
            --secondary: #00bcd4;  /* Teal accent */
            --text: #2d3748;
            --light-bg: #f5f7fa;
            --border: #e2e8f0;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: #ffffff;
            color: var(--text);
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            background-image: radial-gradient(circle at 10% 20%, rgba(124, 77, 255, 0.05) 0%, rgba(124, 77, 255, 0.01) 90%);
        }

        .container {
            background: #fff;
            border-radius: 16px;
            padding: 40px;
            width: 90%;
            max-width: 500px;
            box-shadow: 0 10px 25px rgba(124, 77, 255, 0.1);
            border: 1px solid var(--border);
            transition: transform 0.3s ease;
        }

        .container:hover {
            transform: translateY(-5px);
        }

        h2 {
            margin-top: 0;
            font-weight: 600;
            font-size: 24px;
            color: var(--primary);
            margin-bottom: 20px;
            position: relative;
            display: inline-block;
        }

        h2:after {
            content: '';
            position: absolute;
            width: 50%;
            height: 3px;
            background: linear-gradient(90deg, var(--primary), var(--secondary));
            bottom: -8px;
            left: 25%;
            border-radius: 3px;
        }

        .student-info {
            text-align: left;
            margin: 25px 0;
            padding: 25px;
            background: var(--light-bg);
            border-radius: 12px;
            border-left: 4px solid var(--primary);
        }

        .info-row {
            display: flex;
            align-items: center;
            margin: 15px 0;
            font-size: 16px;
        }

        .info-icon {
            width: 28px;
            height: 28px;
            background: rgba(124, 77, 255, 0.1);
            color: var(--primary);
            margin-right: 12px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
        }

        .nav-buttons {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin: 30px 0;
        }

        button {
            background: var(--primary);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 500;
            transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 2px 10px rgba(124, 77, 255, 0.3);
            position: relative;
            overflow: hidden;
        }

        button:hover {
            background: linear-gradient(135deg, var(--primary), #9c64ff);
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(124, 77, 255, 0.4);
        }

        button:active {
            transform: translateY(0);
        }

        button:after {
            content: "";
            position: absolute;
            top: 50%;
            left: 50%;
            width: 5px;
            height: 5px;
            background: rgba(255, 255, 255, 0.5);
            opacity: 0;
            border-radius: 100%;
            transform: scale(1, 1) translate(-50%);
            transform-origin: 50% 50%;
        }

        button:focus:not(:active)::after {
            animation: ripple 0.6s ease-out;
        }

        @keyframes ripple {
            0% {
                transform: scale(0, 0);
                opacity: 0.5;
            }
            100% {
                transform: scale(20, 20);
                opacity: 0;
            }
        }

        .btn-custom {
            background: white;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            color: var(--primary);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-top: 20px;
            transition: all 0.3s ease;
            border: 1px solid var(--border);
            font-size: 14px;
            font-weight: 500;
        }

        .btn-custom:hover {
            background: var(--light-bg);
            color: var(--primary);
            border-color: var(--primary);
            box-shadow: 0 2px 8px rgba(124, 77, 255, 0.1);
        }

        .no-students {
            font-size: 16px;
            color: #6c757d;
            padding: 20px;
            background: var(--light-bg);
            border-radius: 8px;
            border-left: 4px solid #e0e0e0;
        }

        .divider {
            height: 1px;
            background: linear-gradient(90deg, transparent, var(--border), transparent);
            margin: 25px 0;
        }
    </style>
</head>
<body>
<div class="container">
    <% if (student != null) { %>
    <h2>Student Profile</h2>

    <div class="student-info">
        <div class="info-row">
            <div class="info-icon"><i class="fas fa-id-card"></i></div>
            <div><strong>Student ID:</strong> <span style="color: var(--primary);"><%= student.id %></span></div>
        </div>
        <div class="info-row">
            <div class="info-icon"><i class="fas fa-user"></i></div>
            <div><strong>Username:</strong> <%= student.username %></div>
        </div>
        <div class="info-row">
            <div class="info-icon"><i class="fas fa-user-tag"></i></div>
            <div><strong>Role:</strong> <span style="color: var(--secondary);"><%= student.role %></span></div>
        </div>
    </div>

    <div class="divider"></div>

    <div class="nav-buttons">
        <form action="/students/view" method="get">
            <input type="hidden" name="id" value="<%= student.id %>"/>
            <input type="hidden" name="direction" value="prev"/>
            <button><i class="fas fa-chevron-left"></i> Previous</button>
        </form>

        <form action="/students/view" method="get">
            <input type="hidden" name="id" value="<%= student.id %>"/>
            <input type="hidden" name="direction" value="next"/>
            <button>Next <i class="fas fa-chevron-right"></i></button>
        </form>
    </div>
    <% } else { %>
    <div class="no-students">
        <i class="fas fa-exclamation-circle"></i> No students found
    </div>
    <% } %>

    <a href="/dashboard" class="btn-custom">
        <i class="fas fa-arrow-left"></i> Back to Dashboard
    </a>
</div>

<script>
    // Enhanced button ripple effect
    document.querySelectorAll('button').forEach(button => {
        button.addEventListener('click', function(e) {
            // Ripple effect coordinates
            const rect = this.getBoundingClientRect();
            const x = e.clientX - rect.left;
            const y = e.clientY - rect.top;

            // Create ripple element
            const ripple = document.createElement('span');
            ripple.style.position = 'absolute';
            ripple.style.background = 'rgba(255, 255, 255, 0.4)';
            ripple.style.borderRadius = '50%';
            ripple.style.transform = 'scale(0)';
            ripple.style.animation = 'ripple 0.6s linear';
            ripple.style.pointerEvents = 'none';
            ripple.style.left = `${x}px`;
            ripple.style.top = `${y}px`;

            this.appendChild(ripple);

            // Remove ripple after animation
            setTimeout(() => {
                ripple.remove();
            }, 600);
        });
    });
</script>
</body>
</html>

