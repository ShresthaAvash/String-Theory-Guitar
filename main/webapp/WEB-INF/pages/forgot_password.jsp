<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - String Theory Guitars</title>
    <style>
        body {
            margin: 0; padding: 20px;
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
            background-color: #333333; color: #ffffff; display: flex; justify-content: center; align-items: center; min-height: 100vh; box-sizing: border-box;
            -webkit-font-smoothing: antialiased; -moz-osx-font-smoothing: grayscale;
        }
        .form-container {
            background-color: #444444; padding: 40px 35px; border-radius: 8px; width: 100%; max-width: 450px; box-sizing: border-box; text-align: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }
        .form-container h1 {
            font-size: 2.0em; margin-top: 0; margin-bottom: 15px; color: #ffffff; font-weight: 700;
        }
        .form-container .description {
            color: #e0e0e0; margin-bottom: 30px; font-size: 1em; line-height: 1.4; font-weight: 400; text-align: left;
        }
        .form-container label {
            display: block; text-align: left; margin-bottom: 5px; font-size: 0.9em; color: #e0e0e0; font-weight: 700;
        }
        .form-container input[type="email"] {
            font-family: inherit; width: 100%; padding: 12px 15px; margin-bottom: 25px; border: 1px solid #666;
            background-color: #555555; color: #ffffff; border-radius: 5px; font-size: 1em; box-sizing: border-box; font-weight: 400;
        }
        .form-container input::placeholder { color: #bbbbbb; opacity: 1; }
        .form-container .submit-btn,
        .form-container .reset-password-btn {
            font-family: inherit; display: inline-block; width: auto; padding: 12px 30px; background-color: #FFC107; color: #333333; border: none;
            border-radius: 5px; font-size: 1.1em; font-weight: 700; cursor: pointer; margin-top: 10px;
            transition: background-color 0.3s ease, transform 0.1s ease; text-decoration: none;
        }
        .form-container .submit-btn:hover,
        .form-container .reset-password-btn:hover { background-color: #e0a800; }
        .form-container .submit-btn:active,
        .form-container .reset-password-btn:active { transform: scale(0.97); }
        .back-link {
            margin-top: 25px; font-size: 0.95em; font-weight: 400;
        }
        .back-link a { color: #FFC107; text-decoration: none; font-weight: 700; }
        .back-link a:hover { text-decoration: underline; }
        .message {
            padding: 10px 15px; margin-bottom: 20px; border-radius: 5px; text-align: center;
            font-weight: 400; font-size: 0.95em; line-height: 1.4;
        }
        .error-message { background-color: #d9534f; color: white; border: 1px solid #d43f3a; }
        .info-message { background-color: #5bc0de; color: white; border: 1px solid #46b8da; }
        .simulated-link-box {
             color:#cccccc; margin-bottom: 20px; word-wrap: break-word; border: 1px dashed #666;
             padding: 15px; border-radius: 4px; text-align: left; font-size: 0.9em; line-height: 1.5;
             background-color: #3a3a3a;
        }
        .simulated-link-box strong { color: #FFC107; font-weight: 700;}
        .simulated-link-box a { color:#FFF; font-weight: 400; }
        .simulated-link-box a:hover { color: #FFC107;}
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Forgot Your Password?</h1>

        <c:if test="${not empty errorMessage}"><p class="message error-message"><c:out value="${errorMessage}"/></p></c:if>
        <c:if test="${not empty infoMessage}"><p class="message info-message"><c:out value="${infoMessage}"/></p></c:if>

        <c:choose>
            <c:when test="${not empty showResetButton and not empty resetToken}">
                 <p class="description" style="text-align: center; margin-bottom: 20px;">Click the button below to set a new password.</p>
                 <a href="${pageContext.request.contextPath}/reset-password?token=${resetToken}" class="reset-password-btn">Reset Password</a>
            </c:when>
            <c:otherwise>
                 <p class="description">Enter your email address below, and if an account exists, we'll allow you to reset your password.</p>
                 <form action="${pageContext.request.contextPath}/forgot-password" method="post" novalidate>
                    <label for="email">Your Email Address</label>
                    <input type="email" id="email" name="email" required value="<c:out value='${emailValue}'/>">
                    <button type="submit" class="submit-btn" style="width: 100%;">Send Reset Instructions</button>
                </form>
            </c:otherwise>
        </c:choose>

        <div class="back-link">
            <a href="${pageContext.request.contextPath}/login">Back to Login</a>
        </div>
    </div>
</body>
</html>