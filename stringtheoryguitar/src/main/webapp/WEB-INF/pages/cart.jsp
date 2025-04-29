<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- Security Check Removed/Commented for static demo --%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart - String Theory Guitars</title>
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
            max-width: 950px;
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
            margin-bottom: 40px;
        }

        /* Cart Table */
        .cart-table-wrapper {
            background-color: #3a3a3a;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 30px;
            overflow-x: auto;
        }

        .cart-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 600px;
        }

        .cart-table th,
        .cart-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #555;
        }

        .cart-table thead th {
            background-color: #484848;
            color: #FFC107;
            font-weight: 700;
            font-size: 0.9em;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            position: sticky;
            top: 0;
            z-index: 1;
        }

        .cart-table tbody td {
            font-size: 1em;
            color: #e0e0e0;
            font-weight: 400;
            vertical-align: middle;
        }

        .col-product {
            width: 50%;
        }
        .col-price,
        .col-quantity,
        .col-subtotal {
            width: 15%;
            text-align: right;
        }
        .col-remove {
            width: 5%;
            text-align: center;
        }

        .product-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .product-thumb {
            width: 65px;
            height: 65px;
            object-fit: cover;
            border-radius: 4px;
            background-color: #555;
            border: 1px solid #666;
        }
        .product-name {
            color: #ffffff;
            font-weight: 700;
            display: block;
            margin-bottom: 3px;
        }
        .product-desc {
            font-size: 0.85em;
            color: #bbb;
        }

        .quantity-display {
            font-weight: 700;
        }

        .remove-item-btn {
            color: #ccc;
            text-decoration: none;
            font-size: 1.2em;
            transition: color 0.2s ease, transform 0.1s ease;
            display: inline-block;
        }
        .remove-item-btn:hover {
            color: #d9534f;
            transform: scale(1.1);
        }

        /* Cart Summary */
        .cart-summary {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #555;
            max-width: 350px;
            margin-left: auto; /* Align to the right */
            text-align: right;
        }
        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 1.1em;
        }
        .summary-row span:first-child {
            color: #cccccc;
            font-weight: 400;
        }
        .summary-row span:last-child {
            font-weight: 700;
        }
        .summary-total {
            font-size: 1.3em;
            color: #FFC107;
            font-weight: 700;
        }

        /* Cart Actions */
        .cart-actions {
            margin-top: 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }
        .btn { /* General button style */
            display: inline-block;
            padding: 10px 25px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-size: 1.0em;
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
        .btn-continue {
            background-color: #6c757d;
            color: #ffffff;
        }
        .btn-continue:hover {
            background-color: #5a6268;
        }
        .btn-buy-now {
            background-color: #FFC107;
            color: #333333;
        }
        .btn-buy-now:hover {
            background-color: #e0a800;
        }

        /* Messages */
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

        /* Responsive */
        @media (max-width: 768px) {
            .page-title { font-size: 2em; }
            .cart-table thead { display: none; }
            .cart-table,
            .cart-table tbody,
            .cart-table tr,
            .cart-table td {
                display: block;
                width: 100%;
            }
            .cart-table tr {
                margin-bottom: 15px;
                border-bottom: 2px solid #555;
                padding-bottom: 10px;
            }
            .cart-table td {
                text-align: right;
                padding-left: 40%;
                position: relative;
                border-bottom: 1px dotted #666;
            }
            .cart-table td:last-child {
                border-bottom: 0;
            }
            .cart-table td::before {
                content: attr(data-label);
                position: absolute;
                left: 10px;
                width: 35%;
                padding-right: 10px;
                white-space: nowrap;
                text-align: left;
                font-weight: 700;
                color: #FFC107;
            }
            .col-product {
                padding-left: 10px !important;
                text-align: left !important;
            }
            .col-product::before {
                 display: none;
            }
            .product-info {
                 justify-content: flex-start;
            }
            .cart-summary {
                 max-width: none;
                 margin-left: 0;
            }
            .cart-actions {
                justify-content: center;
            }
        }
        @media (max-width: 480px) {
             .container { padding: 0 15px; }
             .page-title { font-size: 1.8em; }
             .cart-actions {
                flex-direction: column;
                align-items: stretch;
            }
             .cart-actions .btn {
                 width: 100%;
                 box-sizing: border-box;
            }
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

            <c:if test="${not empty successMessage || param.added == 'true'}">
                <p class="message success-message">Item 'added' to cart (Demo).</p>
            </c:if>

            <div class="cart-table-wrapper">
                <table class="cart-table">
                    <thead>
                        <tr>
                            <th class="col-product">Product</th>
                            <th class="col-price">Price</th>
                            <th class="col-quantity">Quantity</th>
                            <th class="col-subtotal">Subtotal</th>
                            <th class="col-remove"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%-- Static Placeholder Cart Items --%>
                        <tr>
                            <td data-label="Product" class="col-product">
                                <div class="product-info">
                                    <img src="${pageContext.request.contextPath}/images/guitardeviser.jpg" alt="Fender Strat" class="product-thumb">
                                    <div>
                                        <span class="product-name">Fender American Standard Stratocaster</span>
                                        <span class="product-desc">Excellent Condition, Olympic White</span>
                                    </div>
                                </div>
                            </td>
                            <td data-label="Price" class="col-price">$1,499.00</td>
                            <td data-label="Quantity" class="col-quantity">
                                <span class="quantity-display">1</span>
                            </td>
                            <td data-label="Subtotal" class="col-subtotal">$1,499.00</td>
                            <td data-label="Remove" class="col-remove">
                                <a href="#" class="remove-item-btn" title="Remove Item (Disabled)" onclick="alert('DEMO: Remove item functionality not implemented.'); return false;">
                                    <i class="fas fa-times-circle"></i>
                                </a>
                            </td>
                        </tr>
                         <tr>
                            <td data-label="Product" class="col-product">
                                <div class="product-info">
                                    <img src="${pageContext.request.contextPath}/images/guitardeviser.jpg" alt="Gibson LP" class="product-thumb">
                                    <div>
                                        <span class="product-name">Gibson Les Paul Standard '50s</span>
                                        <span class="product-desc">Mint Condition, Tobacco Burst</span>
                                    </div>
                                </div>
                            </td>
                            <td data-label="Price" class="col-price">$2,799.00</td>
                            <td data-label="Quantity" class="col-quantity">
                                <span class="quantity-display">1</span>
                            </td>
                            <td data-label="Subtotal" class="col-subtotal">$2,799.00</td>
                            <td data-label="Remove" class="col-remove">
                                <a href="#" class="remove-item-btn" title="Remove Item (Disabled)" onclick="alert('DEMO: Remove item functionality not implemented.'); return false;">
                                    <i class="fas fa-times-circle"></i>
                                </a>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="cart-summary">
                <div class="summary-row"><span>Subtotal:</span><span>$4,298.00</span></div>
                <div class="summary-row"><span>Shipping:</span><span>Calculated at checkout</span></div>
                <div class="summary-row summary-total"><span>Total:</span><span>$4,298.00</span></div>
            </div>

            <div class="cart-actions">
                <a href="${pageContext.request.contextPath}/browse" class="btn btn-continue">
                    <i class="fas fa-arrow-left"></i> Continue Shopping
                </a>
                <button type="button" class="btn btn-buy-now" onclick="alert('DEMO: Checkout functionality not implemented.');">
                    Buy Now <i class="fas fa-credit-card"></i>
                </button>
            </div>

        </div>
    </div>

    <jsp:include page="/WEB-INF/pages/footer.jsp" />

</body>
</html>