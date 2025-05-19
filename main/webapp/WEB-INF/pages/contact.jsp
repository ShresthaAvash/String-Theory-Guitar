<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - String Theory Guitars</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
            background-color: #212121;
            color: #e0e0e0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }
        .main-content-area {
            flex-grow: 1;
            padding-bottom: 50px;
        }
        .container {
            max-width: 700px;
            margin: 40px auto;
            padding: 0 20px;
            box-sizing: border-box;
        }
        .page-title {
            font-size: 2.5em;
            color: #FFC107;
            font-weight: 700;
            text-align: center;
            margin-top: 0;
            margin-bottom: 20px;
        }
        .page-subtitle {
            font-size: 1.1em;
            color: #cccccc;
            text-align: center;
            margin-bottom: 40px;
            font-weight: 400;
        }
        .contact-form-box {
            background-color: #444444;
            border-radius: 8px;
            padding: 30px 35px;
            box-shadow: 0 3px 8px rgba(0,0,0,0.2);
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            text-align: left;
            margin-bottom: 6px;
            font-size: 0.9em;
            color: #e0e0e0;
            font-weight: 700;
        }
        .form-group input[type="text"],
        .form-group input[type="email"],
        .form-group textarea {
            font-family: inherit;
            width: 100%;
            padding: 10px 14px;
            border: 1px solid #666;
            background-color: #555555;
            color: #ffffff;
            border-radius: 5px;
            font-size: 1em;
            box-sizing: border-box;
            font-weight: 400;
        }
        .form-group input::placeholder,
        .form-group textarea::placeholder {
            color: #ababab;
            opacity: 1;
        }
        .form-group textarea {
            min-height: 120px;
            resize: vertical;
            line-height: 1.5;
        }
        .btn-submit-contact {
            display: block;
            width: 100%;
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            background-color: #FFC107;
            color: #333333;
            font-size: 1.1em;
            font-weight: 700;
            cursor: pointer;
            transition: background-color 0.2s ease, transform 0.1s ease;
            font-family: inherit;
            margin-top: 10px;
        }
        .btn-submit-contact:hover {
            background-color: #e0a800;
        }
        .btn-submit-contact:active {
            transform: scale(0.97);
        }
        .message-feedback {
            padding: 12px 18px;
            margin-bottom: 25px;
            border-radius: 5px;
            text-align: center;
            font-weight: 400;
            font-size: 1em;
            line-height: 1.5;
            display: none;
        }
        .message-feedback.success {
            background-color: #5cb85c;
            color: white;
            border: 1px solid #4cae4c;
        }
        .message-feedback.error {
            background-color: #d9534f;
            color: white;
            border: 1px solid #d43f3a;
        }
        @media (max-width: 768px) {
            .page-title { font-size: 2em; }
            .contact-form-box { padding: 25px 20px; }
        }
        @media (max-width: 480px) {
            .container { padding: 0 15px; }
            .page-title { font-size: 1.8em; margin-bottom: 15px; }
            .page-subtitle { font-size: 1em; margin-bottom: 30px; }
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/pages/navbar.jsp">
        <jsp:param name="activePage" value="contact"/>
    </jsp:include>

    <div class="main-content-area">
        <div class="container">
            <h1 class="page-title">Get In Touch</h1>
            <p class="page-subtitle">We'd love to hear from you! Fill out the form below and we'll get back to you as soon as possible.</p>

            <div class="message-feedback" id="messageFeedback"></div>

            <div class="contact-form-box">
                <form id="contactForm">
                    <div class="form-group">
                        <label for="contactName">Full Name</label>
                        <input type="text" id="contactName" name="contactName" required
                               value="${fn:escapeXml(sessionScope.loggedInUser.fullName)}">
                    </div>
                    <div class="form-group">
                        <label for="contactEmail">Email Address</label>
                        <input type="email" id="contactEmail" name="contactEmail" required
                               value="${fn:escapeXml(sessionScope.loggedInUser.email)}">
                    </div>
                    <div class="form-group">
                        <label for="contactSubject">Subject</label>
                        <input type="text" id="contactSubject" name="contactSubject" required>
                    </div>
                    <div class="form-group">
                        <label for="contactMessage">Message</label>
                        <textarea id="contactMessage" name="contactMessage" rows="6" required></textarea>
                    </div>
                    <button type="submit" class="btn-submit-contact">
                        <i class="fas fa-paper-plane"></i> Send Message
                    </button>
                </form>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/pages/footer.jsp" />

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const contactForm = document.getElementById('contactForm');
            const messageFeedbackDiv = document.getElementById('messageFeedback');

            contactForm.addEventListener('submit', function(event) {
                event.preventDefault();

                const name = document.getElementById('contactName').value.trim();
                const email = document.getElementById('contactEmail').value.trim();
                const subject = document.getElementById('contactSubject').value.trim();
                const message = document.getElementById('contactMessage').value.trim();

                let errors = [];
                if (!name) errors.push("Full Name is required.");
                if (!email) {
                    errors.push("Email Address is required.");
                } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
                    errors.push("Please enter a valid email address.");
                }
                if (!subject) errors.push("Subject is required.");
                if (!message) errors.push("Message is required.");

                messageFeedbackDiv.style.display = 'none';
                messageFeedbackDiv.className = 'message-feedback';

                if (errors.length > 0) {
                    messageFeedbackDiv.classList.add('error');
                    messageFeedbackDiv.innerHTML = "<strong>Please correct the following:</strong><ul>" +
                                                  errors.map(e => `<li>${e}</li>`).join('') + "</ul>";
                    messageFeedbackDiv.style.display = 'block';
                    return;
                }

                console.log("Simulating message send:");
                console.log("Name:", name);
                console.log("Email:", email);
                console.log("Subject:", subject);
                console.log("Message:", message);

                messageFeedbackDiv.classList.add('success');
                messageFeedbackDiv.innerHTML = "<strong>Thank you!</strong> Your message has been 'sent' successfully. We'll get back to you shortly.";
                messageFeedbackDiv.style.display = 'block';

                contactForm.reset();

                setTimeout(function() {
                    messageFeedbackDiv.style.display = 'none';
                }, 7000);
            });
        });
    </script>

</body>
</html>