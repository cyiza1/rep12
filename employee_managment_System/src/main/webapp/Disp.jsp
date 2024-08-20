<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Display Records</title>
</head>
<body>
    <h2>Records</h2>

    <%
        String jdbcURL = "jdbc:mysql://localhost:3306/emp_management"; // Update with your DB info
        String dbUser = "root"; // Update with your DB username
        String dbPassword = ""; // Update with your DB password

        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load the MySQL JDBC driver
            connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
            statement = connection.createStatement();
            String sql = "SELECT id, firstname, lastname, sex, department, email FROM employee"; // Update with your table name
            resultSet = statement.executeQuery(sql);
    %>

    <table border="1">
        <tr>
            <th>ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Sex</th>
            <th>Position</th>
            <th>Email</th>
            <th>Actions</th>
        </tr>
        
        <%
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String firstname = resultSet.getString("firstname");
                String lastname = resultSet.getString("lastname");
                String sex = resultSet.getString("sex");
                String department = resultSet.getString("department");
                String email = resultSet.getString("email");
        %>
        
        <tr>
            <td><%= id %></td>
            <td><%= firstname %></td>
            <td><%= lastname %></td>
            <td><%= sex %></td>
            <td><%= department %></td>
            <td><%= email %></td>
            <td>
                <form action="update.jsp" method="get" style="display:inline;">
                    <input type="hidden" name="id" value="<%= id %>">
                    <input type="submit" value="Update">
                </form>
                <form action="delete.jsp" method="post" style="display:inline;">
                    <input type="hidden" name="id" value="<%= id %>">
                    <input type="submit" value="Delete">
                </form>
            </td>
        </tr>
        
        <%
            }
        %>
    </table>

    <%
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error retrieving records: " + e.getMessage() + "</p>");
        } finally {
            // Clean up JDBC resources
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>