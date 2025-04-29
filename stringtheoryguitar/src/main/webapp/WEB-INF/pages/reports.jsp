<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- Security Check (Also done in Servlet, belt-and-suspenders) --%>
<c:set var="currentUser" value="${sessionScope.loggedInUser}" />
<c:if test="${empty currentUser || currentUser.role != 'admin'}">
    <c:redirect url="/login?error=auth" />
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports - String Theory Guitars</title>
    <style>
        body {
            margin: 0; padding: 0;
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
            background-color: #212121; color: #e0e0e0; display: flex; flex-direction: column; min-height: 100vh;
            -webkit-font-smoothing: antialiased; -moz-osx-font-smoothing: grayscale;
        }
        .main-content-area {
            flex-grow: 1; padding-bottom: 50px;
        }
        .container {
            max-width: 1100px;
            margin: 40px auto; padding: 0 20px; box-sizing: border-box;
        }
        .page-title {
            font-size: 2.5em; color: #FFC107; font-weight: 700;
            text-align: center; margin-top: 0; margin-bottom: 50px;
        }

        .report-section {
            background-color: #3a3a3a;
            border-radius: 8px;
            padding: 25px 30px;
            margin-bottom: 30px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.15);
        }
        .report-section h2 { 
            font-size: 1.6em; color: #ffffff; font-weight: 700;
            margin-top: 0; margin-bottom: 25px;
            padding-bottom: 10px; border-bottom: 1px solid #555;
        }
        .report-section p {
            font-size: 1em; line-height: 1.6; color: #cccccc; font-weight: 400;
            margin-bottom: 15px;
        }
        .report-section ul {
            list-style: disc; 
            margin-left: 20px;
            padding-left: 15px;
            margin-bottom: 15px;
        }
        .report-section li {
            margin-bottom: 8px;
            color: #cccccc;
        }

        .placeholder-box {
            background-color: #444444; border-radius: 5px;
            padding: 40px 20px; text-align: center; color: #aaa;
            font-style: italic; min-height: 100px; margin-top: 15px;
            display: flex; justify-content: center; align-items: center;
        }

        @media (max-width: 768px) {
            .page-title { font-size: 2em; }
            .report-section h2 { font-size: 1.4em; }
            .report-section p, .report-section li { font-size: 0.95em; }
        }
        @media (max-width: 480px) {
            .container { padding: 0 15px; }
            .page-title { font-size: 1.8em; margin-bottom: 30px; }
            .report-section { padding: 20px; }
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/pages/navbar.jsp">
        <jsp:param name="activePage" value="reports"/>
    </jsp:include>

    <div class="main-content-area">
        <div class="container">

            <h1 class="page-title">Reports</h1>

            <%-- Display Messages if needed --%>
            <c:if test="${not empty errorMessage}"><p class="message error-message"><c:out value="${errorMessage}"/></p></c:if>
            <c:if test="${not empty successMessage}"><p class="message success-message"><c:out value="${successMessage}"/></p></c:if>


            <%-- Example Report Section 1: Inventory Summary --%>
            <section class="report-section">
                <h2>Inventory Overview</h2>
                <p>This section will contain summary statistics about the current inventory.</p>
                <ul>
                    <li>Total Guitars: [Placeholder Value]</li>
                    <li>Total Estimated Value: $[Placeholder Value]</li>
                    <li>Most Common Make: [Placeholder Make]</li>
                    <li>Average Price: $[Placeholder Value]</li>
                </ul>
                <div class="placeholder-box">
                    Inventory Value Distribution Chart (Placeholder)
                </div>
            </section>

            <%-- Example Report Section 2: Sales Data (Conceptual) --%>
            <section class="report-section">
                <h2>Sales Trends (Conceptual)</h2>
                <p>Data related to sales performance over selected periods would appear here (functionality not implemented).</p>
                 <div class="placeholder-box">
                    Sales Trend Chart (Placeholder)
                </div>
                 <p>Top selling items and revenue breakdowns will be displayed once sales tracking is added.</p>
            </section>

             <%-- Example Report Section 3: User Activity (Conceptual) --%>
            <section class="report-section">
                 <h2>User Activity (Conceptual)</h2>
                 <p>Information about user registrations and potentially login activity.</p>
                 <ul>
                    <li>New Registrations (Last 7 days): [Placeholder Value]</li>
                    <li>Total Active Users: [Placeholder Value]</li>
                 </ul>
            </section>


             <%-- Add more report sections as needed --%>

        </div>
    </div> <%-- End main-content-area --%>

    <jsp:include page="/WEB-INF/pages/footer.jsp" />

</body>
</html>