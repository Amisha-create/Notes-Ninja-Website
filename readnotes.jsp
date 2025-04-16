<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notes Ninja - Read Notes</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        /* General styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: url('reading.jpeg') no-repeat center center fixed;
            background-size: cover;
            color: white;
            text-align: center;
        }

        /* Header Styling */
        header {
            background: rgba(0, 0, 0, 0.7);
            padding: 15px 0;
            text-align: center;
            font-size: 22px;
            font-weight: bold;
        }

        nav ul {
            list-style: none;
            display: flex;
            justify-content: center;
            padding: 0;
        }

        nav ul li {
            margin: 0 15px;
        }

        nav ul li a {
            text-decoration: none;
            color: #f8b400;
            font-weight: bold;
            transition: 0.3s ease-in-out;
        }

        nav ul li a:hover {
            color: #ffcc00;
            text-decoration: underline;
        }

        /* Main Container */
        .read-container {
            margin: 100px auto;
            width: 60%;
            padding: 20px;
            background: rgba(0, 0, 0, 0.7);
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.5);
            animation: fadeIn 1s ease-in-out;
        }

        h2 {
            color: #f8b400;
            margin-bottom: 20px;
            font-size: 26px;
        }

        /* PDF Links */
        .pdf-link {
            display: block;
            margin: 15px auto;
            font-size: 18px;
            color: #ffcc00;
            text-decoration: none;
            font-weight: bold;
            padding: 10px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            transition: 0.3s;
        }

        .pdf-link:hover {
            background: rgba(255, 255, 255, 0.2);
            text-decoration: underline;
        }

        /* Footer */
        footer {
            margin-top: 50px;
            background: rgba(0, 0, 0, 0.7);
            padding: 10px;
            text-align: center;
            font-size: 14px;
        }

        /* Fade-in animation */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .read-container {
                width: 90%;
            }

            nav ul {
                flex-direction: column;
            }

            nav ul li {
                margin: 10px 0;
            }
        }
    </style>
</head>
<body>
    <header>
        <h1>Read Notes</h1>
        <nav>
            <ul>
                <li><a href="home.jsp">Home</a></li>
                <li><a href="subject.jsp">Subjects</a></li>
                <li><a href="logout.jsp">Delete Account</a></li>
            </ul>
        </nav>
    </header>
    
    <div class="read-container">
        <h2>View Notes</h2>
        <% 
            // Get subject parameter from request
            String subject = request.getParameter("subject");

            // Default subject if not provided
            if (subject == null || subject.trim().isEmpty()) {
                subject = "default";
            }
            
            // Construct the correct PDF web path (relative to project)
            String pdfPath[] = {
                "uploads/C++notes.pdf", 
                
                "uploads/pythonnotes.pdf",
                "uploads/advjavanotes.pdf",
                "uploads/DSAnotes.pdf",
                "uploads/HTMLnotes.pdf",
                "uploads/javascriptnotes.pdf",
                "uploads/CAnotes.pdf",
                "uploads/MP.pdf",
                "uploads/SEnotes.pdf" ,
		"uploads/javanotes.pdf"
            };
            
            String subjects[] = {
                "C++", "Python", "Advanced Java", "DSA", 
                "HTML", "JavaScript", "Computer Architecture", 
                "Microprocessor", "Software Engineering" ,"JAVA"
            };

            for (int i = 0; i < pdfPath.length; i++) {
        %>
            <a class="pdf-link" href="<%= request.getContextPath() %>/<%= pdfPath[i] %>" target="_blank">
                Click here to read <%= subjects[i] %> notes
            </a>
        <% } %>
    </div>
    
    <footer>
        <p>&copy; 2025 Notes Ninja. All rights reserved.</p>
    </footer>
</body>
</html>
