<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="currentUser" value="${sessionScope.loggedInUser}" />
<c:if test="${empty currentUser || currentUser.role != 'admin'}">
    <c:redirect url="/login?error=auth" />
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
             text-align: left;
             margin-left: 5px;
             margin-top: 0;
             font-weight: 400;
        }
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }
        .dash-box {
            background-color: #444444;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.15);
            display: flex;
            flex-direction: column;
            transition: transform 0.25s ease-out, box-shadow 0.25s ease-out;
        }
        .dash-box:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.25);
        }
        .dash-box-title {
            font-size: 1.1em;
            color: #FFC107;
            font-weight: 700;
            margin-top: 0;
            margin-bottom: 20px;
            padding-bottom: 10px;
             border-bottom: 1px solid #555;
        }
        .stat-number {
            font-size: 3em;
            color: #FFC107;
            font-weight: 700;
            margin-bottom: 5px;
            line-height: 1.1;
        }
        .stat-label {
            font-size: 0.95em;
            color: #cccccc;
            font-weight: 400;
        }
        .recently-added-list {
            list-style: none;
            padding: 0;
            margin: 0 0 15px 0;
            flex-grow: 1;
        }
        .recently-added-list li {
            color: #e0e0e0;
            padding: 8px 0;
            font-size: 0.95em;
            border-bottom: 1px dotted #666;
            font-weight: 400;
        }
        .recently-added-list li:last-child {
             border-bottom: none;
        }
        .btn {
            display: block;
            width: 100%;
            box-sizing: border-box;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-size: 1em;
            font-weight: 700;
            cursor: pointer;
            text-align: center;
            transition: background-color 0.2s ease, color 0.2s ease, transform 0.1s ease;
            margin-top: 10px;
            font-family: inherit;
        }
        .btn:first-child {
             margin-top: 0;
        }
        .btn:active {
             transform: scale(0.97);
        }
        .btn-primary { background-color: #FFC107; color: #333333; }
        .btn-primary:hover { background-color: #e0a800; }
        .btn-secondary { background-color: #5a5a5a; color: #e0e0e0; }
        .btn-secondary:hover { background-color: #686868; }
        .btn-view-all {
            background-color: #5a5a5a;
            color: #e0e0e0;
            padding: 8px 15px;
            font-size: 0.9em;
            font-weight: 700;
            margin-top: auto;
            width: auto;
            align-self: flex-start;
        }
        .btn-view-all:hover { background-color: #686868; }
        .inventory-growth-section { margin-bottom: 40px; }
        .section-heading {
            font-size: 1.6em;
            color: #ffffff;
            font-weight: 700;
            margin-top: 0;
            margin-bottom: 15px;
        }
        .chart-placeholder {
            background-color: #444444;
            border-radius: 8px;
            padding: 40px 20px;
            text-align: center;
            color: #aaa;
            font-style: italic;
            min-height: 150px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-weight: 400;
        }
        @media (max-width: 1024px) {
             .container { max-width: 95%; }
             .dashboard-grid { grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); }
        }
        @media (max-width: 768px) {
            .dashboard-title { font-size: 2.2em; }
            .dashboard-subtitle { text-align: center; margin-left: 0; }
            .dashboard-grid { grid-template-columns: 1fr; gap: 20px; }
            .dash-box { padding: 20px; }
            .section-heading { font-size: 1.4em; text-align: center; }
            .chart-placeholder { min-height: 120px; }
        }
        @media (max-width: 480px) {
            .container { padding: 0 15px; }
            .dashboard-title { font-size: 1.8em; }
            .stat-number { font-size: 2.2em; }
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
                    <p class="stat-number">128</p> <%-- Placeholder --%>
                    <p class="stat-label">Guitars currently in stock</p>
                </div>
                <div class="dash-box">
                    <h3 class="dash-box-title">Estimated Value</h3>
                     <p class="stat-number">$256,750</p> <%-- Placeholder --%>
                     <p class="stat-label">Total estimated value</p>
                </div>
                <div class="dash-box">
                    <h3 class="dash-box-title">Recently Added</h3>
                    <ul class="recently-added-list"> <%-- Placeholder --%>
                         <li>Fender Strat '62 RI</li>
                         <li>Gibson Les Paul Standard</li>
                         <li>PRS Custom 24</li>
                    </ul>
                    <a href="${pageContext.request.contextPath}/browse?sort=added-desc" class="btn btn-view-all">View All</a>
                </div>
                 <div class="dash-box">
                    <h3 class="dash-box-title">Quick Actions</h3>
                    <a href="${pageContext.request.contextPath}/add-guitar" class="btn btn-primary">Add New Guitar</a>
                    <a href="${pageContext.request.contextPath}/manage-inventory" class="btn btn-secondary">Manage Inventory</a>
                 </div>
            </div>

            <section class="inventory-growth-section">
                <h2 class="section-heading">Inventory Growth (Placeholder)</h2>
                <div class="chart-placeholder">
                    <span style="font-style: normal; font-weight: 400;">↝</span>
                    Placeholder chart showing inventory growth
                </div>
            </section>
        </div>
    </div>

    <jsp:include page="/WEB-INF/pages/footer.jsp" />

</body>
</html>