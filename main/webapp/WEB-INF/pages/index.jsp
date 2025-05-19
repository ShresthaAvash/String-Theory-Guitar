<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>String Theory Guitars - Home</title>
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
            max-width: 1000px;
            margin: 40px auto;
            padding: 0 20px;
            box-sizing: border-box;
        }
        .welcome-section {
            margin-bottom: 50px;
            text-align: center;
        }
        .welcome-title {
            font-size: 2.8em;
            color: #FFC107;
            font-weight: 700;
            margin-top: 0;
            margin-bottom: 15px;
        }
        .welcome-subtitle {
            font-size: 1.1em;
            color: #cccccc;
            margin-top: 0;
            margin-bottom: 35px;
            font-weight: 400;
        }
        .featured-section {
            margin-bottom: 50px;
        }
        .featured-heading {
            font-size: 1.8em;
            color: #ffffff;
            font-weight: 700;
            text-align: center;
            margin-top: 0;
            margin-bottom: 30px;
            padding-bottom: 10px;
            border-bottom: 1px solid #555;
        }
        .featured-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
            justify-content: center;
        }
        .product-card {
            background-color: #444444;
            border-radius: 8px;
            overflow: hidden;
            width: 100%;
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
            box-shadow: 0 3px 6px rgba(0,0,0,0.25);
            transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
        }
        .product-card:hover {
            transform: translateY(-6px) scale(1.02);
            box-shadow: 0 8px 16px rgba(0,0,0,0.35);
        }
        .product-card .card-image {
            height: 200px;
            background-color: #555555;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        .product-card .card-image img {
            display: block;
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .product-card .card-content {
            padding: 18px;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }
        .product-card h3 {
            font-size: 1.1em;
            color: #ffffff;
            font-weight: 700;
            margin-top: 0;
            margin-bottom: 8px;
            line-height: 1.3;
            min-height: 3.9em;
            text-align: left;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .product-card .price {
            font-size: 1.25em;
            color: #FFC107;
            font-weight: 700;
            margin-bottom: 10px;
            text-align: left;
        }
        .product-card .condition {
            font-size: 0.85em;
            color: #cccccc;
            font-weight: 400;
            margin-bottom: 20px;
            flex-grow: 1;
            text-align: left;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-size: 0.95em;
            font-weight: 700;
            cursor: pointer;
            text-align: center;
            transition: background-color 0.2s ease, color 0.2s ease, transform 0.15s ease;
            box-sizing: border-box;
            font-family: inherit;
        }
        .btn:active {
            transform: scale(0.97);
        }
        .btn-details {
            background-color: #FFC107;
            color: #333333;
            margin-top: auto;
            align-self: center;
        }
        .btn-details:hover {
            background-color: #e0a800;
            transform: scale(1.05);
        }
        .browse-section {
            text-align: center;
            margin-top: 40px;
            margin-bottom: 40px;
        }
        .btn-browse {
            background-color: #4f4f4f;
            color: #ffffff;
            padding: 11px 22px;
            font-size: 0.95em;
        }
        .btn-browse:hover {
            background-color: #666666;
        }
        .no-featured-message {
            text-align: center;
            font-size: 1.1em;
            color: #aaa;
            padding: 20px 0;
            grid-column: 1 / -1;
        }
        @media (max-width: 1024px) {
            .featured-grid {
                grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            }
        }
        @media (max-width: 768px) {
            .welcome-title { font-size: 2.2em; }
            .featured-heading { font-size: 1.6em; }
            .featured-grid {
                grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
                gap: 20px;
            }
        }
        @media (max-width: 540px) {
            .welcome-title { font-size: 1.8em; }
            .welcome-subtitle { font-size: 1em; }
            .featured-heading { font-size: 1.4em; }
            .featured-grid {
                grid-template-columns: 1fr;
            }
            .product-card {
                 max-width: 320px;
                 margin-left: auto;
                 margin-right: auto;
            }
            .container { padding: 0 10px; }
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/pages/navbar.jsp">
        <jsp:param name="activePage" value="home"/>
    </jsp:include>

    <div class="main-content-area">
        <div class="container">
            <section class="welcome-section">
                <h1 class="welcome-title">Welcome to String Theory Guitars!</h1>
                <p class="welcome-subtitle">Discover your next favorite instrument.</p>
            </section>

            <section class="featured-section">
                <h2 class="featured-heading">Featured Guitars</h2>
                <div class="featured-grid">
                    <c:choose>
                        <c:when test="${not empty featuredGuitars}">
                            <c:forEach var="guitar" items="${featuredGuitars}">
                                <div class="product-card">
                                    <div class="card-image">
                                        <c:set var="displayImageUrl" value="${guitar.getMainImageUrl()}"/>
                                        <c:choose>
                                            <c:when test="${not empty displayImageUrl}">
                                                <img src="${fn:escapeXml(displayImageUrl)}"
                                                     alt="${fn:escapeXml(guitar.brand)} ${fn:escapeXml(guitar.model)}">
                                            </c:when>
                                            <c:otherwise>
                                                <c:url var="placeholderUrl" value="/images/guitar-deviser.jpg" />
                                                <img src="${placeholderUrl}"
                                                     alt="Placeholder Guitar Image">
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="card-content">
                                        <h3><c:out value="${guitar.brand}"/> <c:out value="${guitar.model}"/></h3>
                                        <p class="price">
                                            <fmt:setLocale value="en_US"/>
                                            <fmt:formatNumber value="${guitar.price}" type="currency" currencySymbol="$"/>
                                        </p>
                                        <p class="condition">
                                            Condition: <c:out value="${guitar.conditionRating}"/>
                                            <c:if test="${not empty guitar.yearProduced && guitar.yearProduced != 0}">
                                                | Year: <c:out value="${guitar.yearProduced}"/>
                                            </c:if>
                                        </p>
                                        <a href="${pageContext.request.contextPath}/product?id=${guitar.id}" class="btn btn-details">View Details</a>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <p class="no-featured-message">No featured guitars available at the moment. Check back soon!</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </section>

            <section class="browse-section">
                <a href="${pageContext.request.contextPath}/browse" class="btn btn-browse">Browse All Guitars</a>
            </section>
        </div>
    </div>

    <jsp:include page="/WEB-INF/pages/footer.jsp" />

</body>
</html>