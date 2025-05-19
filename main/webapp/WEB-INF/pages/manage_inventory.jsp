<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Inventory - String Theory Guitars</title>
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
            max-width: 1200px;
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
        .action-bar {
            background-color: #3a3a3a;
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
            justify-content: space-between;
        }
        .filter-controls {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            align-items: center;
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
            transition: background-color 0.2s ease, color 0.2s ease, transform 0.1s ease;
            text-align: center;
            font-family: inherit;
            white-space: nowrap;
        }
        .btn:active {
            transform: scale(0.97);
        }
        .btn-apply-filter {
            background-color: #4f4f4f;
            color: #ffffff;
            padding: 9px 20px;
        }
        .btn-apply-filter:hover {
            background-color: #666666;
        }
        .btn-add-new {
            background-color: #FFC107;
            color: #333333;
            padding: 9px 20px;
        }
        .btn-add-new:hover {
            background-color: #e0a800;
        }
        .inventory-table-wrapper {
            overflow-x: auto;
            background-color: #3a3a3a;
            padding: 5px;
            border-radius: 8px;
        }
        .inventory-table {
            width: 100%;
            border-collapse: collapse;
        }
        .inventory-table th,
        .inventory-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #555;
            white-space: normal;
            word-break: break-word;
            vertical-align: middle;
        }
        .inventory-table thead th {
            background-color: #484848;
            color: #FFC107;
            font-weight: 700;
            font-size: 0.85em;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            position: sticky;
            top: 0;
            z-index: 1;
            white-space: nowrap;
        }
        .inventory-table tbody tr:nth-child(even) {
            background-color: #404040;
        }
        .inventory-table tbody tr:hover {
            background-color: #4f4f4f;
        }
        .inventory-table tbody td {
            font-size: 0.95em;
            color: #e0e0e0;
            font-weight: 400;
        }
        .inventory-table .col-image {
            width: 80px;
            min-width: 80px;
            text-align: center;
        }
        .inventory-table .col-price {
            text-align: right;
            font-weight: 700;
            white-space: nowrap;
        }
        .inventory-table .col-year {
            text-align: center;
            white-space: nowrap;
        }
        .inventory-table .col-actions {
            width: 100px;
            min-width: 100px;
            text-align: center;
            white-space: nowrap;
        }
         .inventory-table .col-brand,
        .inventory-table .col-serial,
        .inventory-table .col-condition {
             white-space: nowrap;
        }
        .inventory-table .col-model {
            min-width: 200px;
        }
        .inventory-thumb {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 4px;
            vertical-align: middle;
            background-color: #555;
            border: 1px solid #666;
        }
        .action-icon {
            color: #ccc;
            text-decoration: none;
            margin: 0 8px;
            font-size: 1.1em;
            transition: color 0.2s ease, transform 0.1s ease;
            display: inline-block;
        }
        .action-icon:hover {
            transform: scale(1.15);
        }
        .action-icon.edit:hover {
            color: #FFC107;
        }
        .action-icon.delete {
            cursor: pointer;
            background: none;
            border: none;
            padding: 0;
        }
        .action-icon.delete:hover {
            color: #d9534f;
        }
        .message {
            padding: 10px 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            text-align: center;
            font-weight: 400;
            font-size: 0.95em;
            line-height: 1.4;
            opacity: 1;
            transition: opacity 0.5s ease-out;
        }
        .message.fade-out {
            opacity: 0;
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
        .no-items {
            text-align: center;
            padding: 40px 20px;
            font-size: 1.1em;
            color: #aaa;
            font-style: italic;
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/pages/navbar.jsp">
        <jsp:param name="activePage" value="admin-inventory"/>
    </jsp:include>

    <div class="main-content-area">
        <div class="container">

            <h1 class="page-title">Manage Inventory</h1>

            <c:if test="${not empty requestScope.errorMessage}"><p class="message error-message"><c:out value="${requestScope.errorMessage}"/></p></c:if>
            <c:if test="${not empty requestScope.successMessage}"><p class="message success-message"><c:out value="${requestScope.successMessage}"/></p></c:if>

            <div class="action-bar">
                <div class="filter-controls">
                    <form id="filterForm" action="${pageContext.request.contextPath}/manage-inventory" method="get" style="display: contents;">
                        <input type="search" class="filter-input" name="search" placeholder="Search inventory..." value="${fn:escapeXml(searchTerm)}">
                        <select class="filter-select" name="sort">
                            <option value="" disabled ${empty sortOrder ? 'selected' : ''}>Sort By...</option>
                            <option value="date_desc" ${sortOrder == 'date_desc' || empty sortOrder ? 'selected' : ''}>Date Added (Newest)</option>
                            <option value="date_asc" ${sortOrder == 'date_asc' ? 'selected' : ''}>Date Added (Oldest)</option>
                            <option value="price_asc" ${sortOrder == 'price_asc' ? 'selected' : ''}>Price (Low-High)</option>
                            <option value="price_desc" ${sortOrder == 'price_desc' ? 'selected' : ''}>Price (High-Low)</option>
                            <option value="make_asc" ${sortOrder == 'make_asc' ? 'selected' : ''}>Make (A-Z)</option>
                            <option value="make_desc" ${sortOrder == 'make_desc' ? 'selected' : ''}>Make (Z-A)</option>
                        </select>
                        <button type="submit" class="btn btn-apply-filter">Apply</button>
                    </form>
                </div>
                <div class="add-new-button">
                    <a href="${pageContext.request.contextPath}/add-guitar" class="btn btn-add-new">Add New Guitar</a>
                </div>
            </div>

            <div class="inventory-table-wrapper">
                <c:choose>
                    <c:when test="${not empty guitars}">
                        <table class="inventory-table">
                            <thead>
                                <tr>
                                    <th class="col-image">Image</th>
                                    <th class="col-brand">Brand</th>
                                    <th class="col-model">Model</th>
                                    <th class="col-year">Year</th>
                                    <th class="col-serial">Serial #</th>
                                    <th class="col-condition">Condition</th>
                                    <th class="col-price">Price</th>
                                    <th class="col-actions">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="guitar" items="${guitars}">
                                    <tr>
                                        <td class="col-image">
                                            <c:set var="displayImageUrl" value="${guitar.getMainImageUrl()}"/>
                                            <c:choose>
                                                <c:when test="${not empty displayImageUrl}">
                                                    <img src="${fn:escapeXml(displayImageUrl)}"
                                                         alt="${fn:escapeXml(guitar.brand)} ${fn:escapeXml(guitar.model)} Thumbnail" class="inventory-thumb">
                                                </c:when>
                                                <c:otherwise>
                                                    <c:url var="placeholderUrl" value="/images/guitar-deviser.jpg" />
                                                    <img src="${placeholderUrl}"
                                                         alt="Placeholder Thumbnail" class="inventory-thumb">
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="col-brand"><c:out value="${guitar.brand}"/></td>
                                        <td class="col-model"><c:out value="${guitar.model}"/></td>
                                        <td class="col-year"><c:out value="${guitar.yearProduced != null && guitar.yearProduced != 0 ? guitar.yearProduced : 'N/A'}"/></td>
                                        <td class="col-serial"><c:out value="${guitar.serialNumber}"/></td>
                                        <td class="col-condition"><c:out value="${guitar.conditionRating}"/></td>
                                        <td class="col-price">
                                            <fmt:setLocale value="en_US"/>
                                            <fmt:formatNumber value="${guitar.price}" type="currency" currencySymbol="$"/>
                                        </td>
                                        <td class="col-actions">
                                            <a href="${pageContext.request.contextPath}/edit-guitar?id=${guitar.id}" title="Edit ${fn:escapeXml(guitar.brand)} ${fn:escapeXml(guitar.model)}" class="action-icon edit"><i class="fas fa-pencil"></i></a>
                                            <form action="${pageContext.request.contextPath}/manage-inventory" method="post" style="display: inline;" onsubmit="return confirm('Are you sure you want to delete ${fn:escapeXml(guitar.brand)} ${fn:escapeXml(guitar.model)}?');">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="guitarId" value="${guitar.id}">
                                                <button type="submit" title="Delete ${fn:escapeXml(guitar.brand)} ${fn:escapeXml(guitar.model)}" class="action-icon delete"><i class="fas fa-trash-can"></i></button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <p class="no-items">
                             <c:choose>
                                <c:when test="${not empty searchTerm}">
                                    No guitars found matching your search term: "<strong><c:out value="${searchTerm}"/></strong>".
                                </c:when>
                                <c:otherwise>
                                    No guitars currently in inventory.
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/pages/footer.jsp" />

    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function() {
            const messageElements = document.querySelectorAll('.message.success-message, .message.error-message');
            messageElements.forEach(function(element) {
                if (element) {
                    setTimeout(function() {
                        element.classList.add('fade-out');
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