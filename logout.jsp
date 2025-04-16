<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logout - Notes Ninja</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        /* General Styling */
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #ff758c, #ff7eb3);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            color: white;
            text-align: center;
        }

        .logout-container {
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

        .btn {
            display: inline-block;
            padding: 12px 20px;
            font-size: 16px;
            font-weight: bold;
            color: white;
            background: #ffcc00;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 15px;
            text-decoration: none;
        }

        .btn:hover {
            background: #f8b400;
            box-shadow: 0 3px 6px rgba(255, 204, 0, 0.5);
        }

        .thank-you {
            margin-top: 20px;
            display: none;
        }

        .thank-you img {
            width: 100px;
            height: 100px;
        }

        .thank-you p {
            font-size: 18px;
            font-weight: bold;
            margin-top: 10px;
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

    <script>
        function confirmLogout() {
            var confirmation = confirm("Are you sure you want to Delete your Account?");
            if (confirmation) {
                window.location.href = "logout.jsp?confirm=true";
            }
        }
    </script>
</head>
<body>

    <div class="logout-container">
        <h2>Delete Account</h2>
        <p>Are you sure you want to Delete?</p>
        <button class="btn" onclick="confirmLogout()">Yes, Delete</button>
        <a class="btn" href="home.jsp">Cancel</a>
    </div>

    <div class="thank-you">
        <img src="thank_you.jpeg" alt="Thank You">
        <p>Thank you for using Notes Ninja! See you soon. 😊</p>
    </div>

    <%
        // If the user has confirmed logout
        if ("true".equals(request.getParameter("confirm"))) {
            Connection conn = null;
            PreparedStatement pst = null;

            try {
                // Get the current user from session
                String username = (String) session.getAttribute("user_name");

                if (username != null) {
                    // Connect to the database
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "root", "");

                    // Delete user session from the database
                    String query = "DELETE FROM users WHERE username = ?";
                    pst = conn.prepareStatement(query);
                    pst.setString(1, username);
                    pst.executeUpdate();
                    
                    // Invalidate session
                    session.invalidate();
    %>
                    <script>
                        document.querySelector(".logout-container").style.display = "none";
                        document.querySelector(".thank-you").style.display = "block";
                        
                        setTimeout(function() {
                            alert("✅ You have successfully Deleted Account.");
                            window.location.href = "login.jsp";
                        }, 2000);
                    </script>
    <%
                } else {
    %>
                    <script>
                        alert("⚠ No active session found.");
                        window.location.href = "login.jsp";
                    </script>
    <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (pst != null) pst.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>

</body>
</html>
