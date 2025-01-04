<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Task</title>
</head>
<body>

<%
    Connection conn = null;
    PreparedStatement stmt = null;
    String url = "jdbc:mysql://localhost:3306/todolist"; 
    String dbUser = "root";  
    String dbPassword = ""; 
    int taskId = Integer.parseInt(request.getParameter("id"));

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        String sql = "DELETE FROM tasks WHERE id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, taskId);

        int rowsAffected = stmt.executeUpdate();

        if (rowsAffected > 0) {
            response.sendRedirect("view.jsp");
        } else {
            out.println("<h3>Error: Task not found.</h3>");
        }

    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        out.println("<h3>Error: " + e.getMessage() + "</h3>");
    } finally {
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }
%>

</body>
</html>
