<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
            padding: 20px;
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
            padding: 20px 0;
            color: #aaa;
        }
        .btn-inert {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 30px;
            font-size: 1.1em;
            font-weight: bold;
            text-align: center;
            text-decoration: none;
            border-radius: 5px;
            cursor: default;
            border: none;
            background-color: #5a5a5a;
            color: #ababab;
            opacity: 0.7;
        }
        .btn-continue-shopping {
            display: inline-block;
            margin-top: 30px;
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
        .btn-buy-now-final {
            display: block;
            width: 100%;
            max-width: 300px;
            margin: 30px auto 0 auto;
            padding: 12px 30px;
            font-size: 1.1em;
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
        .btn-buy-now-final:hover {
             background-color: #45a049;
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
        .dummy-item-row {
            border: 1px dashed #555;
            padding: 15px;
            margin-top: 20px;
            text-align: left;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .dummy-item-row div:nth-child(1) {
            width:80px; height:80px; background-color:#555; border-radius:4px; display:flex; align-items:center; justify-content:center;
        }
        .dummy-item-row div:nth-child(2) {
            flex-grow:1;
        }
        .dummy-item-row h4 {
            margin:0 0 5px 0; color: #FFC107;
        }
        .dummy-item-row p {
             margin:0 0 5px 0; font-size:0.9em;
        }
        .dummy-item-row input[type="number"] {
            width:50px; padding:5px; background-color:#505050; color:#e0e0e0; border:1px solid #666; border-radius:3px;
        }
        .dummy-item-row div:nth-child(3) {
            text-align:right;
        }
        .dummy-item-row .item-total-price {
            margin:0 0 10px 0; font-weight:bold; color: #FFC107;
        }
         .cart-total-summary {
            text-align:right; margin-top:20px; padding-top:20px; border-top:1px solid #555;
        }
        .cart-total-summary h3 {
            color: #FFC107; margin-bottom: 20px;
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

            <c:if test="${not empty requestScope.cartErrorMessage}">
                 <p class="message error-message"><c:out value="${requestScope.cartErrorMessage}"/></p>
            </c:if>

            <div class="cart-content-wrapper">
                <h2>Shopping Cart</h2>

                <div class="dummy-item-row">
                    <div>
                        <i class="fas fa-guitar fa-2x" style="color:#777;"></i>
                    </div>
                    <div>
                        <h4 >Example Guitar</h4>
                        <p >Price: $1,234.56</p>
                        <label for="qty_example" style="font-size:0.9em;">Qty:</label>
                        <input type="number" id="qty_example" value="1" min="1" readonly>
                        <button type="button" class="btn-inert" style="padding: 5px 10px; font-size:0.9em; margin-left:10px;">Update</button>
                    </div>
                    <div>
                        <p class="item-total-price">$1,234.56</p>
                        <button type="button" class="btn-inert" style="padding: 5px 10px; font-size:0.9em;">Remove</button>
                    </div>
                </div>

                <div class="cart-total-summary">
                    <h3>Total: $1,234.56</h3>
                </div>

                <button type="button" class="btn-buy-now-final">Buy Now</button>
            </div>

            <div style="text-align: center; margin-top: 30px;">
                <c:url var="browseAllUrl" value="/browse"/>
                <a href="${browseAllUrl}" class="btn-continue-shopping">Continue Shopping</a>
            </div>

        </div>
    </div>

    <jsp:include page="/WEB-INF/pages/footer.jsp" />

    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function() {
            const messageElements = document.querySelectorAll('.message.error-message');
            messageElements.forEach(function(element) {
                if (element) {
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