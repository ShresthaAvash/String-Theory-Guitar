<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="currentUser" value="${sessionScope.loggedInUser}" />

<nav class="navbar">
    <div class="site-title">
        <a href="${pageContext.request.contextPath}/home">String Theory Guitars</a>
    </div>

    <button class="navbar-toggler" aria-label="Toggle navigation" aria-expanded="false">
        <span class="toggler-icon"></span>
        <span class="toggler-icon"></span>
        <span class="toggler-icon"></span>
    </button>

    <div class="navbar-collapse">
        <ul class="nav-links">
            <c:if test="${empty currentUser}">
                <li><a href="${pageContext.request.contextPath}/home" class="nav-item ${param.activePage == 'home' ? 'active' : ''}">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/browse" class="nav-item ${param.activePage == 'inventory' ? 'active' : ''}">Browse Inventory</a></li>
                <li><a href="${pageContext.request.contextPath}/about" class="nav-item ${param.activePage == 'about' ? 'active' : ''}">About</a></li>
                <li><a href="${pageContext.request.contextPath}/contact" class="nav-item ${param.activePage == 'contact' ? 'active' : ''}">Contact Us</a></li>
                <li><a href="${pageContext.request.contextPath}/help" class="nav-item ${param.activePage == 'help' ? 'active' : ''}">Help</a></li>
            </c:if>
            <c:if test="${not empty currentUser}">
                 <li><a href="${pageContext.request.contextPath}/home" class="nav-item ${param.activePage == 'home' ? 'active' : ''}">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/browse" class="nav-item ${param.activePage == 'inventory' ? 'active' : ''}">Browse Inventory</a></li>
                 <li><a href="${pageContext.request.contextPath}/contact" class="nav-item ${param.activePage == 'contact' ? 'active' : ''}">Contact Us</a></li>
                 <li><a href="${pageContext.request.contextPath}/help" class="nav-item ${param.activePage == 'help' ? 'active' : ''}">Help</a></li>
                 <c:if test="${currentUser.role == 'customer'}">
                    <%-- Profile link removed from here, will be an icon in auth-actions --%>
                    <li><a href="${pageContext.request.contextPath}/cart" class="nav-item ${param.activePage == 'cart' ? 'active' : ''}">Cart</a></li>
                 </c:if>
                 <c:if test="${currentUser.role == 'admin'}">
                    <li><a href="${pageContext.request.contextPath}/dashboard" class="nav-item ${param.activePage == 'dashboard' ? 'active' : ''}">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/manage-inventory" class="nav-item ${param.activePage == 'admin-inventory' ? 'active' : ''}">Inventory</a></li>
                    <li><a href="${pageContext.request.contextPath}/add-guitar" class="nav-item ${param.activePage == 'add-guitar' ? 'active' : ''}">Add Guitar</a></li>
                 </c:if>
            </c:if>
        </ul>

        <div class="auth-actions">
            <c:choose>
                <c:when test="${not empty currentUser}">
                    <span class="welcome-text">
                        Welcome, <c:out value="${currentUser.username}"/>!
                        <c:if test="${currentUser.role == 'admin'}">
                            (<c:out value="${currentUser.role}"/>)
                        </c:if>
                    </span>
                    <c:if test="${currentUser.role == 'customer'}">
                        <a href="${pageContext.request.contextPath}/profile" class="nav-icon-btn profile-icon-link ${param.activePage == 'profile' ? 'active' : ''}" title="My Profile">
                            <i class="fas fa-user-circle"></i>
                        </a>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-logout-style">Logout</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-login-style">Login</a>
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-register-style">Register</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>

