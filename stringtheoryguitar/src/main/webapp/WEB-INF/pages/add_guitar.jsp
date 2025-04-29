<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Guitar - String Theory Guitars</title>
    <style>
        /* --- Add Guitar CSS --- */
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
            max-width: 850px;
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
        .form-box {
            background-color: #444444;
            border-radius: 8px;
            padding: 30px 35px;
            box-shadow: 0 3px 8px rgba(0,0,0,0.2);
        }
        .form-section {
            margin-bottom: 35px;
        }
        .form-section:last-child {
            margin-bottom: 15px;
        }
        .section-title {
            font-size: 1.2em;
            color: #FFC107;
            font-weight: 700;
            margin-top: 0;
            margin-bottom: 25px;
            padding-bottom: 8px;
            border-bottom: 1px solid #5f5f5f;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            text-align: left;
            margin-bottom: 6px;
            font-size: 0.9em;
            color: #e0e0e0;
            font-weight: 700;
        }
        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group select,
        .form-group textarea {
            font-family: inherit;
            width: 100%;
            padding: 10px 14px;
            border: 1px solid #666;
            background-color: #555555;
            color: #ffffff;
            border-radius: 5px;
            font-size: 1em;
            box-sizing: border-box;
            font-weight: 400;
        }
        .form-group input::placeholder,
        .form-group textarea::placeholder {
            color: #ababab;
            opacity: 1;
        }
        .form-group textarea {
            min-height: 80px;
            resize: vertical;
            line-height: 1.5;
        }
        .form-group input[type="file"] {
            background-color: transparent;
            border: none;
            padding: 5px 0;
            color: #ccc;
            font-size: 0.95em;
        }
        .form-group input[type="file"]::file-selector-button {
            padding: 6px 15px;
            margin-right: 10px;
            background-color: #5a5a5a;
            color: #e0e0e0;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 700;
            font-size: 0.9em;
            transition: background-color 0.2s ease;
        }
        .form-group input[type="file"]::file-selector-button:hover {
            background-color: #686868;
        }
        .file-upload-info {
            font-size: 0.85em;
            color: #bbb;
            margin-top: 5px;
            display: block;
        }
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
        .btn-submit-guitar {
            background-color: #FFC107;
            color: #333333;
            margin-top: 15px;
            width: 100%;
        }
        .btn-submit-guitar:hover {
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

        /* Responsive */
        @media (max-width: 768px) {
            .page-title { font-size: 2em; }
            .form-box { padding: 25px 20px; }
            .section-title { font-size: 1.1em; }
            .form-group input[type="text"],
            .form-group input[type="number"],
            .form-group select,
            .form-group textarea { padding: 9px 12px; font-size: 0.95em; }
            .btn-submit-guitar { font-size: 1em; padding: 10px 20px; }
        }
        @media (max-width: 480px) {
            .container { padding: 0 15px; }
            .page-title { font-size: 1.8em; margin-bottom: 30px; }
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/pages/navbar.jsp">
        <jsp:param name="activePage" value="add-guitar"/>
    </jsp:include>

    <div class="main-content-area">
        <div class="container">
            <h1 class="page-title">Add New Guitar to Inventory</h1>
            <div class="form-box">
                <c:if test="${not empty errorMessage}"><p class="message error-message"><c:out value="${errorMessage}"/></p></c:if>
                <%-- Show success message from simulated POST --%>
                <c:if test="${param.success == 'true'}"><p class="message success-message">Demo: Guitar 'added' successfully!</p></c:if>

                <form action="${pageContext.request.contextPath}/add-guitar" method="post" enctype="multipart/form-data" novalidate>
                    <%-- Basic Information Section --%>
                    <div class="form-section">
                        <h3 class="section-title">Basic Information</h3>
                        <div class="form-group">
                            <label for="brand">Brand</label> <%-- Changed Label --%>
                            <input type="text" id="brand" name="brand" required value="<c:out value='${param.brand}'/>"> <%-- Changed name/id --%>
                        </div>
                        <div class="form-group">
                            <label for="model">Model</label>
                            <input type="text" id="model" name="model" required value="<c:out value='${param.model}'/>">
                        </div>
                        <div class="form-group"> <%-- Optional Guitar Type --%>
                            <label for="guitarType">Type (e.g., Solid Body, Acoustic)</label>
                            <input type="text" id="guitarType" name="guitarType" value="<c:out value='${param.guitarType}'/>">
                        </div>
                        <div class="form-group">
                            <label for="year">Year</label>
                            <input type="number" id="year" name="year" min="1900" max="<%= java.time.Year.now().getValue() + 1 %>" value="<c:out value='${param.year}'/>">
                        </div>
                         <div class="form-group">
                            <label for="serialNumber">Serial Number</label>
                            <input type="text" id="serialNumber" name="serialNumber" value="<c:out value='${param.serialNumber}'/>">
                        </div>
                         <div class="form-group">
                            <label for="finishColor">Finish / Color</label>
                            <input type="text" id="finishColor" name="finishColor" value="<c:out value='${param.finishColor}'/>">
                        </div>
                    </div>

                     <%-- Specifications Section --%>
                    <div class="form-section">
                        <h3 class="section-title">Specifications</h3>
                        <div class="form-group"><label for="bodyWood">Body Wood</label><input type="text" id="bodyWood" name="bodyWood" value="<c:out value='${param.bodyWood}'/>"></div>
                        <div class="form-group"><label for="neckWood">Neck Wood</label><input type="text" id="neckWood" name="neckWood" value="<c:out value='${param.neckWood}'/>"></div>
                        <div class="form-group"><label for="fretboardWood">Fretboard Wood</label><input type="text" id="fretboardWood" name="fretboardWood" value="<c:out value='${param.fretboardWood}'/>"></div>
                        <div class="form-group"><label for="pickups">Pickups</label><input type="text" id="pickups" name="pickups" value="<c:out value='${param.pickups}'/>"></div>
                    </div>

                     <%-- Condition & Pricing Section --%>
                    <div class="form-section">
                         <h3 class="section-title">Condition & Pricing</h3>
                         <div class="form-group">
                            <label for="condition">Condition</label>
                            <select id="condition" name="condition">
                                <option value="" disabled ${empty param.condition ? 'selected' : ''}>-- Select Condition --</option>
                                <option value="New" ${param.condition == 'New' ? 'selected' : ''}>New</option>
                                <option value="Mint" ${param.condition == 'Mint' ? 'selected' : ''}>Mint</option>
                                <option value="Excellent" ${param.condition == 'Excellent' ? 'selected' : ''}>Excellent</option>
                                <option value="Very Good" ${param.condition == 'Very Good' ? 'selected' : ''}>Very Good</option>
                                <option value="Good" ${param.condition == 'Good' ? 'selected' : ''}>Good</option>
                                <option value="Fair" ${param.condition == 'Fair' ? 'selected' : ''}>Fair</option>
                                <option value="Poor" ${param.condition == 'Poor' ? 'selected' : ''}>Poor</option>
                            </select>
                         </div>
                          <div class="form-group">
                             <label for="conditionDetails">Condition Details / Description</label>
                             <textarea id="conditionDetails" name="conditionDetails" rows="4"><c:out value='${param.conditionDetails}'/></textarea>
                         </div>
                          <div class="form-group">
                             <label for="price">Price ($)</label>
                             <input type="number" id="price" name="price" step="0.01" min="0" value="<c:out value='${param.price}'/>">
                         </div>
                    </div>

                     <%-- Images Section --%>
                     <div class="form-section">
                        <h3 class="section-title">Images</h3>
                         <div class="form-group">
                            <label for="images">Upload Images</label>
                            <input type="file" id="images" name="images" multiple accept="image/jpeg, image/png, image/webp, image/gif">
                            <span class="file-upload-info">Select one or more images. The first image will be the main thumbnail.</span>
                         </div>
                     </div>

                    <%-- Submit Button --%>
                    <button type="submit" class="btn btn-submit-guitar">Add Guitar to Inventory</button>

                </form>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/pages/footer.jsp" />

</body>
</html>