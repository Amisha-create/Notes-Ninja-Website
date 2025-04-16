<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notes Ninja - Login & Signup</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #ff758c, #ff7eb3);
		background: url('notesbg.jpg') no-repeat center center fixed;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            color: white;
            text-align: center;
        }
        .container {
            background: rgba(0, 0, 0, 0.8);
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
            width: 400px;
            animation: fadeIn 0.8s ease-in-out;
        }
        h2 {
            margin-bottom: 20px;
            font-size: 24px;
        }
	
	h3 {
            margin-bottom: 20px;
            font-size: 24px;
        }

        input {
            width: 90%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            border: none;
            font-size: 16px;
        }
        .btn {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            font-weight: bold;
            color: white;
            background: #ffcc00;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn:hover {
            background: #f8b400;
            box-shadow: 0 3px 6px rgba(255, 204, 0, 0.5);
        }
        .toggle {
            color: #ffcc00;
            cursor: pointer;
            margin-top: 10px;
            display: inline-block;
        }
    </style>
</head>
<body>
    <div class="container">
	<h2>Notes Ninja</h2>
        <h3 id="form-title">Login</h3>
        <form id="login-form" action="" method="post">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit" class="btn">Login</button>
        </form>

        <form id="signup-form" action="" method="post" style="display: none;">
            <input type="text" name="new_username" placeholder="Username" required>
            <input type="password" name="new_password" placeholder="Password" required>
            <button type="submit" class="btn">Sign Up</button>
        </form>
        
        <span class="toggle" onclick="toggleForm()">Don't have an account? Sign Up</span>
    </div>
    
    <script>
        function toggleForm() {
            let loginForm = document.getElementById('login-form');
            let signupForm = document.getElementById('signup-form');
            let title = document.getElementById('form-title');
            let toggleText = document.querySelector('.toggle');
            
            if (loginForm.style.display === 'none') {
                loginForm.style.display = 'block';
                signupForm.style.display = 'none';
                title.innerText = 'Login';
                toggleText.innerText = "Don't have an account? Sign Up";
            } else {
                loginForm.style.display = 'none';
                signupForm.style.display = 'block';
                title.innerText = 'Sign Up';
                toggleText.innerText = "Already have an account? Login";
            }
        }
    </script>

    <%  
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String newUsername = request.getParameter("new_username");
        String newPassword = request.getParameter("new_password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "root", "");

            if (username != null && password != null) {
                String query = "SELECT * FROM users WHERE username = ? AND password = ?";
                pst = conn.prepareStatement(query);
                pst.setString(1, username);
                pst.setString(2, password);
                rs = pst.executeQuery();
                if (rs.next()) {
                    session.setAttribute("user_name", username);
                    response.sendRedirect("home.jsp");
                } else {
    %>
                    <script>alert("Invalid username or password!");</script>
    <%
                }
            }

            if (newUsername != null && newPassword != null) {
                String checkUserQuery = "SELECT * FROM users WHERE username = ?";
                pst = conn.prepareStatement(checkUserQuery);
                pst.setString(1, newUsername);
                rs = pst.executeQuery();
                if (!rs.next()) {
                    String insertQuery = "INSERT INTO users (username, password) VALUES (?, ?)";
                    pst = conn.prepareStatement(insertQuery);
                    pst.setString(1, newUsername);
                    pst.setString(2, newPassword);
                    pst.executeUpdate();
                    session.setAttribute("user_name", newUsername);
                    response.sendRedirect("home.jsp");
                } else {
    %>
                    <script>alert("Username already exists!");</script>
    <%
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>