<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Help & FAQ - String Theory Guitars</title>
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
             max-width: 900px; margin: 40px auto; padding: 0 20px; box-sizing: border-box;
        }
        .page-title {
             font-size: 2.5em; color: #FFC107; font-weight: 700; text-align: center; margin-top: 0; margin-bottom: 50px;
        }
        .section-heading {
            font-size: 1.4em; color: #ffffff; font-weight: 700; margin-top: 0; margin-bottom: 20px; text-align: left;
        }

        .faq-item {
            background-color: #444444; border-radius: 8px; margin-bottom: 15px; overflow: hidden; border: 1px solid #555;
            transition: background-color 0.2s ease;
        }
        .faq-item summary {
            display: flex; justify-content: space-between; align-items: center; padding: 15px 20px; cursor: pointer; outline: none;
            color: #ffffff; font-weight: 700; font-size: 1.05em; transition: background-color 0.2s ease; list-style: none;
        }
        .faq-item summary::-webkit-details-marker,
        .faq-item summary::marker {
             display: none;
        }
        .faq-item summary:hover {
            background-color: #505050;
        }
        .faq-item summary .marker { 
            font-size: 1.4em; font-weight: bold; color: #FFC107; transition: transform 0.3s ease-out;
        }
        .faq-item[open] summary .marker { 
             transform: rotate(45deg);
        }
         .faq-item[open] summary { 
             background-color: #4a4a4a; border-bottom: 1px solid #555;
         }
        .faq-content { 
            padding: 20px 25px; font-size: 1em; color: #e0e0e0; line-height: 1.6; font-weight: 400;
            animation: fadeIn 0.4s ease-out;
        }
        .faq-item:not([open]) .faq-content {
             display: none;
         }
        .faq-item[open] .faq-content {
            display: block;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); } to { opacity: 1; transform: translateY(0); }
        }
        .faq-content ul { padding-left: 25px; margin-top: 10px;}
        .faq-content li { margin-bottom: 8px;}

        @media (max-width: 768px) {
             .page-title { font-size: 2em; } .section-heading { font-size: 1.2em; }
             .faq-item summary { font-size: 1em; padding: 12px 15px;} .faq-content { font-size: 0.95em; padding: 15px 20px; }
        }
        @media (max-width: 480px) {
             .container { padding: 0 15px; } .page-title { font-size: 1.8em; margin-bottom: 30px; }
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/pages/navbar.jsp">
        <jsp:param name="activePage" value="help"/>
    </jsp:include>

    <div class="main-content-area">
        <div class="container">
            <h1 class="page-title">Help & Frequently Asked Questions</h1>
            <section class="faq-section">
                <h2 class="section-heading">For Customers</h2>
                <details class="faq-item">
                    <summary><span>How do I browse the inventory?</span><span class="marker">+</span></summary>
                    <div class="faq-content"><p>You can browse our full collection by clicking the "Browse Inventory" link in the main navigation bar. On the inventory page, you can use the search bar to look for specific makes or models, and use the "Sort By" dropdown to organize the listings by price, make, or date added.</p></div>
                </details>
                <details class="faq-item">
                     <summary><span>Can I buy guitars through this website?</span><span class="marker">+</span></summary>
                    <div class="faq-content"><p>Currently, this platform serves as a sophisticated inventory management and browsing tool. Direct purchasing functionality is not enabled at this time. Please use the contact information provided on a specific guitar's detail page or the general "Contact Us" page to inquire about purchasing.</p></div>
                </details>
                 <details class="faq-item">
                     <summary><span>What do the condition ratings mean?</span><span class="marker">+</span></summary>
                    <div class="faq-content"><p>We use standard condition ratings:</p><ul><li><strong>New:</strong> Straight from the manufacturer or distributor, unplayed.</li><li><strong>Mint:</strong> Like new, no discernible wear, often includes original case candy.</li><li><strong>Excellent:</strong> Very light wear, perhaps minor pick scratches or swirl marks, barely noticeable.</li><li><strong>Very Good:</strong> Some visible wear like scratches, small dings, or finish checking, but structurally sound and plays well.</li><li><strong>Good:</strong> Noticeable wear and tear, potentially some repaired issues, still fully functional.</li><li><strong>Fair/Poor:</strong> Significant issues, may require repair, typically sold as-is or for parts.</li></ul></div>
                </details>
            </section>
        </div>
    </div>

    <jsp:include page="/WEB-INF/pages/footer.jsp" />

</body>
</html>