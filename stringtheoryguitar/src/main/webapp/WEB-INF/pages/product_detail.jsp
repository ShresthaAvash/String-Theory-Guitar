<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fender American Standard Stratocaster - String Theory Guitars</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        /* --- Product Detail CSS --- */
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

        /* Layout */
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

        /* Image Styles */
        .main-product-image img {
            display: block;
            width: 100%;
            max-width: 500px;
            height: auto;
            border-radius: 6px;
            background-color: #555;
            border: 1px solid #505050;
            margin: 0 auto;
        }
        .thumbnail-gallery {
            display: flex;
            gap: 10px;
            margin-top: 15px;
            justify-content: center;
        }
        .thumbnail-gallery img {
            width: 70px;
            height: 70px;
            object-fit: cover;
            border-radius: 4px;
            cursor: pointer;
            border: 2px solid transparent;
            transition: border-color 0.2s ease;
        }
        .thumbnail-gallery img:hover,
        .thumbnail-gallery img.active {
             border-color: #FFC107;
        }

        /* Details Styles */
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
        }

        /* Add to Cart Section */
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

        /* Buttons */
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
        .error-message {
            background-color: #d9534f;
            color: white;
            border: 1px solid #d43f3a;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .product-detail-layout {
                flex-direction: column;
                gap: 30px;
                padding: 20px;
            }
            .product-image-column {
                min-width: unset;
            }
            .product-make-model {
                font-size: 1.8em;
            }
            .product-price {
                font-size: 1.5em;
            }
        }
        @media (max-width: 480px) {
             .container {
                 padding: 0 15px;
             }
             .page-title { /* Not used on this page */ }
             .product-make-model {
                 font-size: 1.6em;
             }
             .add-to-cart-section {
                 justify-content: center;
             }
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/pages/navbar.jsp">
        <jsp:param name="activePage" value="inventory"/>
    </jsp:include>

    <div class="main-content-area">
        <div class="container">

            <c:if test="${not empty errorMessage}">
                <p class="message error-message"><c:out value="${errorMessage}"/></p>
            </c:if>

            <div class="product-detail-layout">

                <div class="product-image-column">
                    <div class="main-product-image">
                        <img src="${pageContext.request.contextPath}/images/guitar-deviser.jpg" alt="Fender American Standard Stratocaster">
                    </div>
                    <%-- Thumbnail Gallery Placeholder --%>
                </div>

                <div class="product-details-column">
                    <h1 class="product-make-model">Fender American Standard Stratocaster</h1>
                    <p class="product-price">$1,499.00</p>

                    <div class="detail-section">
                        <h3>Condition</h3>
                        <p>Excellent</p>
                        <p>Minor playwear, some light pick scratches on the guard. No significant dings or dents. Frets show minimal wear. Electronics function perfectly. Includes original hardshell case.</p>
                    </div>

                    <div class="detail-section">
                        <h3>Specifications</h3>
                        <ul>
                            <li><span class="detail-label">Make:</span> Fender</li>
                            <li><span class="detail-label">Model:</span> Am Std Strat</li>
                            <li><span class="detail-label">Year:</span> 2018</li>
                            <li><span class="detail-label">Serial #:</span> US18012345</li>
                            <li><span class="detail-label">Finish / Color:</span> Olympic White</li>
                            <li><span class="detail-label">Body Wood:</span> Alder</li>
                            <li><span class="detail-label">Neck Wood:</span> Maple</li>
                            <li><span class="detail-label">Fretboard:</span> Rosewood</li>
                            <li><span class="detail-label">Pickups:</span> Custom Shop Fat '50s</li>
                        </ul>
                    </div>

                    <div class="add-to-cart-section">
                        <form action="#" method="post" style="display: contents;" onsubmit="return false;">
                            <div class="quantity-control">
                                <label for="quantity">Quantity:</label>
                                <input type="number" id="quantity" name="quantity" value="1" min="1" class="quantity-input">
                            </div>
                             <input type="hidden" name="productId" value="1">
                            <button type="button" class="btn btn-add-to-cart"
                                    onclick="alert('Product added to cart (Demo)');">
                                <i class="fas fa-shopping-cart"></i> Add to Cart
                            </button>
                        </form>
                    </div>

                </div>
            </div>

        </div>
    </div>

    <jsp:include page="/WEB-INF/pages/footer.jsp" />

</body>
</html>