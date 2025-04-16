<%@ page import="java.sql.*" %>
<%
    String loginMessage = "";

    if (request.getMethod().equals("POST")) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username != null && password != null) {
            Connection conn = null;
            PreparedStatement pst = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "root", "");

                String query = "SELECT * FROM users WHERE username = ? AND password = ?";
                pst = conn.prepareStatement(query);
                pst.setString(1, username);
                pst.setString(2, password);
                
                rs = pst.executeQuery();
                
                if (rs.next()) {
                    session.setAttribute("user_name", rs.getString("username"));
                    
                    // Redirect before setting any message
                    response.sendRedirect("home.jsp");
                    return;
                } else {
			
                   session.setAttribute("loginMessage", "❌ Invalid username or password! Please sign up.");
                    response.sendRedirect("Signup.jsp");
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace(); // Log error in the server console
                loginMessage = "<div class='error'>⚠ An error occurred. Please try again later.</div>";
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (pst != null) pst.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else {
            loginMessage = "<div class='error'>⚠ All fields are required!</div>";
        }
    }
%>

<html>
<head>
    <title>Login</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
           background: url('notesbg.jpg') no-repeat center center fixed;

            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            width: 400px;
            text-align: center;
            animation: fadeIn 1s ease-in-out;
        }

        h2 {
            margin-bottom: 20px;
            color: #333;
            font-size: 24px;
            font-weight: 600;
        }

        .message {
            margin-bottom: 15px;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            text-align: left;
            font-weight: 500;
            margin-top: 12px;
            color: #555;
        }

        input {
            padding: 10px;
            margin-top: 6px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 16px;
            transition: all 0.3s;
        }

        input:focus {
            border-color: #ff758c;
            outline: none;
            box-shadow: 0 0 5px rgba(255, 117, 140, 0.5);
        }

        input[type="submit"] {
            background: linear-gradient(90deg, #ff758c, #ff7eb3);
            color: white;
            border: none;
            cursor: pointer;
            padding: 12px;
            font-size: 18px;
            font-weight: bold;
            margin-top: 20px;
            border-radius: 6px;
            transition: all 0.3s;
        }

        input[type="submit"]:hover {
            background: linear-gradient(90deg, #ff7eb3, #ff758c);
            box-shadow: 0 4px 8px rgba(255, 117, 140, 0.4);
        }

        .success {
            color: #28a745;
            background: #d4edda;
            padding: 10px;
            border-radius: 6px;
            font-weight: 500;
        }

        .error {
            color: #d9534f;
            background: #f8d7da;
            padding: 10px;
            border-radius: 6px;
            font-weight: 500;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: scale(0.9);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>NotesNinja</h2>
	
        <div class="message"><%= loginMessage %></div>
        <form method="post" action="NotesNinja.jsp">
            <label>Username:</label>
            <input type="text" name="username" required>
            
            <label>Password:</label>
            <input type="password" name="password" required>
            
            <input type="submit" value="Login">
        </form>
    </div>
</body>
</html>



