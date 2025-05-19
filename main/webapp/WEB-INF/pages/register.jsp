<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - String Theory Guitars</title>
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
            font-size: 2.2em;
            margin-top: 0;
            margin-bottom: 15px;
            color: #ffffff;
            font-weight: 700;
        }
        .form-container .description {
            color: #e0e0e0;
            margin-bottom: 30px;
            font-size: 1em;
            line-height: 1.4;
            font-weight: 400;
        }
        .form-container label {
            display: block;
            text-align: left;
            margin-bottom: 5px;
            font-size: 0.9em;
            color: #e0e0e0;
            font-weight: 700;
        }
        .form-container input[type="text"],
        .form-container input[type="password"],
        .form-container input[type="email"] {
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
            margin-top: 30px;
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
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Register New Account</h1>
        <p class="description">Create your customer account to browse inventory.</p>

        <c:if test="${not empty errorMessage}">
            <p class="message error-message"><c:out value="${errorMessage}" /></p>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post" novalidate>
            <label for="username">Username</label>
            <input type="text" id="username" name="username" required minlength="3" value="<c:out value='${usernameValue}'/>">

            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" required value="<c:out value='${emailValue}'/>">

            <%-- Added Full Name Field --%>
            <label for="fullName">Full Name</label>
            <input type="text" id="fullName" name="fullName" required value="<c:out value='${fullNameValue}'/>">

            <label for="password">Password (min 8 chars)</label>
            <input type="password" id="password" name="password" required minlength="8">

            <label for="confirmPassword">Confirm Password</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required minlength="8">

            <button type="submit" class="submit-btn">Register as Customer</button>
        </form>
        <p class="switch-link">
            Already have an account? <a href="${pageContext.request.contextPath}/login">Login here</a>
        </p>
    </div>
</body>
</html>