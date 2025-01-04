<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Task Record</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEJ03Ruq7l6p1JIH4I6EIZT5T0htn4w0wEx8c24VJgS1IHVdBoPXAYWVh9v5p" crossorigin="anonymous">
    
    <style>
        body {
            background-color: #f0f8ff; 
        }
        .container {
            max-width: 1263px;
            margin-top: 10px;
        }
        h2 {
            color: #ff6347; 
            font-size: 2rem; 
        }
        .card {
            background-color: #f9f9f9;
            border: 10px solid #4caf50;
            border-radius: 12px; 
            box-shadow: 0 8px 12px rgba(0, 0, 0, 0.1); 
            padding: 15px; 
            width: 100%;
            box-sizing: border-box; 
        }
        .form-label {
            color: #2c3e50; 
            font-size: 1.3rem;  
        }
        .form-control, .form-select {
            border-radius: 12px;
            border: 1px solid #3498db; 
            font-size: 1rem; 
            padding: 10px;
            width: 100%; 
            box-sizing: border-box; 
        }
        .btn-primary {
            background-color: #3498db;
            border-color: #2980b9;
            font-size: 1.1rem; 
            padding: 12px 22px;
        }
        .btn-primary:hover {
            background-color: #2980b9;
            border-color: #3498db;
        }
        .alert {
            border-radius: 15px;
            padding: 15px;
        }
        .alert-success {
            background-color: #28a745;
            color: white;
            font-size: 1.1rem;
        }
        .alert-danger {
            background-color: #e74c3c;
            color: white;
            font-size: 1.1rem;
        }
        .btn-link {
            color: #8e44ad;
            font-size: 1.2rem; 
        }
        .btn-link:hover {
            color: #9b59b6;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center mb-4">Add Task Record</h2>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String description = request.getParameter("description");
            String status = request.getParameter("status");
            String createdate = request.getParameter("createdate");
            String duedate = request.getParameter("duedate");

          
            Connection conn = null;
            PreparedStatement stmt = null;
            String url = "jdbc:mysql://localhost:3306/todolist?useUnicode=true&characterEncoding=UTF-8"; 
            String dbUser = "root"; 
            String dbPassword = "";  

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");  

                conn = DriverManager.getConnection(url, dbUser, dbPassword);

                String sql = "INSERT INTO tasks (description, status, createdate, duedate) VALUES (?, ?, ?, ?)";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, description);
                stmt.setString(2, status);
                stmt.setString(3, createdate);
                stmt.setString(4, duedate);

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    out.println("<div class='alert alert-success text-center'>Task record added successfully!</div>");
                } else {
                    out.println("<div class='alert alert-danger text-center'>Failed to add the task record.</div>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<div class='alert alert-danger text-center'>Error: " + e.getMessage() + "</div>");
            } finally {
                try {
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException se) {
                    se.printStackTrace();
                }
            }
        }
    %>

    <form action="add.jsp" method="POST">
        <div class="card p-3 shadow-sm">
            <div class="mb-3">
                <label for="description" class="form-label">Description:</label>
                <input type="text" class="form-control" id="description" name="description" required>
            </div>

            <div class="mb-3">
                <label for="status" class="form-label">Status:</label>
                <select class="form-select" id="status" name="status" required>
                    <option value="Completed">Completed</option>
                    <option value="Pending">Pending</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="createdate" class="form-label">Created Date:</label>
                <input type="date" class="form-control" id="createdate" name="createdate" required>
            </div>

            <div class="mb-3">
                <label for="duedate" class="form-label">Due Date:</label>
                <input type="date" class="form-control" id="duedate" name="duedate" required>
            </div>

            <div class="d-grid gap-2">
                <button type="submit" class="btn btn- btn-lg">Add Task</button>
            </div>
        </div>
    </form>

    <br>
    <a href="view.jsp" class="btn btn-link">View All Tasks</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz4fnFO9gybT1XVdXf4f7yTOtW5e6r6EOv8hCZ1Go5lEjc3Ut98g8u7FqG" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js" integrity="sha384-pzjw8f+ua7Kw1TIq0sy0vUqkk9BzF1Eq3nv/p6uWHEoOBXxYs7X57tH0VrlPbX3S" crossorigin="anonymous"></script>

</body>
</html>
