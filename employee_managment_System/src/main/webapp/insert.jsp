<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Insert Record</title>
</head>
<body>
    <h2>Insert Record</h2>

    <%
        // Check if the form has been submitted
        String id = request.getParameter("id");
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String sex = request.getParameter("sex");
        String department = request.getParameter("department");
        String email = request.getParameter("email");

        if (id != null && firstname != null && lastname != null && sex != null && department != null && email != null) {
            String jdbcURL = "jdbc:mysql://localhost:3306/emp_management"; // Update with your DB info
            String dbUser = "root"; // Update with your DB username
            String dbPassword = ""; // Update with your DB password

            try {
                Class.forName("com.mysql.cj.jdbc.Driver"); // Load the MySQL JDBC driver
                Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                String sql = "INSERT INTO employee (id, firstname, lastname, sex, department, email) VALUES (?, ?, ?, ?, ?, ?)";
                PreparedStatement statement = connection.prepareStatement(sql);
                statement.setString(1, id);
                statement.setString(2, firstname);
                statement.setString(3, lastname);
                statement.setString(4, sex);
                statement.setString(5, department);
                statement.setString(6, email);

                int rowsInserted = statement.executeUpdate();
                if (rowsInserted > 0) {
                    out.println("<p>A new record was inserted successfully!</p>");
                }
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Error inserting record: " + e.getMessage() + "</p>");
            }
        }
    %>

    <form action="insert.jsp" method="post">
        ID: <input type="text" name="id" required><br>
        First Name: <input type="text" name="firstname" required><br>
        Last Name: <input type="text" name="lastname" required><br>
        
        Sex: 
        <input type="radio" name="sex" value="Male" required> Male
        <input type="radio" name="sex" value="Female" required> Female
        <input type="radio" name="sex" value="Other" required> Other<br>
        
        Position: <input type="text" name="department" required><br>
        Email: <input type="email" name="email" required><br>
        <input type="submit" value="Insert">
    </form>
</body>
</html>