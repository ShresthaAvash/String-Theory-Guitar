<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- NOTE: Located in /WEB-INF/pages/ --%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<footer class="site-footer">
    <ul class="footer-links">
        <li><a href="${pageContext.request.contextPath}/privacy">Privacy Policy</a></li>
        <li><a href="${pageContext.request.contextPath}/terms">Terms of Service</a></li>
        <li><a href="${pageContext.request.contextPath}/contact">Contact Us</a></li>
        <li><a href="${pageContext.request.contextPath}/help">FAQ</a></li>
        <li><a href="${pageContext.request.contextPath}/sitemap">Sitemap</a></li>
    </ul>

    <div class="social-links">
        <a href="#" title="Facebook" aria-label="Visit our Facebook page"><i class="fa-brands fa-facebook-f"></i></a>
        <a href="#" title="Twitter" aria-label="Visit our Twitter profile"><i class="fa-brands fa-twitter"></i></a>
        <a href="#" title="Instagram" aria-label="Visit our Instagram profile"><i class="fa-brands fa-instagram"></i></a>
    </div>

    <p class="copyright">
        © <%= new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()) %>
         <strong>String Theory Guitars</strong>. All Rights Reserved.
    </p>
</footer>

<%-- CSS for Footer --%>
<style>
    .site-footer {
        background-color: #333333;
        color: #e0e0e0;
        padding: 30px 40px;
        text-align: center;
        margin-top: auto;
        font-size: 0.9em;
        font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
        font-weight: 400;
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
    }

    .footer-links {
        list-style: none;
        padding: 0;
        margin: 0 0 15px 0;
        display: flex;
        justify-content: center;
        gap: 25px;
        flex-wrap: wrap;
    }
    .footer-links li a {
        color: #e0e0e0;
        text-decoration: none;
        transition: color 0.3s ease;
    }
    .footer-links li a:hover {
        color: #FFC107;
        text-decoration: underline;
    }

    .social-links {
        margin-bottom: 15px;
    }
    .social-links a {
        color: #e0e0e0;
        text-decoration: none;
        margin: 0 10px;
        font-size: 1.4em;
        transition: color 0.3s ease;
        display: inline-block;
    }
    .social-links a:hover {
        color: #FFC107;
    }

    .copyright {
        margin: 0;
        font-size: 0.85em;
        color: #aaaaaa;
    }
    .copyright strong {
        color: #FFC107;
        font-weight: 700;
    }
</style>