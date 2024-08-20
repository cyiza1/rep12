<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Record</title>
</head>
<body>
    <h2>Delete Record</h2>

    <%
        // Check if the form has been submitted
        String id = request.getParameter("id");

        if (id != null) {
            String jdbcURL = "jdbc:mysql://localhost:3306/emp_management"; // Update with your DB info
            String dbUser = "root"; // Update with your DB username
            String dbPassword = ""; // Update with your DB password

            try {
                Class.forName("com.mysql.cj.jdbc.Driver"); // Load the MySQL JDBC driver
                Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                String sql = "DELETE FROM employee WHERE id = ?";
                PreparedStatement statement = connection.prepareStatement(sql);
                statement.setString(1, id);

                int rowsDeleted = statement.executeUpdate();
                if (rowsDeleted > 0) {
                    out.println("<p>Record with ID " + id + " was deleted successfully!</p>");
                } else {
                    out.println("<p>No record found with ID " + id + ".</p>");
                }
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Error deleting record: " + e.getMessage() + "</p>");
            }
        }
    %>

    <form action="delete.jsp" method="post">
        ID of the record to delete: <input type="text" name="id" required><br>
        <input type="submit" value="Delete">
    </form>
</body>
</html>