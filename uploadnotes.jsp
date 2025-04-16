<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.io.*" %>

<%
    boolean uploaded = false; // Flag to show success image

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            String uploadPath = application.getRealPath("/") + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            MultipartRequest m = new MultipartRequest(request, uploadPath);

            uploaded = true; // Set flag to true after successful upload
        } catch (Exception e) {
            out.println("<script>alert('Upload failed: " + e.getMessage().replace("'", "\\'") + "');</script>");
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Notes Ninja - Upload Notes</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            background-size: cover;
            font-family: 'Poppins', sans-serif;
            color: white;
            text-align: center;
            margin: 0;
            padding: 0;
        }
        .upload-container {
            margin: 100px auto;
            width: 50%;
            padding: 25px;
            background: rgba(0, 0, 0, 0.75);
            border-radius: 12px;
            box-shadow: 0px 0px 12px rgba(0, 0, 0, 0.6);
            animation: fadeIn 1s ease-in-out;
        }
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: rgba(0, 0, 0, 0.8);
            padding: 15px 50px;
            border-bottom: 2px solid #ffcc00;
            position: fixed;
            width: 100%;
            top: 0;
            left: 0;
            z-index: 1000;
        }
        .logo {
            font-size: 26px;
            font-weight: bold;
            color: #ffcc00;
            text-decoration: none;
            transition: 0.3s;
        }
        .logo:hover { color: #ffd633; }
        nav {
            display: flex;
            flex-grow: 1;
            justify-content: center;
            gap: 20px;
        }
        .logout { margin-left: auto; }
        nav a {
            font-size: 18px;
            font-weight: bold;
            color: white;
            text-decoration: none;
            padding: 10px 15px;
            transition: 0.3s ease-in-out;
            border-radius: 6px;
        }
        nav a:hover {
            background: #ffcc00;
            color: black;
        }
        @media (max-width: 768px) {
            header {
                flex-direction: column;
                text-align: center;
                padding: 15px;
            }
            nav {
                flex-direction: column;
                gap: 10px;
                margin-top: 10px;
            }
            .logout {
                margin-left: 0;
            }
        }
        h2 {
            color: #ffcc00;
            font-size: 24px;
            margin-bottom: 20px;
        }
        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        label {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 8px;
            color: #ffcc00;
        }
        input[type="file"] {
            padding: 10px;
            font-size: 16px;
            border-radius: 6px;
            border: none;
            background: white;
            cursor: pointer;
        }
        button {
            background: linear-gradient(90deg, #ff758c, #ff7eb3);
            color: white;
            border: none;
            padding: 12px 20px;
            font-size: 18px;
            font-weight: bold;
            margin-top: 15px;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s;
        }
        button:hover {
            background: linear-gradient(90deg, #ff7eb3, #ff758c);
            box-shadow: 0 4px 8px rgba(255, 117, 140, 0.5);
        }
        .options {
            margin-top: 25px;
        }
        .options h3 {
            color: #ffcc00;
            font-size: 18px;
            margin-bottom: 10px;
        }
        .options a {
            display: inline-block;
            padding: 12px 18px;
            margin: 10px;
            font-size: 16px;
            font-weight: bold;
            text-decoration: none;
            color: white;
            border-radius: 6px;
            transition: 0.3s ease-in-out;
        }
        .options a:first-child { background: #28a745; }
        .options a:last-child { background: #007bff; }
        .options a:hover { opacity: 0.8; }
        footer {
            margin-top: 30px;
            font-size: 14px;
            color: #ddd;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: scale(0.9); }
            to { opacity: 1; transform: scale(1); }
        }
    </style>
</head>
<body>

<header>
    <a href="uploadnotes.jsp" class="logo">Notes Ninja</a>
    <nav>
        <a href="home.jsp">Home</a>
        <a href="subject.jsp">Subjects</a>
        <a href="upload.jsp">Upload Notes</a>
        <a href="logout.jsp">Delete Account</a>
    </nav>
</header>

<div class="upload-container">

<% if (uploaded) { %>
    <div style="text-align:center; margin-top: 40px;">
        <img src="Thankyou.jpeg" alt="Thank You" style="max-width: 500px; width: 80%; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.5);">
        <p style="color: #ffcc00; font-size: 20px; margin-top: 20px;">File uploaded successfully! Redirecting to home...</p>
    </div>
    <script>
        setTimeout(function() {
            window.location.href = 'home.jsp';
        }, 3000);
    </script>
<% } else { %>

    <h2>Upload Your Notes</h2>

    <form action="uploadnotes.jsp" method="post" enctype="multipart/form-data">
        <label for="file">Select PDF file:</label>
        <input type="file" id="file" name="file" accept="application/pdf" required>
        <br>
        <button type="submit">Upload</button>
    </form>

    <div class="options">
        <h3>Choose an option:</h3>
        <a href="readnotes.jsp">📖 Read Notes</a>
    </div>

<% } %>
</div>

<footer>
    <p>&copy; 2025 Notes Ninja. All rights reserved.</p>
</footer>

</body>
</html>
