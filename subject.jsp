<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.net.URLEncoder, java.nio.charset.StandardCharsets" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notes Ninja - Subjects</title>
    <style>
        /* Simple color variables */
        :root {
            --blue: #4361ee;
            --dark-blue: #1a1a2e;
            --light-blue: #4cc9f0;
            --white: #ffffff;
            --gray: #f0f0f0;
        }
        
        /* Basic reset and body styles */
        body {
            font-family: Arial, sans-serif;
            background-color: var(--dark-blue);
            color: var(--white);
            margin: 0;
            padding: 0;
            line-height: 1.6;
        }
        
        /* Header styles */
        header {
            background-color: var(--dark-blue);
            padding: 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .logo {
            color: var(--light-blue);
            font-size: 1.5rem;
            font-weight: bold;
        }
        
        nav ul {
            list-style: none;
            display: flex;
            gap: 1rem;
        }
        
        nav a {
            color: var(--white);
            text-decoration: none;
            padding: 0.5rem 1rem;
            border-radius: 4px;
        }
        
        nav a:hover {
            background-color: rgba(255,255,255,0.1);
        }
        
        /* Page title */
        .page-title {
            text-align: center;
            margin: 2rem 0;
        }
        
        .page-title h1 {
            color: var(--light-blue);
            font-size: 2rem;
        }
        
        /* Subjects grid */
        .subjects-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 1.5rem;
            padding: 0 1rem;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        /* Subject card */
        .subject-card {
            background-color: rgba(255,255,255,0.1);
            border-radius: 8px;
            overflow: hidden;
            transition: transform 0.3s ease;
        }
        
        .subject-card:hover {
            transform: translateY(-5px);
        }
        
        .subject-image {
            width: 100%;
            height: 150px;
            object-fit: cover;
        }
        
        .subject-content {
            padding: 1rem;
        }
        
        .subject-content h3 {
            color: var(--light-blue);
            margin-top: 0;
        }
        
        .subject-content p {
            color: var(--gray);
            font-size: 0.9rem;
        }
        
        .btn {
            display: inline-block;
            background-color: var(--blue);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            text-decoration: none;
            margin-top: 0.5rem;
            font-size: 0.9rem;
        }
        
        .btn:hover {
            background-color: #3a56d4;
        }
        
        /* Footer */
        footer {
            text-align: center;
            padding: 1.5rem;
            margin-top: 2rem;
            background-color: rgba(0,0,0,0.2);
        }
        
        /* Responsive adjustments */
        @media (max-width: 600px) {
            header {
                flex-direction: column;
            }
            
            nav ul {
                margin-top: 1rem;
            }
            
            .subjects-container {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <header>
        <div class="logo">Notes Ninja</div>
        <nav>
            <ul>
                <li><a href="home.jsp">Home</a></li>
                <li><a href="login.jsp">Logout</a></li>
            </ul>
        </nav>
    </header>
    
    <div class="page-title">
        <h1>Explore Subjects</h1>
    </div>
    
    <div class="subjects-container">
        <%
            String[][] subjects = {
                {"C++", "C++.jpg", "Master object-oriented programming with C++."},
                {"Python", "python.jpeg", "Explore data science, automation, and more with Python."},
                {"Java", "java.jpeg", "Build robust applications using Java."},
                {"Advanced Java", "advjava.jpeg", "Dive deeper into Java frameworks and libraries."},
                {"DSA", "DSA.jpeg", "Learn data structures and algorithms for coding interviews."},
                {"HTML", "html.jpeg", "Design and structure web pages with HTML."},
                {"JavaScript", "javascript.jpeg", "Enhance web interactivity with JavaScript."},
                {"Computer Architecture", "CA.jpeg", "Understand computer hardware and systems."},
                {"Microprocessor", "MP.jpeg", "Learn the fundamentals of microprocessor technology."},
                {"Software Engineering", "SE.jpeg", "Learn the fundamentals of Software Engineering and testing models."}
            };

            for (String[] subject : subjects) {
                String subjectName = subject[0];
                String subjectImage = subject[1];
                String subjectDescription = subject[2];
                String encodedSubject = URLEncoder.encode(subjectName, StandardCharsets.UTF_8.toString());
        %>
        <div class="subject-card">
            <img src="<%= subjectImage %>" alt="<%= subjectName %>" class="subject-image">
            <div class="subject-content">
                <h3><%= subjectName %></h3>
                <p><%= subjectDescription %></p>
                <a href="readnotes.jsp?subject=<%= encodedSubject %>" class="btn">View Notes</a>
            </div>
        </div>
        <%
            }
        %>
    </div>
    
    <footer>
        <p>&copy; 2025 Notes Ninja. All rights reserved.</p>
    </footer>
</body>
</html>