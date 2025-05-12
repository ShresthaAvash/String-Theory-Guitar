<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="currentUser" value="${sessionScope.loggedInUser}" />

<nav class="navbar">
    <div class="site-title">
        <a href="${pageContext.request.contextPath}/home">String Theory Guitars</a>
    </div>

    <ul class="nav-links">
        <c:if test="${empty currentUser}">
            <li><a href="${pageContext.request.contextPath}/home" class="nav-item ${param.activePage == 'home' ? 'active' : ''}">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/browse" class="nav-item ${param.activePage == 'inventory' ? 'active' : ''}">Browse Inventory</a></li>
            <li><a href="${pageContext.request.contextPath}/about" class="nav-item ${param.activePage == 'about' ? 'active' : ''}">About</a></li>
            <li><a href="${pageContext.request.contextPath}/help" class="nav-item ${param.activePage == 'help' ? 'active' : ''}">Help</a></li>
        </c:if>
        <c:if test="${not empty currentUser}">
             <li><a href="${pageContext.request.contextPath}/home" class="nav-item ${param.activePage == 'home' ? 'active' : ''}">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/browse" class="nav-item ${param.activePage == 'inventory' ? 'active' : ''}">Browse Inventory</a></li>
             <li><a href="${pageContext.request.contextPath}/help" class="nav-item ${param.activePage == 'help' ? 'active' : ''}">Help</a></li>
             <c:if test="${currentUser.role == 'customer'}">
                <li><a href="${pageContext.request.contextPath}/cart" class="nav-item ${param.activePage == 'cart' ? 'active' : ''}">Cart</a></li>
             </c:if>
             <c:if test="${currentUser.role == 'admin'}">
                <li><a href="${pageContext.request.contextPath}/dashboard" class="nav-item ${param.activePage == 'dashboard' ? 'active' : ''}">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/manage-inventory" class="nav-item ${param.activePage == 'admin-inventory' ? 'active' : ''}">Inventory</a></li>
                <li><a href="${pageContext.request.contextPath}/add-guitar" class="nav-item ${param.activePage == 'add-guitar' ? 'active' : ''}">Add Guitar</a></li>
                <%-- The "Reports" link was here --%>
             </c:if>
        </c:if>
    </ul>

    <div class="auth-actions">
        <c:choose>
            <c:when test="${not empty currentUser}">
                <span class="welcome-text">
                    Welcome, <c:out value="${currentUser.username}"/>!
                    (<c:out value="${currentUser.role}"/>)
                </span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-logout-style">Logout</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login" class="btn btn-login-style">Login</a>
                <a href="${pageContext.request.contextPath}/register" class="btn btn-register-style">Register</a>
            </c:otherwise>
        </c:choose>
    </div>
</nav>

<style>
    /* Your existing navbar CSS */
    .navbar {
        background-color: #333333;
        padding: 15px 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        color: #ffffff;
        font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
    }
    .site-title {
        flex-shrink: 0;
        flex-grow: 0;
    }
    .site-title a {
        font-size: 2em;
        font-weight: 700;
        text-decoration: none;
        color: #FFC107;
        text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);
        transition: transform 0.2s ease;
        display: inline-block;
    }
    .site-title a:active {
        transform: scale(0.98);
    }
    .nav-links {
        list-style: none;
        padding: 0;
        margin: 0;
        display: flex;
        justify-content: center;
        flex-grow: 1;
        flex-shrink: 1;
        gap: 30px;
    }
    .nav-links li a.nav-item {
        color: #e0e0e0;
        text-decoration: none;
        font-size: 1em;
        font-weight: 400;
        padding-bottom: 8px;
        position: relative;
        transition: color 0.3s ease, transform 0.1s ease;
        display: inline-block;
        white-space: nowrap;
    }
    .nav-links li a.nav-item::after {
        content: '';
        position: absolute;
        width: 0;
        height: 2px;
        background-color: #FFC107;
        bottom: 0;
        left: 50%;
        transition: all 0.3s ease-out;
        transform: translateX(-50%);
    }
    .nav-links li a.nav-item:hover {
        color: #ffffff;
    }
    .nav-links li a.nav-item:hover::after {
        width: 100%;
    }
    .nav-links li a.nav-item.active::after {
        width: 0 !important;
    }
    .nav-links li a.nav-item.active {
        font-weight: 700;
        border-bottom: 3px solid #FFC107;
        padding-bottom: 5px;
    }
    .nav-links li a.nav-item:active {
        transform: translateY(1px);
    }
    .auth-actions {
        display: flex;
        align-items: center;
        gap: 15px;
        flex-shrink: 0;
        flex-grow: 0;
    }
    .welcome-text {
        color: #e0e0e0;
        font-size: 0.95em;
        font-weight: 400;
        white-space: nowrap;
    }
    .btn {
        padding: 8px 18px;
        border: none;
        border-radius: 5px;
        text-decoration: none;
        font-size: 0.95em;
        font-weight: 700;
        cursor: pointer;
        transition: background-color 0.2s ease, color 0.2s ease, transform 0.1s ease;
        text-align: center;
        font-family: inherit;
        display: inline-block;
        white-space: nowrap;
    }
    .btn:active {
        transform: scale(0.97);
    }
    .btn-login-style {
        background-color: #4f4f4f;
        color: #ffffff;
    }
    .btn-login-style:hover {
        background-color: #666666;
    }
    .btn-register-style {
        background-color: #FFC107;
        color: #333333;
    }
    .btn-register-style:hover {
        background-color: #e0a800;
    }
    .btn-logout-style {
        background-color: #4f4f4f;
        color: #ffffff;
    }
    .btn-logout-style:hover {
        background-color: #666666;
    }
</style>