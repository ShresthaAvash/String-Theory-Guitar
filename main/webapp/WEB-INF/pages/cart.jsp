<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Shopping Cart - String Theory Guitars</title>
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
            max-width: 900px;
            margin: 40px auto;
            padding: 0 20px;
            box-sizing: border-box;
        }
        .page-title {
            font-size: 2.5em;
            color: #FFC107;
            font-weight: 700;
            text-align: center;
            margin-top: 0;
            margin-bottom: 30px;
        }
        .cart-content-wrapper {
            background-color: #3a3a3a;
            padding: 25px;
            border-radius: 8px;
            margin-bottom: 30px;
            color: #e0e0e0;
        }
        .cart-content-wrapper h2 {
            color: #FFC107;
            margin-top: 0;
            text-align: center;
            margin-bottom: 25px;
        }
        .cart-empty-info {
            font-size: 1.2em;
            line-height: 1.6;
            text-align: center;
            padding: 30px 0;
            color: #aaa;
        }
        .btn-continue-shopping {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 30px;
            font-size: 1.1em;
            font-weight: bold;
            text-align: center;
            text-decoration: none;
            border-radius: 5px;
            cursor: pointer;
            border: none;
            background-color: #FFC107;
            color: #333;
            transition: background-color 0.2s ease;
        }
        .btn-continue-shopping:hover {
            background-color: #e0a800;
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
        .success-message {
            background-color: #5cb85c;
            color: white;
            border: 1px solid #4cae4c;
        }
        .cart-item-row {
            border: 1px solid #555;
            padding: 20px;
            margin-top: 20px;
            display: flex;
            align-items: center;
            gap: 20px;
            border-radius: 6px;
            background-color: #404040;
        }
        .cart-item-image {
            width: 100px;
            height: 100px;
            background-color:#555;
            border-radius:4px;
            display:flex;
            align-items:center;
            justify-content:center;
            overflow: hidden;
        }
        .cart-item-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .cart-item-details {
            flex-grow:1;
        }
        .cart-item-details h3 {
            margin:0 0 8px 0;
            color: #FFC107;
            font-size: 1.2em;
        }
        .cart-item-details p {
            margin:0 0 5px 0;
            font-size:0.9em;
            color: #ccc;
        }
        .cart-item-quantity input[type="number"] {
            width:60px;
            padding:8px;
            background-color:#505050;
            color:#e0e0e0;
            border:1px solid #666;
            border-radius:3px;
            text-align: center;
            margin-right: 10px;
        }
        .cart-item-quantity button {
            padding: 8px 12px;
            font-size:0.9em;
            background-color: #666;
            border:none;
            color:white;
            border-radius:3px;
            cursor:pointer;
        }
        .cart-item-quantity button:hover {
            background-color: #777;
        }
        .cart-item-price-actions {
            text-align:right;
            min-width: 150px;
        }
        .item-total-price {
            margin:0 0 10px 0;
            font-weight:bold;
            color: #FFC107;
            font-size: 1.2em;
        }
        .btn-remove-item {
            padding: 8px 12px;
            font-size:0.9em;
            background-color: #d9534f;
            color:white;
            border:none;
            border-radius:3px;
            cursor:pointer;
        }
        .btn-remove-item:hover {
            background-color: #c9302c;
        }
        .cart-summary {
            text-align:right;
            margin-top:30px;
            padding-top:20px;
            border-top:1px solid #555;
        }
        .cart-summary h3 {
            color: #FFC107;
            margin-bottom: 20px;
            font-size: 1.5em;
        }
        .btn-buy-now {
            display: block;
            width: 100%;
            max-width: 300px;
            margin: 30px auto 0 auto;
            padding: 12px 30px;
            font-size: 1.2em;
            font-weight: bold;
            text-align: center;
            text-decoration: none;
            border-radius: 5px;
            cursor: pointer;
            border: none;
            background-color: #4CAF50;
            color: white;
            transition: background-color 0.2s ease;
        }
        .btn-buy-now:hover {
            background-color: #45a049;
        }
        .btn-buy-now:disabled {
            background-color: #5a5a5a;
            color: #ababab;
            cursor: not-allowed;
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/pages/navbar.jsp">
        <jsp:param name="activePage" value="cart"/>
    </jsp:include>

    <div class="main-content-area">
        <div class="container">
            <h1 class="page-title">Your Shopping Cart</h1>

            <c:if test="${not empty cartErrorMessage}">
                 <p class="message error-message"><c:out value="${cartErrorMessage}"/></p>
            </c:if>
            <c:if test="${not empty cartSuccessMessage}">
                 <p class="message success-message"><c:out value="${cartSuccessMessage}"/></p>
            </c:if>
            <c:if test="${not empty purchaseMessage}">
                 <p class="message success-message"><c:out value="${purchaseMessage}"/></p>
                 <c:remove var="purchaseMessage" scope="session"/>
            </c:if>


            <div class="cart-content-wrapper">
                <h2>Shopping Cart</h2>
                <c:choose>
                    <c:when test="${not empty cartItem}">
                        <div class="cart-item-row">
                            <div class="cart-item-image">
                                <c:set var="displayImageUrl" value="${cartItem.getMainImageUrl()}"/>
                                <c:choose>
                                    <c:when test="${not empty displayImageUrl}">
                                        <img src="${fn:escapeXml(displayImageUrl)}" alt="${fn:escapeXml(cartItem.brand)} ${fn:escapeXml(cartItem.model)}">
                                    </c:when>
                                    <c:otherwise>
                                        <c:url var="placeholderUrl" value="/images/guitar-deviser.jpg" />
                                        <img src="${placeholderUrl}" alt="Placeholder Guitar Image">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="cart-item-details">
                                <h3><c:out value="${cartItem.brand}"/> <c:out value="${cartItem.model}"/></h3>
                                <p>Price: <fmt:formatNumber value="${cartItem.price}" type="currency" currencySymbol="$"/></p>
                                <p>Serial: <c:out value="${cartItem.serialNumber}"/></p>
                            </div>
                            <div class="cart-item-quantity">
                                <form action="${pageContext.request.contextPath}/cart" method="post" style="display:inline;">
                                    <input type="hidden" name="action" value="updateQuantity">
                                    <input type="number" name="quantity" value="${cartItemQuantity}" min="0">
                                    <button type="submit">Update</button>
                                </form>
                            </div>
                            <div class="cart-item-price-actions">
                                <fmt:formatNumber var="itemTotalPrice" value="${cartItem.price * cartItemQuantity}" type="currency" currencySymbol="$"/>
                                <p class="item-total-price">${itemTotalPrice}</p>
                                <form action="${pageContext.request.contextPath}/cart" method="post" style="display:inline;">
                                    <input type="hidden" name="action" value="remove">
                                    <button type="submit" class="btn-remove-item"><i class="fas fa-trash-alt"></i> Remove</button>
                                </form>
                            </div>
                        </div>

                        <div class="cart-summary">
                            <h3>Total: ${itemTotalPrice}</h3>
                            <form id="buyNowForm" action="${pageContext.request.contextPath}/cart" method="post" style="display: contents;">
                                <input type="hidden" name="action" value="buyNow">
                                <button type="submit" class="btn-buy-now" id="buyNowButton">Place Order</button>
                            </form>
                        </div>

                    </c:when>
                    <c:otherwise>
                        <p class="cart-empty-info">Your cart is empty. Find something awesome!</p>
                    </c:otherwise>
                </c:choose>
            </div>

            <div style="text-align: center;">
                <c:url var="browseAllUrl" value="/browse"/>
                <a href="${browseAllUrl}" class="btn-continue-shopping">Continue Shopping</a>
            </div>

        </div>
    </div>

    <jsp:include page="/WEB-INF/pages/footer.jsp" />

    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function() {
            const messageElements = document.querySelectorAll('.message.success-message, .message.error-message');
            messageElements.forEach(function(element) {
                if (element && !element.textContent.includes("order has been placed")) {
                    setTimeout(function() {
                        element.style.transition = 'opacity 0.5s ease-out';
                        element.style.opacity = '0';
                        setTimeout(function() {
                            element.style.display = 'none';
                        }, 500);
                    }, 3500);
                }
            });
        });
    </script>

</body>
</html>