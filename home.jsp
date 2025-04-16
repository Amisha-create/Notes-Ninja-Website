<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notes Ninja - Home</title>
    <style>
        /* Basic Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        /* Body Styles */
        body {
            font-family: Arial, sans-serif;
            background: #6c63ff; /* Purple background */
            color: white;
            line-height: 1.6;
        }
        
        /* Header Styles */
        header {
            background: #2b2d42; /* Dark blue */
            padding: 20px;
            text-align: center;
        }
        
        .logo {
            color: white;
            font-size: 24px;
            font-weight: bold;
            text-decoration: none;
        }
        
        nav {
            margin-top: 15px;
        }
        
        nav a {
            color: white;
            text-decoration: none;
            margin: 0 10px;
            padding: 5px 10px;
        }
        
        nav a:hover {
            color: #ff9f1c; /* Orange on hover */
        }
        
        /* Main Content */
        .content {
            max-width: 1000px;
            margin: 40px auto;
            padding: 20px;
            text-align: center;
        }
        
        h1 {
            font-size: 36px;
            margin-bottom: 20px;
        }
        
        .cta-button {
            display: inline-block;
            background: #ff9f1c; /* Orange button */
            color: black;
            padding: 12px 25px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
            margin: 20px 0;
        }
        
        .cta-button:hover {
            background: #ffbf69; /* Lighter orange */
        }
        
        /* Features Section */
        .features {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            margin: 40px 0;
        }
        
        .feature-card {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            padding: 20px;
            width: 300px;
        }
        
        .feature-card h3 {
            margin: 10px 0;
        }
        
        /* Footer */
        footer {
            background: #2b2d42; /* Dark blue */
            padding: 20px;
            text-align: center;
            margin-top: 40px;
        }
        
        /* Simple animation */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        .content {
            animation: fadeIn 0.5s ease-in;
        }
    </style>
</head>
<body>
    <!-- Header with Logo and Navigation -->
    <header>
        <a href="home.jsp" class="logo">Notes Ninja</a>
        <nav>
            <a href="home.jsp">Home</a>
            <a href="subject.jsp">Subjects</a>
            <a href="uploadnotes.jsp">Upload Notes</a>
            <a href="NotesNinja.jsp">Logout</a>
        </nav>
    </header>
    
    <!-- Main Content -->
    <div class="content">
        <h1>Welcome to Notes Ninja</h1>
        <p>Your simple platform for sharing and accessing study notes.</p>
        <a href="subject.jsp" class="cta-button">Browse Subjects</a>
        
        <!-- Features Section -->
        <div class="features">
            <div class="feature-card">
                <h3>Find Notes</h3>
                <p>Access study materials for all your subjects in one place.</p>
            </div>
            
            <div class="feature-card">
                <h3>Share Notes</h3>
                <p>Upload your own notes to help other students.</p>
            </div>
            
            <div class="feature-card">
                <h3>Easy to Use</h3>
                <p>Simple interface that works on all devices.</p>
            </div>
        </div>
    </div>
    
    <!-- Footer -->
    <footer>
        <p>&copy; 2025 Notes Ninja</p>
    </footer>
</body>
</html>