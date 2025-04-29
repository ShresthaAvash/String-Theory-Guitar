<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

        /* Welcome */
        .welcome-section {
            margin-bottom: 50px;
        }
        .welcome-title {
            font-size: 2.8em;
            color: #FFC107;
            font-weight: 700;
            text-align: center;
            margin-top: 0;
            margin-bottom: 15px;
            text-shadow: none;
        }
        .welcome-subtitle {
            font-size: 1.1em;
            color: #cccccc;
            text-align: left;
            margin-top: 0;
            margin-bottom: 35px;
            font-weight: 400;
        }

        /* Featured Guitars */
        .featured-section {
            margin-bottom: 50px;
        }
        .featured-heading {
            font-size: 1.8em;
            color: #ffffff;
            font-weight: 700;
            text-align: left;
            margin-top: 0;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #555;
        }
        .featured-grid {
            display: flex;
            gap: 30px;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 30px;
        }

        /* Product Card */
        .product-card {
            background-color: #444444;
            border-radius: 8px;
            overflow: hidden;
            width: 100%;
            max-width: 300px;
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
            background-color: #555555; /* Fallback */
            display: flex;
            align-items: center;
            justify-content: center;
            transition: transform 0.3s ease-in-out;
            overflow: hidden;
        }
        .product-card .card-image img {
            display: block;
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 0;
        }
        .product-card:hover .card-image {
            /* Optional zoom: transform: scale(1.05); */
        }
        .product-card .card-content {
            padding: 18px;
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

        /* Buttons */
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
            transition: background-color 0.2s ease, color 0.2s ease, transform 0.2s ease;
            width: auto; /* Let button size naturally */
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
        .btn-browse:active {
            transform: scale(0.97);
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .container { max-width: 95%; }
            .product-card { max-width: 30%; }
        }
        @media (max-width: 768px) {
            .product-card { max-width: 45%; }
            .welcome-title { font-size: 2.2em; }
            .welcome-subtitle { text-align: center; }
            .featured-heading { font-size: 1.6em; text-align: center; }
            .featured-grid { gap: 20px; }
        }
        @media (max-width: 540px) {
            .product-card { max-width: 80%; margin-left: auto; margin-right: auto; }
            .welcome-title { font-size: 1.8em; }
            .welcome-subtitle { font-size: 1em; }
            .featured-heading { font-size: 1.4em; }
            .btn { font-size: 0.95em; }
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
                    <%-- Static Cards with updated links and images --%>
                    <div class="product-card">
                        <div class="card-image"><img src="${pageContext.request.contextPath}/images/guitardeviser.jpg" alt="Gibson Thumbnail"></div>
                        <div class="card-content"><h3>Gibson Custom Shop '59 Les Paul Reissue</h3><p class="price">$6,499.00</p><p class="condition">Condition: Mint (New Arrival)</p><a href="${pageContext.request.contextPath}/product?id=1" class="btn btn-details">View Details</a></div>
                    </div>
                    <div class="product-card">
                        <div class="card-image"><img src="${pageContext.request.contextPath}/images/guitardeviser.jpg" alt="Fender Thumbnail"></div>
                        <div class="card-content"><h3>Fender Custom Shop Masterbuilt Strat</h3><p class="price">$5,800.00</p><p class="condition">Condition: Excellent (Staff Pick)</p><a href="${pageContext.request.contextPath}/product?id=2" class="btn btn-details">View Details</a></div>
                    </div>
                    <div class="product-card">
                        <div class="card-image"><img src="${pageContext.request.contextPath}/images/guitardeviser.jpg" alt="Taylor Thumbnail"></div>
                        <div class="card-content"><h3>Taylor 814ce Acoustic</h3><p class="price">$3,999.00</p><p class="condition">Condition: New</p><a href="${pageContext.request.contextPath}/product?id=3" class="btn btn-details">View Details</a></div>
                    </div>
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