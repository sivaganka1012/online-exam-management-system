<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.onlineexam.model.User, java.util.*" %>
<%@ page session="true" %>
<%
    List<User> users = (List<User>) request.getAttribute("users");
%>





<!DOCTYPE html>
<html>
<head>
    <title>All Users</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #6c757d;
            --table-header: #2c3e50;
            --light-bg: #f5f5f5;
            --shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        body {
            padding: 60px 20px;
            background-color: var(--light-bg);
            font-family: 'Segoe UI', sans-serif;
        }

        .container {
            max-width: 1200px;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: var(--shadow);
            margin-bottom: 30px;
        }

        h2 {
            color: var(--table-header);
            font-weight: 600;
            padding-bottom: 10px;
            border-bottom: 2px solid #eee;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .table {
            border-radius: 8px;
            overflow: hidden;
        }

        .table-dark {
            background-color: var(--table-header);
        }

        .table th {
            font-weight: 500;
            padding: 15px;
        }

        .table td {
            padding: 12px 15px;
            vertical-align: middle;
        }

        .table-hover tbody tr:hover {
            background-color: rgba(67, 97, 238, 0.05);
        }

        .btn-sm {
            padding: 6px 12px;
            font-size: 14px;
            border-radius: 6px;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .btn-warning {
            background-color: #ffc107;
            border-color: #ffc107;
            color: #212529;
        }

        .btn-warning:hover {
            background-color: #e0a800;
            border-color: #d39e00;
        }

        .btn-danger {
            background-color: #dc3545;
            border-color: #dc3545;
        }

        .btn-danger:hover {
            background-color: #c82333;
            border-color: #bd2130;
        }

        .btn-secondary {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
            padding: 10px 20px;
            border-radius: 6px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
            border-color: #545b62;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        @media (max-width: 768px) {
            body {
                padding: 40px 15px;
            }

            .container {
                padding: 20px;
            }

            .table th, .table td {
                padding: 10px;
                font-size: 14px;
            }

            .action-buttons {
                flex-direction: column;
                gap: 5px;
            }

            .btn-sm {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="container">
    <h2><i class="fas fa-users"></i> All Registered Users</h2>
    <table class="table table-bordered table-hover">
        <thead class="table-dark">
        <tr>
            <th>User ID</th>
            <th>Username</th>
            <th>Password</th>
            <th>Role</th>
            <th>Update</th>
        </tr>
        </thead>
        <tbody>
        <% if (users != null) {
            for (User user : users) { %>
        <tr>
            <td><%= user.getUserId() %></td>
            <td><%= user.getUsername() %></td>
            <td><%= user.getPassword() %></td>
            <td><%= user.getRole() %></td>
            <td>
                <div class="action-buttons">
                    <form action="/users/edit-user" method="get" style="display:inline-block;">
                        <input type="hidden" name="username" value="<%= user.getUsername() %>">
                        <button class="btn btn-warning btn-sm"><i class="fas fa-edit"></i> Update</button>
                    </form>
                    <form action="/users/delete" method="post" style="display:inline-block;">
                        <input type="hidden" name="userId" value="<%= user.getUserId() %>">
                        <button class="btn btn-danger btn-sm" onclick="return confirm('Are you sure to delete?')"><i class="fas fa-trash-alt"></i> Delete</button>
                    </form>
                </div>
            </td>
        </tr>
        <% }} %>
        </tbody>
    </table>
</div>

<a href="/dashboard" class="btn btn-secondary">
    <i class="fas fa-arrow-left"></i> Back to Dashboard
</a>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>



