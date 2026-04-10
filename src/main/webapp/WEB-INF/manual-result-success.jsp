<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>Result Submitted</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <style>
        :root {
            --success-green: #28a745;
            --primary-blue: #4361ee;
            --light-bg: #f7f9fc;
            --shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        body {
            background-color: var(--light-bg);
            padding: 60px;
            font-family: 'Segoe UI', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }

        .success-container {
            background: white;
            padding: 3rem;
            border-radius: 15px;
            box-shadow: var(--shadow);
            text-align: center;
            max-width: 600px;
            position: relative;
            overflow: hidden;
            border-top: 5px solid var(--success-green);
            animation: fadeInUp 0.6s forwards;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .checkmark-circle {
            width: 80px;
            height: 80px;
            background-color: rgba(40, 167, 69, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            animation: bounceIn 0.8s;
        }

        @keyframes bounceIn {
            0% {
                transform: scale(0.1);
                opacity: 0;
            }
            60% {
                transform: scale(1.2);
                opacity: 1;
            }
            100% {
                transform: scale(1);
            }
        }

        .checkmark {
            width: 40px;
            height: 40px;
            fill: var(--success-green);
        }

        h2 {
            color: var(--success-green);
            margin-bottom: 2rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            animation: fadeIn 1s both;
            animation-delay: 0.3s;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .button-group {
            animation: fadeInUp 0.5s both;
            animation-delay: 0.6s;
        }

        .btn {
            padding: 0.6rem 1.5rem;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
            margin: 0 0.5rem;
        }

        .btn-primary {
            background-color: var(--primary-blue);
            border-color: var(--primary-blue);
        }

        .btn-primary:hover {
            background-color: #3a56d4;
            border-color: #3a56d4;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.3);
        }

        .btn-outline-primary {
            color: var(--primary-blue);
            border-color: var(--primary-blue);
        }

        .btn-outline-primary:hover {
            background-color: rgba(67, 97, 238, 0.1);
            transform: translateY(-2px);
        }

        @media (max-width: 576px) {
            body {
                padding: 20px;
            }
            .success-container {
                padding: 2rem 1.5rem;
            }
            .btn {
                width: 100%;
                margin-bottom: 1rem;
            }
        }
    </style>
</head>
<body>
<div class="success-container">
    <div class="checkmark-circle">
        <svg class="checkmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
            <circle class="checkmark__circle" cx="26" cy="26" r="25" fill="none"/>
            <path class="checkmark__check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8"/>
        </svg>
    </div>
    <h2>✅ Result Submitted Successfully!</h2>
    <div class="button-group">
        <a href="/manual/enter" class="btn btn-outline-primary me-3">➕ Add Another</a>
        <a href="/manual/view" class="btn btn-primary">📊 View All Results</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