<style>
    .navbar {
        background-color: #333333;
        padding: 15px 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        color: #ffffff;
        font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
        position: relative;
        z-index: 1000;
    }
    .site-title a {
        font-size: 1.8em;
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
    .navbar-toggler {
        display: none;
        background: none;
        border: none;
        padding: 8px;
        cursor: pointer;
    }
    .navbar-toggler .toggler-icon {
        display: block;
        width: 22px;
        height: 2px;
        background-color: #FFC107;
        margin: 5px 0;
        transition: transform 0.3s ease, opacity 0.3s ease;
    }
    .navbar-toggler.active .toggler-icon:nth-child(1) {
        transform: translateY(7px) rotate(45deg);
    }
    .navbar-toggler.active .toggler-icon:nth-child(2) {
        opacity: 0;
    }
    .navbar-toggler.active .toggler-icon:nth-child(3) {
        transform: translateY(-7px) rotate(-45deg);
    }
    .navbar-collapse {
        display: flex;
        align-items: center;
        flex-grow: 1;
    }
    .nav-links {
        list-style: none;
        padding: 0;
        margin: 0 0 0 30px;
        display: flex;
        justify-content: flex-start;
        flex-grow: 1;
        gap: 25px;
    }
    .nav-links li a.nav-item {
        color: #e0e0e0;
        text-decoration: none;
        font-size: 0.95em;
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
        margin-left: auto;
    }
    .welcome-text {
        color: #e0e0e0;
        font-size: 0.9em;
        font-weight: 400;
        white-space: nowrap;
    }
    .nav-icon-btn { 
        color: #e0e0e0;
        text-decoration: none;
        font-size: 1.5em; 
        padding: 5px;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: color 0.2s ease, transform 0.1s ease;
    }
    .nav-icon-btn:hover {
        color: #FFC107;
        transform: scale(1.1);
    }
    .nav-icon-btn.active {
        color: #FFC107;
    }
    .btn {
        padding: 7px 15px;
        border: none;
        border-radius: 5px;
        text-decoration: none;
        font-size: 0.9em;
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
    .btn-login-style { background-color: #4f4f4f; color: #ffffff; }
    .btn-login-style:hover { background-color: #666666; }
    .btn-register-style { background-color: #FFC107; color: #333333; }
    .btn-register-style:hover { background-color: #e0a800; }
    .btn-logout-style { background-color: #4f4f4f; color: #ffffff; }
    .btn-logout-style:hover { background-color: #666666; }

    @media (max-width: 992px) {
        .nav-links { gap: 15px; }
        .nav-links li a.nav-item { font-size: 0.9em; }
    }
    @media (max-width: 880px) {
        .navbar-toggler { display: block; order: 2; margin-left: auto; }
        .navbar-collapse { display: none; flex-direction: column; align-items: flex-start; width: 100%; position: absolute; top: 100%; left: 0; background-color: #3a3a3a; padding: 15px 20px; box-shadow: 0 4px 8px rgba(0,0,0,0.2); border-top: 1px solid #4f4f4f; }
        .navbar-collapse.active { display: flex; }
        .nav-links { flex-direction: column; width: 100%; margin: 0 0 15px 0; gap: 0; }
        .nav-links li { width: 100%; }
        .nav-links li a.nav-item { display: block; padding: 12px 0; font-size: 1em; border-bottom: 1px solid #4f4f4f; }
        .nav-links li:last-child a.nav-item { border-bottom: none; }
        .nav-links li a.nav-item::after { display: none; }
        .nav-links li a.nav-item.active { border-bottom: 1px solid #4f4f4f; color: #FFC107; font-weight: 700; }

        .auth-actions {
            flex-direction: column;
            width: 100%;
            align-items: stretch;
            gap: 10px;
            margin-left: 0;
            padding-top: 10px;
            border-top: 1px solid #4f4f4f; 
        }
        .auth-actions .welcome-text { text-align: center; padding: 10px 0; font-size: 1em; border-bottom: none; margin-bottom: 5px; }
        .auth-actions .nav-icon-btn.profile-icon-link { 
            display: block;
            text-align: center;
            padding: 10px 0;
            font-size: 1.1em;
            border-bottom: 1px solid #4f4f4f;
        }
         .auth-actions .nav-icon-btn.profile-icon-link i {
            margin-right: 8px;
        }
        .auth-actions .btn { width: 100%; font-size: 1em; }
    }
    @media (max-width: 400px) {
        .site-title a { font-size: 1.5em; }
    }
</style>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const navbarToggler = document.querySelector('.navbar-toggler');
        const navbarCollapse = document.querySelector('.navbar-collapse');

        if (navbarToggler && navbarCollapse) {
            navbarToggler.addEventListener('click', function() {
                navbarCollapse.classList.toggle('active');
                navbarToggler.classList.toggle('active');
                const isExpanded = navbarToggler.getAttribute('aria-expanded') === 'true' || false;
                navbarToggler.setAttribute('aria-expanded', !isExpanded);
            });
        }
    });
</script>