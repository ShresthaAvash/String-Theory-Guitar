<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - String Theory Guitars</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        body {
            margin: 0;
            padding: 20px;
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
            background-color: #333333;
            color: #ffffff;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            box-sizing: border-box;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
            position: relative;
        }
        .go-back-button {
            position: absolute;
            top: 20px;
            left: 20px;
            padding: 8px 15px;
            background-color: #555555;
            color: #FFC107; 
            border: 1px solid #666; 
            border-radius: 5px;
            text-decoration: none;
            font-size: 0.9em;
            font-weight: 700;
            transition: background-color 0.3s ease, color 0.3s ease;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .go-back-button:hover {
            background-color: #666666;
            color: #ffffff;
        }
        .go-back-button i {
            font-size: 0.9em;
        }

        .form-container {
            background-color: #444444;
            padding: 40px 35px;
            border-radius: 8px;
            width: 100%;
            max-width: 400px;
            box-sizing: border-box;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }
        .form-container h1 {
            font-size: 2.5em;
            margin-top: 0;
            margin-bottom: 30px;
            color: #ffffff;
            font-weight: 700;
            line-height: 1.2;
        }
        .form-container input[type="text"],
        .form-container input[type="password"] {
            font-family: inherit;
            width: 100%;
            padding: 12px 15px;
            margin-bottom: 20px;
            border: 1px solid #666;
            background-color: #555555;
            color: #ffffff;
            border-radius: 5px;
            font-size: 1em;
            box-sizing: border-box;
            font-weight: 400;
        }
        .form-container input::placeholder {
            color: #bbbbbb;
            opacity: 1;
        }
        .form-container .submit-btn {
            font-family: inherit;
            width: 100%;
            padding: 12px;
            background-color: #FFC107;
            color: #333333;
            border: none;
            border-radius: 5px;
            font-size: 1.1em;
            font-weight: 700;
            cursor: pointer;
            margin-top: 10px;
            transition: background-color 0.3s ease, transform 0.1s ease;
        }
        .form-container .submit-btn:hover {
            background-color: #e0a800;
        }
        .form-container .submit-btn:active {
            transform: scale(0.97);
        }
        .form-container .switch-link {
            font-size: 0.95em;
            color: #e0e0e0;
            margin-top: 25px;
            font-weight: 400;
        }
        .form-container .switch-link a {
            color: #FFC107;
            text-decoration: none;
            font-weight: 700;
        }
        .form-container .switch-link a:hover {
            text-decoration: underline;
        }
        .forgot-password-link {
            font-size: 0.9em;
            margin-top: 15px;
            display: block;
        }
        .forgot-password-link a {
            color: #cccccc;
            text-decoration: none;
            font-weight: 400;
        }
        .forgot-password-link a:hover {
            color: #FFC107;
            text-decoration: underline;
        }
        .message {
            padding: 10px 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            text-align: center;
            font-weight: 400;
            font-size: 0.95em;
            line-height: 1.4;
        }
        .error-message {
            background-color: #d9534f;
            color: white;
            border: 1px solid #d43f3a;
        }
        .success-message {
            background-color: #5cb85c;
            color: white;
            border: 1px solid #4cae4c;
        }
        .info-message {
            background-color: #5bc0de;
            color: white;
            border: 1px solid #46b8da;
        }
         @media (max-width: 480px) { 
            .go-back-button {
                top: 10px;
                left: 10px;
                padding: 6px 10px;
                font-size: 0.8em;
            }
            .form-container h1 {
                 font-size: 2em;
            }
        }
    </style>
</head>
<body>
    <a href="${pageContext.request.contextPath}/home" class="go-back-button">
        <i class="fas fa-arrow-left"></i> Back to Home
    </a>

    <div class="form-container">
        <h1>String Theory<br>Guitars</h1>

        <c:if test="${not empty param.message}">
            <p class="message info-message"><c:out value="${param.message}" /></p>
        </c:if>
        <c:if test="${not empty errorMessage}"><p class="message error-message"><c:out value="${errorMessage}" /></p></c:if>
        <c:if test="${param.registration == 'success'}"><p class="message success-message">Registration successful! Please login.</p></c:if>
        <c:if test="${param.logout == 'success' || param.logout == 'simulated'}"><p class="message success-message">You have been logged out successfully.</p></c:if>
        <c:if test="${param.reset == 'success'}"><p class="message success-message">Password successfully reset! Please login.</p></c:if>
        <c:if test="${param.reset == 'invalid'}"><p class="message error-message">Password reset link was invalid or expired. Please try again.</p></c:if>
        <c:if test="${param.error == 'auth'}"><p class="message error-message">Authorization required. Please login.</p></c:if>

        <form action="${pageContext.request.contextPath}/login" method="post" novalidate>
            <input type="text" id="username" name="username" placeholder="Username" required autofocus value="<c:out value='${username}'/>">
            <input type="password" id="password" name="password" placeholder="Password" required>
            <button type="submit" class="submit-btn">Login</button>
        </form>

        <div class="forgot-password-link">
            <a href="${pageContext.request.contextPath}/forgot-password">Forgot your password?</a>
        </div>

        <p class="switch-link">
            Don't have an account? <a href="${pageContext.request.contextPath}/register">Register here</a>
        </p>
    </div>
</body>
</html>