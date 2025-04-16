<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    String message = "";
    if (request.getMethod().equalsIgnoreCase("post")) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String action = request.getParameter("action");
        
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3307/mydb", "root", "");
            
            if ("login".equals(action)) {
                pst = con.prepareStatement("SELECT * FROM users WHERE Username = ? AND password = ?");
                pst.setString(1, username);
                pst.setString(2, password);
                rs = pst.executeQuery();
                if (rs.next()) {
                    session.setAttribute("username", username);
                    response.sendRedirect("home.jsp");
                } else {
                    message = "Invalid username or password.";
                }
            } else if ("createAccount".equals(action)) {
                pst = con.prepareStatement("INSERT INTO users (Username, password) VALUES (?, ?)");
                pst.setString(1, username);
                pst.setString(2, password);
                int rows = pst.executeUpdate();
                if (rows > 0) {
                    message = "Account created successfully!";
                } else {
                    message = "Error creating account.";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "Database error.";
        } finally {
            if (rs != null) rs.close();
            if (pst != null) pst.close();
            if (con != null) con.close();
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notes Ninja - Login</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header>
        <h1>Notes Ninja</h1>
    </header>
    <section>
        <h2>Login or Create an Account</h2>
        <p style="color:red;"><%= message %></p>
        <form method="post">
            <label>Username:</label>
            <input type="text" name="username" required><br>
            <label>Password:</label>
            <input type="password" name="password" required><br>
            <button type="submit" name="action" value="login">Login</button>
            <button type="submit" name="action" value="createAccount">Create Account</button>
        </form>
    </section>
    <footer>
        <p>&copy; 2025 Notes Ninja. All rights reserved.</p>
    </footer>
</body>
</html>
