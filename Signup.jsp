<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
    String message = "";
    if (request.getParameter("submit") != null) {
        String username = request.getParameter("username");
        
        String password = request.getParameter("password");
               if (username != null && password != null) {
            Connection conn = null;
            PreparedStatement pst = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "root", "");

                
                String query = "INSERT INTO users (username, password) VALUES (?, ?)";
                pst = conn.prepareStatement(query);
                pst.setString(1, username);
                pst.setString(2, password);
                               int rowCount = pst.executeUpdate();
                if (rowCount > 0) {
                    message = "<div class='success'> Successfully Signed Up!!!</div>";
			response.sendRedirect("home.jsp");
                } else {
                    message = "<div class='error'> Signup Failed!!!</div>";
                }
            } catch (Exception e) {
                message = "<div class='error'> Error: " + e.getMessage() + "</div>";
            } finally {
                try {
                    if (pst != null) pst.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else {
            message = "<div class='error'>⚠ All fields are required!</div>";
        }
    }

%>

<html>
<head>
    <title>Sign Up</title>
    <style>
        /* Background Styling */
        body {
            font-family: 'Poppins', sans-serif;
            background: url('notesbg.jpg') no-repeat center center fixed;

            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        /* Card Container */
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

        /* Form Styling */
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
            border-color: #667eea;
            outline: none;
            box-shadow: 0 0 5px rgba(102, 126, 234, 0.5);
        }

        /* Button Styling */
        input[type="submit"] {
            background: linear-gradient(90deg, #667eea, #764ba2);
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
            background: linear-gradient(90deg, #764ba2, #667eea);
            box-shadow: 0 4px 8px rgba(102, 126, 234, 0.4);
        }

        /* Message Styles */
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

        /* Fade-in Animation */
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
        <h2>Create an Account</h2>
        <div class="message"><%= message %></div>
        <form method="post" action="Signup.jsp">
            <label>UserName:</label>
            <input type="text" name="username" required>
            
                        <label>Password:</label>
            <input type="password" name="password" required>
            
            <input type="submit" name="submit" value="Sign Up">
        </form>
    </div>
</body>
</html>
