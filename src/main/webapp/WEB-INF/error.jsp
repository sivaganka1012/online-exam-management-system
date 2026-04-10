<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error | Page Not Found</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #ff9a9e 0%, #fad0c4 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            margin: 0;
        }

        .error-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            padding: 30px;
            text-align: center;
            max-width: 500px;
            width: 100%;
            border-top: 5px solid #ff4757;
            animation: float 4s ease-in-out infinite;
        }

        .error-icon {
            font-size: 70px;
            background: linear-gradient(135deg, #ff4757 0%, #ff6b81 100%);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 15px;
            animation: pulse 2s infinite;
        }

        h1 {
            color: #ff4757;
            font-weight: 700;
            margin-bottom: 15px;
            font-size: 1.8rem;
        }

        p.lead {
            color: #57606f;
            font-size: 1rem;
            margin-bottom: 25px;
            line-height: 1.5;
        }

        .btn-error {
            background: linear-gradient(135deg, #ff4757 0%, #ff6b81 100%);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s;
            box-shadow: 0 4px 10px rgba(255, 71, 87, 0.3);
            margin: 5px;
            font-size: 0.9rem;
        }

        .btn-outline-error {
            border: 2px solid #ff4757;
            color: #ff4757;
            background: transparent;
            padding: 8px 18px;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s;
            margin: 5px;
            font-size: 0.9rem;
        }

        .error-details {
            background: rgba(255, 255, 255, 0.7);
            border-radius: 8px;
            padding: 10px;
            margin-top: 20px;
            font-family: 'Courier New', monospace;
            text-align: left;
            font-size: 0.8rem;
            color: #2f3542;
            border-left: 3px solid #ff4757;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }

        @keyframes float {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-8px); }
            100% { transform: translateY(0px); }
        }

        @media (max-width: 576px) {
            .error-container {
                padding: 25px 20px;
            }

            h1 {
                font-size: 1.5rem;
            }

            p.lead {
                font-size: 0.9rem;
            }

            .btn-error, .btn-outline-error {
                padding: 8px 15px;
                font-size: 0.85rem;
            }
        }
    </style>
</head>
<body>
<div class="error-container">
    <div class="error-icon">❌</div>
    <h1>Page Not Found</h1>
    <p class="lead">We couldn't find what you're looking for. The page may have been moved or deleted.</p>

    <div class="d-flex justify-content-center flex-wrap">
        <a href="/dashboard" class="btn btn-error">
            <i class="fas fa-home me-1"></i> Home
        </a>
        <a href="/contact" class="btn btn-outline-error">
            <i class="fas fa-life-ring me-1"></i> Help
        </a>
    </div>

    <div class="error-details mt-3">
        <small>
            <strong>Error 404</strong><br>
            URL: <%= request.getRequestURL() %>
        </small>
    </div>
</div>

<!-- Font Awesome for icons -->
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</body>
</html>