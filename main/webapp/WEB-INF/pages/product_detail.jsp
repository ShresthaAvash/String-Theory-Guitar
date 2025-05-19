<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <c:choose>
            <c:when test="${not empty guitar}">
                <c:out value="${guitar.brand}"/> <c:out value="${guitar.model}"/> - String Theory Guitars
            </c:when>
            <c:otherwise>
                Product Not Found - String Theory Guitars
            </c:otherwise>
        </c:choose>
    </title>
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
            max-width: 1100px;
            margin: 40px auto;
            padding: 0 20px;
            box-sizing: border-box;
        }
        .product-detail-layout {
            display: flex;
            gap: 40px;
            flex-wrap: wrap;
            background-color: #3a3a3a;
            padding: 30px;
            border-radius: 8px;
        }
        .product-image-column {
            flex: 1 1 40%;
            min-width: 300px;
        }
        .product-details-column {
            flex: 1 1 55%;
        }
        .main-product-image img {
            display: block;
            width: 100%;
            max-width: 500px;
            height: auto;
            max-height: 450px; /* Limit image height */
            object-fit: contain; /* Ensure whole image is visible */
            border-radius: 6px;
            background-color: #555;
            border: 1px solid #505050;
            margin: 0 auto 15px auto;
        }
        .thumbnail-gallery {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            justify-content: center;
        }
        .thumbnail-gallery img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 4px;
            cursor: pointer;
            border: 2px solid transparent;
            transition: border-color 0.2s ease, transform 0.2s ease;
        }
        .thumbnail-gallery img:hover {
            transform: scale(1.05);
        }
        .thumbnail-gallery img.active-thumb {
            border-color: #FFC107;
            box-shadow: 0 0 8px #FFC107;
        }
        .product-make-model {
            font-size: 2.2em;
            color: #ffffff;
            font-weight: 700;
            margin-top: 0;
            margin-bottom: 10px;
            line-height: 1.2;
        }
        .product-price {
            font-size: 1.8em;
            color: #FFC107;
            font-weight: 700;
            margin-bottom: 25px;
        }
        .detail-section {
            margin-bottom: 25px;
        }
        .detail-section h3 {
            font-size: 1.2em;
            color: #FFC107;
            font-weight: 700;
            margin-top: 0;
            margin-bottom: 10px;
            padding-bottom: 5px;
            border-bottom: 1px solid #555;
        }
        .detail-section p,
        .detail-section li {
            font-size: 1em;
            color: #e0e0e0;
            line-height: 1.6;
            margin-bottom: 8px;
            font-weight: 400;
        }
        .detail-section ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .detail-label {
            font-weight: 700;
            color: #cccccc;
            display: inline-block;
            min-width: 120px;
            margin-right: 10px;
        }
        .add-to-cart-section {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #555;
            display: flex;
            align-items: center;
            gap: 20px;
            flex-wrap: wrap;
        }
        .quantity-control label {
            font-size: 0.9em;
            font-weight: 700;
            margin-right: 8px;
            color: #e0e0e0;
        }
        .quantity-input {
            width: 60px;
            padding: 8px 10px;
            font-size: 1em;
            font-family: inherit;
            border-radius: 4px;
            border: 1px solid #666;
            background-color: #555;
            color: #ffffff;
            text-align: center;
        }
        .quantity-input::-webkit-outer-spin-button,
        .quantity-input::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
        .quantity-input[type=number] {
            -moz-appearance: textfield;
        }
        .btn {
            display: inline-block;
            padding: 10px 25px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-size: 1.1em;
            font-weight: 700;
            cursor: pointer;
            transition: background-color 0.2s ease, color 0.2s ease, transform 0.1s ease;
            text-align: center;
            font-family: inherit;
            white-space: nowrap;
        }
        .btn:active {
            transform: scale(0.97);
        }
        .btn-add-to-cart {
            background-color: #FFC107;
            color: #333333;
        }
        .btn-add-to-cart:hover {
            background-color: #e0a800;
        }
        .btn-add-to-cart i {
             margin-right: 8px;
        }
        .error-message-container {
            text-align: center;
            padding: 50px 20px;
        }
        .error-message-container h1 {
            font-size: 2em;
            color: #FFC107;
            margin-bottom: 20px;
        }
        .error-message-container p {
            font-size: 1.1em;
            margin-bottom: 30px;
        }
        .error-message-container .btn-browse-all {
            background-color: #4f4f4f;
            color: #ffffff;
        }
        .error-message-container .btn-browse-all:hover {
            background-color: #666;
        }
        @media (max-width: 768px) {
            .product-detail-layout {
                flex-direction: column;
                gap: 30px;
                padding: 20px;
            }
            .product-image-column {
                min-width: unset;
            }
            .product-make-model { font-size: 1.8em; }
            .product-price { font-size: 1.5em; }
        }
        @media (max-width: 480px) {
             .container { padding: 0 15px; }
             .product-make-model { font-size: 1.6em; }
             .add-to-cart-section { justify-content: center; }
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/pages/navbar.jsp">
        <jsp:param name="activePage" value="inventory"/>
    </jsp:include>

    <div class="main-content-area">
        <div class="container">

            <c:choose>
                <c:when test="${not empty guitar}">
                    <div class="product-detail-layout">
                        <div class="product-image-column">
                            <div class="main-product-image">
                                <c:set var="mainDisplayUrl" value="${guitar.getMainImageUrl()}"/>
                                <c:choose>
                                    <c:when test="${not empty mainDisplayUrl}">
                                        <img id="mainImageDisplay" src="${fn:escapeXml(mainDisplayUrl)}" alt="${fn:escapeXml(guitar.brand)} ${fn:escapeXml(guitar.model)} main image">
                                    </c:when>
                                    <c:otherwise>
                                         <c:url var="placeholderImgUrl" value="/images/guitar-deviser.jpg" />
                                         <img id="mainImageDisplay" src="${placeholderImgUrl}" alt="Placeholder Guitar Image">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <c:if test="${not empty guitar.images && fn:length(guitar.images) > 1}">
                                <div class="thumbnail-gallery">
                                    <c:forEach var="img" items="${guitar.images}" varStatus="loop">
                                        <img src="${fn:escapeXml(img.imageUrlPath)}"
                                             alt="${fn:escapeXml(guitar.brand)} ${fn:escapeXml(guitar.model)} thumbnail ${loop.count}"
                                             onclick="changeMainImage('${fn:escapeXml(img.imageUrlPath)}', this)"
                                             class="${img.mainImage ? 'active-thumb' : ''}">
                                    </c:forEach>
                                </div>
                            </c:if>
                        </div>

                        <div class="product-details-column">
                            <h1 class="product-make-model"><c:out value="${guitar.brand}"/> <c:out value="${guitar.model}"/></h1>
                            <p class="product-price">
                                <fmt:setLocale value="en_US"/>
                                <fmt:formatNumber value="${guitar.price}" type="currency" currencySymbol="$"/>
                            </p>

                            <div class="detail-section">
                                <h3>Condition</h3>
                                <p><c:out value="${guitar.conditionRating}"/></p>
                                <c:if test="${not empty guitar.conditionDetails}">
                                    <p><c:out value="${guitar.conditionDetails}"/></p>
                                </c:if>
                            </div>

                            <div class="detail-section">
                                <h3>Specifications</h3>
                                <ul>
                                    <li><span class="detail-label">Brand:</span> <c:out value="${guitar.brand}"/></li>
                                    <li><span class="detail-label">Model:</span> <c:out value="${guitar.model}"/></li>
                                    <c:if test="${not empty guitar.guitarType}">
                                        <li><span class="detail-label">Type:</span> <c:out value="${guitar.guitarType}"/></li>
                                    </c:if>
                                    <c:if test="${not empty guitar.yearProduced && guitar.yearProduced != 0}">
                                        <li><span class="detail-label">Year:</span> <c:out value="${guitar.yearProduced}"/></li>
                                    </c:if>
                                    <c:if test="${not empty guitar.serialNumber}">
                                        <li><span class="detail-label">Serial #:</span> <c:out value="${guitar.serialNumber}"/></li>
                                    </c:if>
                                    <c:if test="${not empty guitar.finishColor}">
                                        <li><span class="detail-label">Finish/Color:</span> <c:out value="${guitar.finishColor}"/></li>
                                    </c:if>
                                    <c:if test="${not empty guitar.bodyWood}">
                                        <li><span class="detail-label">Body Wood:</span> <c:out value="${guitar.bodyWood}"/></li>
                                    </c:if>
                                    <c:if test="${not empty guitar.neckWood}">
                                        <li><span class="detail-label">Neck Wood:</span> <c:out value="${guitar.neckWood}"/></li>
                                    </c:if>
                                    <c:if test="${not empty guitar.fretboardWood}">
                                        <li><span class="detail-label">Fretboard:</span> <c:out value="${guitar.fretboardWood}"/></li>
                                    </c:if>
                                    <c:if test="${not empty guitar.pickups}">
                                        <li><span class="detail-label">Pickups:</span> <c:out value="${guitar.pickups}"/></li>
                                    </c:if>
                                </ul>
                            </div>

                            <div class="add-to-cart-section">
                                <form id="addToCartForm" action="${pageContext.request.contextPath}/cart" method="post" style="display: contents;">
                                    <div class="quantity-control">
                                        <label for="quantity">Quantity:</label>
                                        <input type="number" id="quantity" name="quantity" value="1" min="1" class="quantity-input">
                                    </div>
                                     <input type="hidden" name="action" value="addToCart">
                                     <input type="hidden" name="productId" value="${guitar.id}">
                                    <button type="button" class="btn btn-add-to-cart" onclick="handleAddToCart()">
                                        <i class="fas fa-shopping-cart"></i> Add to Cart
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="error-message-container">
                        <h1>Product Not Found</h1>
                        <p><c:out value="${not empty errorMessage ? errorMessage : 'The requested guitar could not be found or is unavailable.'}"/></p>
                        <c:url var="browseAllUrl" value="/browse"/>
                        <a href="${browseAllUrl}" class="btn btn-browse-all">Browse All Guitars</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <jsp:include page="/WEB-INF/pages/footer.jsp" />

    <script>
        function changeMainImage(newImageUrl, clickedThumbnail) {
            document.getElementById('mainImageDisplay').src = newImageUrl;
            const thumbnails = document.querySelectorAll('.thumbnail-gallery img');
            thumbnails.forEach(thumb => thumb.classList.remove('active-thumb'));
            clickedThumbnail.classList.add('active-thumb');
        }

        function handleAddToCart() {
            <c:choose>
                <c:when test="${empty sessionScope.loggedInUser}">
                    var currentProductPage = window.location.href;
                    var loginUrl = "${pageContext.request.contextPath}/login?message=" +
                                   encodeURIComponent("Please login to add items to your cart.") +
                                   "&redirect=" + encodeURIComponent(currentProductPage);
                    window.location.href = loginUrl;
                </c:when>
                <c:otherwise>
                    document.getElementById('addToCartForm').submit();
                </c:otherwise>
            </c:choose>
        }


        document.addEventListener('DOMContentLoaded', function() {
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.has('action') && urlParams.get('action') === 'addToCartAfterLogin') {

                console.log("Attempting to add to cart after login...");
                document.getElementById('addToCartForm').submit();
            }
        });
    </script>
</body>
</html>