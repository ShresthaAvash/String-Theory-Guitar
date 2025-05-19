<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:if test="${empty sessionScope.loggedInUser}">
    <c:redirect url="${pageContext.request.contextPath}/login?message=Please+login+to+view+your+profile"/>
</c:if>
<c:set var="user" value="${requestScope.user != null ? requestScope.user : sessionScope.loggedInUser}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - String Theory Guitars</title>
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
            max-width: 600px;
            margin: 40px auto;
            padding: 0 20px;
            box-sizing: border-box;
        }
        .page-title {
            font-size: 2.2em;
            color: #FFC107;
            font-weight: 700;
            text-align: center;
            margin-top: 0;
            margin-bottom: 30px;
        }
        .profile-box {
            background-color: #444444;
            border-radius: 8px;
            padding: 25px 30px;
            box-shadow: 0 3px 8px rgba(0,0,0,0.2);
        }
        .profile-form .form-group {
            margin-bottom: 20px;
        }
        .profile-form label {
            display: block;
            text-align: left;
            margin-bottom: 6px;
            font-size: 0.9em;
            color: #e0e0e0;
            font-weight: 700;
        }
        .profile-form input[type="text"],
        .profile-form input[type="email"] {
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
        .profile-form input[disabled] {
            background-color: #484848;
            color: #aaa;
            cursor: not-allowed;
            border-color: #585858;
        }
        .btn-save-profile {
            display: inline-block;
            padding: 10px 25px;
            border: none;
            border-radius: 5px;
            background-color: #FFC107;
            color: #333333;
            font-size: 1em;
            font-weight: 700;
            cursor: pointer;
            transition: background-color 0.2s ease, transform 0.1s ease;
            text-align: center;
            margin-top:10px;
        }
        .btn-save-profile:hover {
            background-color: #e0a800;
        }
        .btn-save-profile:active {
            transform: scale(0.97);
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
        .success-message {
            background-color: #5cb85c;
            color: white;
            border: 1px solid #4cae4c;
        }
        .error-message {
            background-color: #d9534f;
            color: white;
            border: 1px solid #d43f3a;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/pages/navbar.jsp">
        <jsp:param name="activePage" value="profile"/>
    </jsp:include>

    <div class="main-content-area">
        <div class="container">
            <h1 class="page-title">My Profile</h1>

            <div class="profile-box">
                <c:if test="${not empty successMessage}">
                    <p class="message success-message"><i class="fas fa-check-circle"></i> <c:out value="${successMessage}"/></p>
                </c:if>
                <c:if test="${not empty errorMessage}">
                    <p class="message error-message"><i class="fas fa-exclamation-circle"></i> <c:out value="${errorMessage}"/></p>
                </c:if>

                <form class="profile-form" action="${pageContext.request.contextPath}/profile" method="post">
                    <h2>Account Information</h2>
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username" value="${fn:escapeXml(user.username)}" disabled>
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" value="${fn:escapeXml(user.email)}" disabled>
                    </div>
                    <div class="form-group">
                        <label for="fullName">Full Name</label>
                        <input type="text" id="fullName" name="fullName" value="${fn:escapeXml(user.fullName)}" required maxlength="100">
                    </div>
                    <button type="submit" class="btn-save-profile"><i class="fas fa-save"></i> Save Changes</button>
                </form>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/pages/footer.jsp" />
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const messages = document.querySelectorAll('.message.success-message, .message.error-message');
            messages.forEach(function(msg) {
                setTimeout(function() {
                    msg.style.transition = 'opacity 0.5s ease';
                    msg.style.opacity = '0';
                    setTimeout(function() { msg.style.display = 'none'; }, 500);
                }, 5000);
            });
        });
    </script>
</body>
</html>