<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password - Sting Theory Guitars</title>
    <style>
        body {
            margin: 0; padding: 20px;
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
            background-color: #333333; color: #ffffff; display: flex; justify-content: center; align-items: center; min-height: 100vh; box-sizing: border-box;
            -webkit-font-smoothing: antialiased; -moz-osx-font-smoothing: grayscale;
        }
        .form-container {
            background-color: #444444; padding: 40px 35px; border-radius: 8px; width: 100%; max-width: 400px; box-sizing: border-box; text-align: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }
        .form-container h1 {
            font-size: 2.0em; margin-top: 0; margin-bottom: 30px; color: #ffffff; font-weight: 700;
        }
        .form-container label {
            display: block; text-align: left; margin-bottom: 5px; font-size: 0.9em; color: #e0e0e0; font-weight: 700;
        }
        .form-container input[type="password"] {
            font-family: inherit; width: 100%; padding: 12px 15px; margin-bottom: 20px; border: 1px solid #666;
            background-color: #555555; color: #ffffff; border-radius: 5px; font-size: 1em; box-sizing: border-box; font-weight: 400;
        }
         .form-container input[type="hidden"] {
             display: none;
         }
        .form-container .submit-btn {
            font-family: inherit; width: 100%; padding: 12px; background-color: #FFC107; color: #333333; border: none;
            border-radius: 5px; font-size: 1.1em; font-weight: 700; cursor: pointer; margin-top: 10px;
            transition: background-color 0.3s ease, transform 0.1s ease;
        }
        .form-container .submit-btn:hover { background-color: #e0a800; }
        .form-container .submit-btn:active { transform: scale(0.97); }
        .message {
            padding: 10px 15px; margin-bottom: 20px; border-radius: 5px; text-align: center;
            font-weight: 400; font-size: 0.95em; line-height: 1.4;
        }
        .error-message { background-color: #d9534f; color: white; border: 1px solid #d43f3a; }
        .return-link {
            margin-top: 20px;
        }
        .return-link a {
            color:#FFC107; text-decoration: none; font-weight: 700; font-size: 0.95em;
        }
        .return-link a:hover {
             text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Reset Your Password</h1>

        <c:if test="${not empty errorMessage}">
            <p class="message error-message"><c:out value="${errorMessage}"/></p>
        </c:if>

        <c:if test="${empty tokenInvalid or tokenInvalid == false}">
            <form action="${pageContext.request.contextPath}/reset-password" method="post" novalidate>
                <input type="hidden" name="token" value="<c:out value='${param.token}'/>" />

                <label for="newPassword">New Password (min 8 chars)</label>
                <input type="password" id="newPassword" name="newPassword" required minlength="8">

                <label for="confirmPassword">Confirm New Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required minlength="8">

                <button type="submit" class="submit-btn">Reset Password</button>
            </form>
        </c:if>

         <c:if test="${not empty tokenInvalid and tokenInvalid == true}">
              <p class="return-link">
                  <a href="${pageContext.request.contextPath}/login">Return to Login</a>
              </p>
         </c:if>
    </div>
</body>
</html>