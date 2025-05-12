<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Collection - String Theory Guitars</title>
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
            max-width: 1100px;
            margin: 40px auto;
            padding: 0 20px;
            box-sizing: border-box;
        }
        .page-title {
            font-size: 2.8em;
            color: #FFC107;
            font-weight: 700;
            text-align: center;
            margin-top: 0;
            margin-bottom: 40px;
        }
        .filter-bar {
            background-color: #3a3a3a;
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 40px;
            display: flex;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
        }
        .filter-input,
        .filter-select {
            padding: 8px 12px;
            border: 1px solid #555;
            background-color: #505050;
            color: #e0e0e0;
            border-radius: 5px;
            font-size: 0.95em;
            font-family: inherit;
            flex-grow: 1;
            min-width: 180px;
            font-weight: 400;
        }
        .filter-input::placeholder {
            color: #aaa;
        }
        .btn {
            display: inline-block;
            padding: 8px 18px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-size: 0.95em;
            font-weight: 700;
            cursor: pointer;
            transition: background-color 0.2s ease, color 0.2s ease, transform 0.15s ease;
            text-align: center;
            font-family: inherit;
            white-space: nowrap;
        }
        .btn:active {
            transform: scale(0.97);
        }
        .filter-button {
            background-color: #4f4f4f;
            color: #ffffff;
            padding: 9px 20px;
            flex-shrink: 0;
        }
        .filter-button:hover {
            background-color: #666666;
        }
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
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
            height: 220px;
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
            border-radius: 0;
        }
        .product-card .card-content {
            padding: 20px;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }
        .product-card h3 {
            font-size: 1.15em;
            color: #ffffff;
            font-weight: 700;
            margin-top: 0;
            margin-bottom: 8px;
            line-height: 1.3;
            min-height: 2.6em;
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
        .btn-details {
            background-color: #FFC107;
            color: #333333;
            margin-top: auto;
            align-self: center;
            transition: background-color 0.2s ease, color 0.2s ease, transform 0.2s ease;
            width: auto;
            padding: 10px 20px;
            font-size: 0.95em;
        }
        .btn-details:hover {
            background-color: #e0a800;
            transform: scale(1.05);
        }
        .no-items-message {
            grid-column: 1 / -1;
            text-align: center;
            font-size: 1.2em;
            color: #aaa;
            padding: 40px 0;
            font-style: italic;
        }
        @media (max-width: 768px) {
            .page-title { font-size: 2.2em; }
            .filter-bar { gap: 10px; }
            .filter-input, .filter-select, .filter-button { min-width: 150px; }
            .product-grid { grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; }
        }
        @media (max-width: 540px) {
            .container { padding: 0 15px; }
            .page-title { font-size: 1.8em; }
            .filter-bar { flex-direction: column; align-items: stretch; }
            .filter-input, .filter-select, .filter-button { width: 100%; box-sizing: border-box; }
            .product-grid { grid-template-columns: 1fr; }
            .product-card { max-width: 90%; margin-left: auto; margin-right: auto; }
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/pages/navbar.jsp">
        <jsp:param name="activePage" value="inventory"/>
    </jsp:include>

    <div class="main-content-area">
        <div class="container">
            <h1 class="page-title">Browse Our Collection</h1>
            <div class="filter-bar">
                 <form id="filterFormBrowse" action="${pageContext.request.contextPath}/browse" method="get" style="display: contents;">
                    <input type="text" class="filter-input" name="search" placeholder="Search by Brand, Model..." value="${fn:escapeXml(searchTerm)}">
                    <select class="filter-select" name="sort">
                        <option value="" disabled ${empty sortOrder ? 'selected' : ''}>Sort By...</option>
                        <option value="price_asc" ${sortOrder == 'price_asc' ? 'selected' : ''}>Price: Low to High</option>
                        <option value="price_desc" ${sortOrder == 'price_desc' ? 'selected' : ''}>Price: High to Low</option>
                        <option value="make_asc" ${sortOrder == 'make_asc' ? 'selected' : ''}>Brand: A to Z</option>
                        <option value="make_desc" ${sortOrder == 'make_desc' ? 'selected' : ''}>Brand: Z to A</option>
                        <option value="date_desc" ${sortOrder == 'date_desc' || empty sortOrder ? 'selected' : ''}>Date Added: Newest</option>
                        <option value="date_asc" ${sortOrder == 'date_asc' ? 'selected' : ''}>Date Added: Oldest</option>
                    </select>
                    <button type="submit" class="btn filter-button">Apply</button>
                 </form>
            </div>

            <div class="product-grid">
                <c:choose>
                    <c:when test="${not empty guitars}">
                        <c:forEach var="guitar" items="${guitars}">
                            <div class="product-card">
                                <div class="card-image">
                                    <c:choose>
                                        <c:when test="${not empty guitar.mainImageUrl}">
                                            <img src="${fn:escapeXml(guitar.mainImageUrl)}"
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
                        <p class="no-items-message">
                            <c:choose>
                                <c:when test="${not empty searchTerm}">
                                    No guitars found matching your search term: "<strong><c:out value="${searchTerm}"/></strong>".
                                </c:when>
                                <c:otherwise>
                                    No guitars currently in inventory. Please check back later!
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/pages/footer.jsp" />

</body>
</html>