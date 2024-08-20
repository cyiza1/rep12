<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Record</title>
</head>
<body>
    <h2>Update Record</h2>

    <%
        // Check if the form has been submitted
        String id = request.getParameter("id");
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String sex = request.getParameter("sex");
        String department = request.getParameter("department");
        String email = request.getParameter("email");

        if (id != null) {
            String jdbcURL = "jdbc:mysql://localhost:3306/emp_management"; // Update with your DB info
            String dbUser = "root"; // Update with your DB username
            String dbPassword = ""; // Update with your DB password

            try {
                Class.forName("com.mysql.cj.jdbc.Driver"); // Load the MySQL JDBC driver
                Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                if (firstname != null && lastname != null && sex != null && department != null && email != null) {
                    // Update record
                    String sql = "UPDATE employee SET firstname = ?, lastname = ?, sex = ?, department = ?, email = ? WHERE id = ?";
                    PreparedStatement statement = connection.prepareStatement(sql);
                    statement.setString(1, firstname);
                    statement.setString(2, lastname);
                    statement.setString(3, sex);
                    statement.setString(4, department);
                    statement.setString(5, email);
                    statement.setString(6, id);

                    int rowsUpdated = statement.executeUpdate();
                    if (rowsUpdated > 0) {
                        out.println("<p>Record with ID " + id + " was updated successfully!</p>");
                    } else {
                        out.println("<p>No record found with ID " + id + ".</p>");
                    }
                } else {
                    // Fetch existing record to pre-fill the form
                    String fetchSql = "SELECT firstname, lastname, sex, department, email FROM employee WHERE id = ?";
                    PreparedStatement fetchStatement = connection.prepareStatement(fetchSql);
                    fetchStatement.setString(1, id);
                    ResultSet resultSet = fetchStatement.executeQuery();

                    if (resultSet.next()) {
                        firstname = resultSet.getString("firstname");
                        lastname = resultSet.getString("lastname");
                        sex = resultSet.getString("sex");
                        department = resultSet.getString("department");
                        email = resultSet.getString("email");
                    } else {
                        out.println("<p>No record found with ID " + id + ".</p>");
                    }
                }
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Error updating record: " + e.getMessage() + "</p>");
            }
        }
    %>

    <form action="update.jsp" method="post">
        ID: <input type="text" name="id" required><br>
        First Name: <input type="text" name="firstname" value="<%= firstname != null ? firstname : "" %>" required><br>
        Last Name: <input type="text" name="lastname" value="<%= lastname != null ? lastname : "" %>" required><br>
        
        Sex: 
        <input type="radio" name="sex" value="Male" <%= (sex != null && sex.equals("Male")) ? "checked" : "" %>> Male
        <input type="radio" name="sex" value="Female" <%= (sex != null && sex.equals("Female")) ? "checked" : "" %>> Female
        <input type="radio" name="sex" value="Other" <%= (sex != null && sex.equals("Other")) ? "checked" : "" %>> Other<br>
        
        Department: <input type="text" name="department" value="<%= department != null ? department : "" %>" required><br>
        Email: <input type="email" name="email" value="<%= email != null ? email : "" %>" required><br>
        <input type="submit" value="Update">
    </form>
</body>
</html>