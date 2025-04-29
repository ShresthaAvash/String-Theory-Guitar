<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Inventory - String Theory Guitars</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        /* --- Manage Inventory CSS --- */
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

        /* Filter/Action Bar */
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

        /* Buttons */
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

        /* Inventory Table */
        .inventory-table-wrapper {
            overflow-x: auto;
            background-color: #3a3a3a;
            padding: 5px;
            border-radius: 8px;
        }
        .inventory-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 800px;
        }
        .inventory-table th,
        .inventory-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #555;
            white-space: nowrap;
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
            vertical-align: middle;
        }
        .inventory-table .col-image {
            width: 80px;
            text-align: center;
        }
        .inventory-table .col-price {
            text-align: right;
            font-weight: 700;
        }
        .inventory-table .col-year {
            text-align: center;
        }
        .inventory-table .col-actions {
            width: 100px;
            text-align: center;
            white-space: nowrap;
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
        }
        .action-icon.delete:hover {
            color: #d9534f;
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
            <c:if test="${param.add == 'simulated'}"><p class="message success-message">Demo: Guitar 'added' successfully!</p></c:if>
            <c:if test="${param.edit == 'simulated'}"><p class="message success-message">Demo: Guitar 'updated' successfully!</p></c:if>
            <c:if test="${param.delete == 'simulated'}"><p class="message success-message">Demo: Guitar 'deleted' successfully!</p></c:if>
            <c:if test="${param.delete == 'error'}"><p class="message error-message">Demo: Error 'deleting' guitar. ${param.msg}</p></c:if>
            <c:if test="${param.error == 'notfound'}"><p class="message error-message">Demo: Could not find specified guitar.</p></c:if>

            <div class="action-bar">
                <div class="filter-controls">
                    <form id="filterForm" action="${pageContext.request.contextPath}/manage-inventory" method="get" style="display: contents;">
                        <input type="search" class="filter-input" name="search" placeholder="Search inventory..." value="<c:out value='${param.search}'/>">
                        <select class="filter-select" name="sort">
                            <option value="" disabled selected>Sort By...</option>
                            <option value="date_desc">Date Added (Newest)</option>
                            <option value="date_asc">Date Added (Oldest)</option>
                            <option value="price_asc">Price (Low-High)</option>
                            <option value="price_desc">Price (High-Low)</option>
                            <option value="make_asc">Make (A-Z)</option>
                            <option value="make_desc">Make (Z-A)</option>
                        </select>
                        <button type="submit" class="btn btn-apply-filter">Apply</button>
                    </form>
                </div>
                <div class="add-new-button">
                    <a href="${pageContext.request.contextPath}/add-guitar" class="btn btn-add-new">Add New Guitar</a>
                </div>
            </div>

            <div class="inventory-table-wrapper">
                <table class="inventory-table">
                    <thead>
                        <tr>
                            <th class="col-image">Image</th>
                            <th>Make</th>
                            <th>Model</th>
                            <th class="col-year">Year</th>
                            <th>Serial #</th>
                            <th>Condition</th>
                            <th class="col-price">Price</th>
                            <th class="col-actions">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%-- STATIC PLACEHOLDER ROWS --%>
                        <tr>
                            <td class="col-image"><img src="${pageContext.request.contextPath}/images/guitar deviser.jpg" alt="Fender Thumbnail" class="inventory-thumb"></td>
                            <td>Fender</td><td>Am Std Strat</td><td class="col-year">2018</td><td>US18012345</td><td>Excellent</td><td class="col-price">$1,499.00</td>
                            <td class="col-actions">
                                <a href="${pageContext.request.contextPath}/edit-guitar?id=1" title="Edit Fender Am Std Strat" class="action-icon edit"><i class="fas fa-pencil"></i></a>
                                <a href="#" title="Delete Fender Am Std Strat (Disabled)" class="action-icon delete" onclick="confirm('DEMO: Are you sure you want to delete Fender Am Std Strat? (Action disabled)'); return false;"><i class="fas fa-trash-can"></i></a>
                            </td>
                        </tr>
                        <tr>
                            <td class="col-image"><img src="${pageContext.request.contextPath}/images/guitar deviser.jpg" alt="Gibson Thumbnail" class="inventory-thumb"></td>
                            <td>Gibson</td><td>Les Paul Std '50s</td><td class="col-year">2022</td><td>202212345</td><td>Mint</td><td class="col-price">$2,799.00</td>
                            <td class="col-actions">
                                <a href="${pageContext.request.contextPath}/edit-guitar?id=2" title="Edit Gibson Les Paul Std '50s" class="action-icon edit"><i class="fas fa-pencil"></i></a>
                                <a href="#" title="Delete Gibson Les Paul Std '50s (Disabled)" class="action-icon delete" onclick="confirm('DEMO: Are you sure you want to delete Gibson Les Paul Std \'50s? (Action disabled)'); return false;"><i class="fas fa-trash-can"></i></a>
                            </td>
                        </tr>
                        <tr>
                             <td class="col-image"><img src="${pageContext.request.contextPath}/images/guitar deviser.jpg" alt="PRS Thumbnail" class="inventory-thumb"></td>
                             <td>PRS</td><td>Custom 24</td><td class="col-year">2021</td><td>21C24111</td><td>New</td><td class="col-price">$3,200.00</td>
                             <td class="col-actions">
                                 <a href="${pageContext.request.contextPath}/edit-guitar?id=3" title="Edit PRS Custom 24" class="action-icon edit"><i class="fas fa-pencil"></i></a>
                                 <a href="#" title="Delete PRS Custom 24 (Disabled)" class="action-icon delete" onclick="confirm('DEMO: Are you sure you want to delete PRS Custom 24? (Action disabled)'); return false;"><i class="fas fa-trash-can"></i></a>
                             </td>
                        </tr>
                        <tr>
                            <td class="col-image"><img src="${pageContext.request.contextPath}/images/guitar deviser.jpg" alt="Ibanez Thumbnail" class="inventory-thumb"></td>
                            <td>Ibanez</td><td>RG550</td><td class="col-year">1991</td><td>F123456</td><td>Very Good</td><td class="col-price">$999.00</td>
                            <td class="col-actions">
                                <a href="${pageContext.request.contextPath}/edit-guitar?id=4" title="Edit Ibanez RG550" class="action-icon edit"><i class="fas fa-pencil"></i></a>
                                <a href="#" title="Delete Ibanez RG550 (Disabled)" class="action-icon delete" onclick="confirm('DEMO: Are you sure you want to delete Ibanez RG550? (Action disabled)'); return false;"><i class="fas fa-trash-can"></i></a>
                            </td>
                        </tr>
                        <tr>
                            <td class="col-image"><img src="${pageContext.request.contextPath}/images/guitar deviser.jpg" alt="Martin Thumbnail" class="inventory-thumb"></td>
                            <td>Martin</td><td>D-28</td><td class="col-year">2015</td><td>M15D28001</td><td>Excellent</td><td class="col-price">$3,500.00</td>
                            <td class="col-actions">
                                <a href="${pageContext.request.contextPath}/edit-guitar?id=5" title="Edit Martin D-28" class="action-icon edit"><i class="fas fa-pencil"></i></a>
                                <a href="#" title="Delete Martin D-28 (Disabled)" class="action-icon delete" onclick="confirm('DEMO: Are you sure you want to delete Martin D-28? (Action disabled)'); return false;"><i class="fas fa-trash-can"></i></a>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/pages/footer.jsp" />

</body>
</html>