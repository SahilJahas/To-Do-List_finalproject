<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Task Records</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<div class="container mt-4">
    <h2 class="mb-4">Task Records</h2>

    <%
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String url = "jdbc:mysql://localhost:3306/todolist"; 
        String dbUser = "root";  
        String dbPassword = ""; 

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            conn = DriverManager.getConnection(url, dbUser, dbPassword);

            String sql = "SELECT * FROM tasks";
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);

            out.println("<table class='table table-bordered table-striped'>");
            out.println("<thead class='table-dark'><tr><th>ID</th><th>Description</th><th>Status</th><th>Create Date</th><th>Due Date</th><th>Actions</th></tr></thead>");
            out.println("<tbody>");

            while (rs.next()) {
                int id = rs.getInt("id");
                String description = rs.getString("description");
                String status = rs.getString("status");
                String createdate = rs.getString("createdate");
                String duedate = rs.getString("duedate");

                out.println("<tr>");
                out.println("<td>" + id + "</td>");
                out.println("<td>" + description + "</td>");
                out.println("<td>" + status + "</td>");
                out.println("<td>" + createdate + "</td>");
                out.println("<td>" + duedate + "</td>");
                
                out.println("<td>");
                out.println("<a href='edit.jsp?id=" + id + "' class='btn btn-warning'>Edit</a> ");
                
                out.println("<a href='delete.jsp?id=" + id + "' class='btn btn-danger' onclick='return confirm(\"Are you sure you want to delete this task?\")'>Delete</a>");
                out.println("</td>");
                out.println("</tr>");
            }

            out.println("</tbody>");
            out.println("</table>");

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    %>

    <br>
    <a href="add.jsp" class="btn btn-primary">Add New Task</a>
</div>

</body>
</html>
