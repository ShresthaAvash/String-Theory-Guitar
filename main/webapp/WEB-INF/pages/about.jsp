<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - String Theory Guitars</title>
    <style>
        body {
            margin: 0; padding: 0;
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
            background-color: #212121; color: #e0e0e0; display: flex; flex-direction: column; min-height: 100vh;
            -webkit-font-smoothing: antialiased; -moz-osx-font-smoothing: grayscale;
        }
        .main-content-area {
             flex-grow: 1; padding-bottom: 50px;
        }
        .container {
            max-width: 800px; 
            margin: 40px auto; padding: 0 20px; box-sizing: border-box;
        }
        .page-title {
            font-size: 2.5em; color: #FFC107; font-weight: 700; text-align: center; margin-top: 0; margin-bottom: 40px; 
        }
        .about-box {
            background-color: #444444; border-radius: 8px; padding: 30px 35px;
            box-shadow: 0 3px 8px rgba(0,0,0,0.2); opacity: 0; animation: fadeInAbout 0.6s 0.2s ease-out forwards;
        }
        @keyframes fadeInAbout {
            from { opacity: 0; transform: translateY(15px); } to { opacity: 1; transform: translateY(0); }
        }

        .about-text {

        }
        .about-text h3 {
            font-size: 1.4em; color: #FFC107; font-weight: 700; margin-top: 0; margin-bottom: 15px;
        }
        .about-text h3:not(:first-child) {
             margin-top: 30px; 
        }
        .about-text p {
            font-size: 1em; color: #e0e0e0; line-height: 1.7; margin-bottom: 15px; font-weight: 400;
        }
        @media (max-width: 768px) {
            .page-title { font-size: 2em; }
            .about-box { padding: 25px; }
            .about-text h3 { font-size: 1.3em; }
            .about-text p { font-size: 0.95em; }
        }
        @media (max-width: 480px) {
             .container { padding: 0 15px; }
             .page-title { font-size: 1.8em; margin-bottom: 30px; }
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/pages/navbar.jsp">
        <jsp:param name="activePage" value="about"/>
    </jsp:include>

    <div class="main-content-area">
        <div class="container">
             <h1 class="page-title">About String Theory Guitars</h1>
             <div class="about-box">
                <%-- Image placeholder div removed --%>
                <div class="about-text">
                    <h3>Our Passion</h3>
                    <p>String Theory Guitars isn't just a name; it's our philosophy. We believe every guitar has a story, a unique vibration, a theory waiting to be explored by its player. Founded by lifelong musicians and gear enthusiasts, we are dedicated to curating and managing inventories of exceptional stringed instruments.</p>

                    <h3>What We Do</h3>
                    <p>This platform serves as a sophisticated inventory management system, designed with the needs of collectors, dealers, and players in mind. While customers can browse our curated collection, administrators have powerful tools to add, edit, track, and analyze their valuable guitar assets.</p>

                    <h3>The Vision</h3>
                    <p>Our vision is to blend the passion for guitars with modern technology, creating a seamless and visually appealing experience for managing and appreciating these incredible instruments. Whether you're cataloging a personal collection or running a boutique shop, String Theory Guitars aims to be your essential partner.</p>
                    <p>From vintage treasures to modern marvels, we understand the nuances that make each guitar special. Welcome to the theory.</p>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/pages/footer.jsp" />

</body>
</html>