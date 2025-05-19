<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<c:set var="currentUser" value="${sessionScope.loggedInUser}" />
<c:if test="${empty currentUser || currentUser.role != 'admin'}">
    <c:redirect url="${pageContext.request.contextPath}/login?error=auth" />
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - String Theory Guitars</title>
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
        .dashboard-header {
             margin-bottom: 40px;
        }
        .dashboard-title {
            font-size: 2.8em;
            color: #FFC107;
            font-weight: 700;
            text-align: center;
            margin-bottom: 10px;
        }
        .dashboard-subtitle {
             font-size: 1em;
             color: #cccccc;
             text-align: center;
             margin-left: 0;
             margin-top: 0;
             font-weight: 400;
        }
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }
        .dash-box {
            background-color: #444444;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.15);
            display: flex;
            flex-direction: column;
            transition: transform 0.25s ease-out, box-shadow 0.25s ease-out, min-height 0.3s ease-out;
            min-height: 170px;
            overflow: hidden; 
        }
        .dash-box:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.25);
        }
        .dash-box-title {
            font-size: 1.05em;
            color: #FFC107;
            font-weight: 700;
            margin-top: 0;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #555;
            line-height: 1.3;
        }
        .stat-content {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            overflow: hidden;
        }
        .stat-number {
            font-size: 2.6em;
            color: #FFC107;
            font-weight: 700;
            line-height: 1.1;
            margin: 0;
            padding: 0;
            text-align: left;
            width: 100%;
            word-break: break-all;
        }
        .estimated-value-box .stat-number { 
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            transition: font-size 0.2s ease-out;
        }
        .estimated-value-box:hover .stat-number {
            white-space: normal; 
            overflow: visible;
            text-overflow: clip;
            font-size: 2.2em; 
            word-break: normal; 
        }

        .stat-label {
            font-size: 0.9em;
            color: #cccccc;
            font-weight: 400;
            margin-top: 8px;
            line-height: 1.2;
            text-align: left;
        }

        .recently-added-box {
            position: relative;
        }
        .recently-added-content {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            overflow: hidden;
        }
        .recently-added-list {
            list-style: none;
            padding: 0;
            margin: 0;
            transition: max-height 0.4s ease-in-out;
            overflow: hidden;
        }
        .recently-added-list li {
            color: #e0e0e0;
            padding: 6px 0;
            font-size: 0.9em;
            border-bottom: 1px dotted #666;
            font-weight: 400;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            opacity: 0;
            transform: translateY(10px);
            transition: opacity 0.3s ease-out, transform 0.3s ease-out;
        }
        .recently-added-list li:last-child {
             border-bottom: none;
        }
        .recently-added-list.collapsed li:nth-child(-n+3) {
            opacity: 1;
            transform: translateY(0);
        }
        .recently-added-box:hover .recently-added-list.collapsed li:nth-child(-n+10) {
             opacity: 1;
             transform: translateY(0);
        }
        .recently-added-box:hover .recently-added-list.collapsed li:nth-child(4) { transition-delay: 0.05s; }
        .recently-added-box:hover .recently-added-list.collapsed li:nth-child(5) { transition-delay: 0.1s; }
        .recently-added-box:hover .recently-added-list.collapsed li:nth-child(6) { transition-delay: 0.15s; }
        .recently-added-box:hover .recently-added-list.collapsed li:nth-child(7) { transition-delay: 0.2s; }
        .recently-added-box:hover .recently-added-list.collapsed li:nth-child(8) { transition-delay: 0.25s; }
        .recently-added-box:hover .recently-added-list.collapsed li:nth-child(9) { transition-delay: 0.3s; }
        .recently-added-box:hover .recently-added-list.collapsed li:nth-child(10) { transition-delay: 0.35s; }


        .dash-box-actions {
            margin-top: auto;
            padding-top: 10px;
        }
        .btn {
            display: block;
            width: 100%;
            box-sizing: border-box;
            padding: 9px 15px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-size: 0.95em;
            font-weight: 700;
            cursor: pointer;
            text-align: center;
            transition: background-color 0.2s ease, color 0.2s ease, transform 0.1s ease;
            margin-top: 8px;
            font-family: inherit;
        }
        .btn:first-child {
             margin-top: 0;
        }
        .btn:active {
             transform: scale(0.97);
        }
        .btn-primary {
            background-color: #FFC107;
            color: #333333;
        }
        .btn-primary:hover {
            background-color: #e0a800;
        }
        .btn-secondary {
            background-color: #5a5a5a;
            color: #e0e0e0;
        }
        .btn-secondary:hover {
            background-color: #686868;
        }
        .btn-view-all {
            background-color: #5a5a5a;
            color: #e0e0e0;
            padding: 7px 12px;
            font-size: 0.85em;
            font-weight: 700;
            width: auto;
            align-self: flex-start;
            display: inline-block;
        }
        .btn-view-all:hover {
            background-color: #686868;
        }
        @media (max-width: 1024px) {
             .container { max-width: 95%; }
             .dashboard-grid { grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); }
             .stat-number { font-size: 2.4em; }
             .estimated-value-box:hover .stat-number { font-size: 2.0em; }
        }
        @media (max-width: 768px) {
            .dashboard-title { font-size: 2.2em; }
            .dashboard-grid { grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); }
            .dash-box { padding: 20px; min-height: 160px; }
            .stat-number { font-size: 2.2em; }
            .estimated-value-box:hover .stat-number { font-size: 1.8em; }
        }
        @media (max-width: 540px) {
            .dashboard-grid { grid-template-columns: 1fr; }
            .container { padding: 0 15px; }
            .dashboard-title { font-size: 1.8em; }
            .stat-number { font-size: 2em; }
            .estimated-value-box:hover .stat-number { font-size: 1.6em; }
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/pages/navbar.jsp">
        <jsp:param name="activePage" value="dashboard"/>
    </jsp:include>

    <div class="main-content-area">
        <div class="container">
            <div class="dashboard-header">
                <h1 class="dashboard-title">Admin Dashboard</h1>
                <p class="dashboard-subtitle">Overview of your inventory and activities.</p>
            </div>

            <div class="dashboard-grid">
                <div class="dash-box">
                    <h3 class="dash-box-title">Total Inventory</h3>
                    <div class="stat-content">
                        <p class="stat-number">
                            <c:out value="${totalInventoryCount != null ? totalInventoryCount : 0}"/>
                        </p>
                        <p class="stat-label">Guitars currently in stock</p>
                    </div>
                </div>

                <div class="dash-box estimated-value-box">
                    <h3 class="dash-box-title">Estimated Value</h3>
                    <div class="stat-content">
                         <p class="stat-number">
                             <fmt:setLocale value="en_US"/>
                             <c:choose>
                                 <c:when test="${not empty estimatedInventoryValue}">
                                     <fmt:formatNumber value="${estimatedInventoryValue}" type="currency" currencySymbol="$" groupingUsed="true"/>
                                 </c:when>
                                 <c:otherwise>
                                     $0.00
                                 </c:otherwise>
                             </c:choose>
                         </p>
                         <p class="stat-label">Total estimated inventory value</p>
                    </div>
                </div>

                <div class="dash-box">
                    <h3 class="dash-box-title">Total Customers</h3>
                    <div class="stat-content">
                        <p class="stat-number">
                            <c:out value="${totalCustomerCount != null ? totalCustomerCount : 0}"/>
                        </p>
                        <p class="stat-label">Registered customers</p>
                    </div>
                </div>

                <div class="dash-box recently-added-box" id="recentlyAddedBox">
                    <h3 class="dash-box-title">Recently Added</h3>
                    <div class="recently-added-content">
                        <c:choose>
                            <c:when test="${not empty recentlyAddedGuitars}">
                                <ul class="recently-added-list collapsed" id="recentlyAddedGuitarList">
                                    <c:forEach var="guitar" items="${recentlyAddedGuitars}" varStatus="loop">
                                         <li><c:out value="${guitar.brand}"/> <c:out value="${guitar.model}"/></li>
                                    </c:forEach>
                                </ul>
                                 <c:url var="browseNewestUrl" value="/browse">
                                    <c:param name="sort" value="date_desc"/>
                                </c:url>
                                <a href="${browseNewestUrl}" class="btn btn-view-all">View All Newest</a>
                            </c:when>
                            <c:otherwise>
                                <p class="stat-label" style="text-align:center; flex-grow:1; display:flex; align-items:center; justify-content:center;">No guitars added recently.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                 <div class="dash-box">
                    <h3 class="dash-box-title">Quick Actions</h3>
                    <div class="dash-box-actions">
                        <c:url var="addGuitarUrl" value="/add-guitar"/>
                        <c:url var="manageInventoryUrl" value="/manage-inventory"/>
                        <a href="${addGuitarUrl}" class="btn btn-primary">Add New Guitar</a>
                        <a href="${manageInventoryUrl}" class="btn btn-secondary">Manage Inventory</a>
                    </div>
                 </div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/pages/footer.jsp" />
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const recentlyAddedBox = document.getElementById('recentlyAddedBox');
            const recentlyAddedList = document.getElementById('recentlyAddedGuitarList');
            const initialVisibleItems = 3;
            const maxVisibleItems = 10;
            let itemHeight = 0;

            if (recentlyAddedList && recentlyAddedList.children.length > 0) {
                const firstItem = recentlyAddedList.querySelector('li');
                if (firstItem) {
                    const style = window.getComputedStyle(firstItem);
                    itemHeight = firstItem.offsetHeight + parseFloat(style.marginTop) + parseFloat(style.marginBottom);
                    itemHeight += (parseFloat(style.paddingTop) + parseFloat(style.paddingBottom) + 1);
                }

                if (itemHeight > 0) {
                    const collapsedHeight = Math.min(recentlyAddedList.children.length, initialVisibleItems) * itemHeight;
                    recentlyAddedList.style.maxHeight = collapsedHeight + 'px';
                }

                recentlyAddedBox.addEventListener('mouseenter', function() {
                    if (itemHeight > 0) {
                        const expandedHeight = Math.min(recentlyAddedList.children.length, maxVisibleItems) * itemHeight;
                        recentlyAddedList.style.maxHeight = expandedHeight + 'px';
                        recentlyAddedBox.style.minHeight = (90 + expandedHeight) + 'px';
                    }
                });

                recentlyAddedBox.addEventListener('mouseleave', function() {
                     if (itemHeight > 0) {
                        const collapsedHeight = Math.min(recentlyAddedList.children.length, initialVisibleItems) * itemHeight;
                        recentlyAddedList.style.maxHeight = collapsedHeight + 'px';
                        recentlyAddedBox.style.minHeight = '170px';
                    }
                });
            }
        });
    </script>
</body>
</html>