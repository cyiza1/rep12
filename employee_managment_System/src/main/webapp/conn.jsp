<%@ page import="java.sql.*" %>
<%
    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/emp_management"; 
    String user = "root"; 
    String password = ""; 

    Connection conn = null;

    try {
        
        Class.forName("com.mysql.cj.jdbc.Driver"); 
        wertyu
        conn = DriverManager.getConnection(url, user, password);

        if (conn != null) {
            out.println("Connected to the database successfully!");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("Connection failed: " + e.getMessage());
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("JDBC Driver not found: " + e.getMessage());
    } finally {
       
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>