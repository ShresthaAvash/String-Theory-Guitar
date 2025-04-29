<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Guitar: Fender Am Std Strat - String Theory Guitars</title>
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
            max-width: 850px;
            margin: 40px auto;
            padding: 0 20px;
            box-sizing: border-box;
        }

        .page-title {
            font-size: 2.2em;
            color: #FFC107;
            font-weight: 700;
            text-align: center;
            margin-top: 0;
            margin-bottom: 15px;
            line-height: 1.3;
        }

        .page-title-details {
            font-size: 0.8em;
            color: #ccc;
            font-weight: 400;
            display: block;
            margin-top: 0px;
            text-align: center;
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

        /* Image Section */
        .current-images {
            margin-bottom: 20px;
        }
        .current-images label {
            margin-bottom: 10px;
        }
        .image-thumbnail-container {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }
        .image-thumbnail {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 4px;
            border: 1px solid #666;
            background-color: #555;
        }
        .upload-new label {
            margin-top: 15px;
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

        /* Button Area */
        .form-actions {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #5f5f5f;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }
        .btn {
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
        .btn-save {
            background-color: #FFC107;
            color: #333333;
        }
        .btn-save:hover {
            background-color: #e0a800;
        }
        .btn-cancel {
            background-color: #6c757d;
            color: #ffffff;
        }
        .btn-cancel:hover {
            background-color: #5a6268;
        }
        .btn-delete {
            background-color: #d9534f;
            color: #ffffff;
        }
        .btn-delete:hover {
            background-color: #c9302c;
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

        /* Responsive */
        @media (max-width: 768px) {
            .page-title { font-size: 1.8em; }
            .form-box { padding: 25px 20px; }
            .section-title { font-size: 1.1em; }
            .form-group input[type="text"],
            .form-group input[type="number"],
            .form-group select,
            .form-group textarea { padding: 9px 12px; font-size: 0.95em; }
            .btn { font-size: 0.95em; padding: 9px 20px; }
        }
        @media (max-width: 480px) {
            .container { padding: 0 15px; }
            .page-title { font-size: 1.6em; }
            .form-actions { flex-direction: column; align-items: stretch; }
            .form-actions .btn { width: 100%; box-sizing: border-box; }
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/pages/navbar.jsp">
        <jsp:param name="activePage" value="admin-inventory"/>
    </jsp:include>

    <div class="main-content-area">
        <div class="container">

             <h1 class="page-title">Edit Guitar:
                 <span class="page-title-details">Fender Am Std Strat (US18012345)</span>
             </h1>

            <div class="form-box">

                 <c:if test="${not empty errorMessage}"><p class="message error-message"><c:out value="${errorMessage}"/></p></c:if>
                 <c:if test="${not empty successMessage}"><p class="message success-message"><c:out value="${successMessage}"/></p></c:if>

                <%-- Form uses static placeholder data --%>
                <form action="${pageContext.request.contextPath}/edit-guitar" method="post" enctype="multipart/form-data" novalidate>
                    <input type="hidden" name="guitarId" value="1">

                    <div class="form-section"><h3 class="section-title">Basic Information</h3><div class="form-group"><label for="make">Make</label><input type="text" id="make" name="make" required value="Fender"></div><div class="form-group"><label for="model">Model</label><input type="text" id="model" name="model" required value="Am Std Strat"></div><div class="form-group"><label for="year">Year</label><input type="number" id="year" name="year" min="1900" max="<%= java.time.Year.now().getValue() + 1 %>" value="2018"></div><div class="form-group"><label for="serialNumber">Serial Number</label><input type="text" id="serialNumber" name="serialNumber" value="US18012345"></div><div class="form-group"><label for="finishColor">Finish / Color</label><input type="text" id="finishColor" name="finishColor" value="Olympic White"></div></div>
                    <div class="form-section"><h3 class="section-title">Specifications</h3><div class="form-group"><label for="bodyWood">Body Wood</label><input type="text" id="bodyWood" name="bodyWood" value="Alder"></div><div class="form-group"><label for="neckWood">Neck Wood</label><input type="text" id="neckWood" name="neckWood" value="Maple"></div><div class="form-group"><label for="fretboardWood">Fretboard Wood</label><input type="text" id="fretboardWood" name="fretboardWood" value="Rosewood"></div><div class="form-group"><label for="pickups">Pickups</label><input type="text" id="pickups" name="pickups" value="Custom Shop Fat '50s"></div></div>
                    <div class="form-section"><h3 class="section-title">Condition & Pricing</h3><div class="form-group"><label for="condition">Condition</label><select id="condition" name="condition"><option value="" disabled>-- Select Condition --</option><option value="New">New</option><option value="Mint">Mint</option><option value="Excellent" selected>Excellent</option><option value="Very Good">Very Good</option><option value="Good">Good</option><option value="Fair">Fair</option><option value="Poor">Poor</option></select></div><div class="form-group"><label for="conditionDetails">Condition Details / Description</label><textarea id="conditionDetails" name="conditionDetails" rows="4">Minor playwear, some light pick scratches on the guard. No significant dings or dents. Frets show minimal wear. Electronics function perfectly. Includes original hardshell case.</textarea></div><div class="form-group"><label for="price">Price ($)</label><input type="number" id="price" name="price" step="0.01" min="0" value="1499.00"></div></div>
                    <div class="form-section"><h3 class="section-title">Images</h3><div class="form-group current-images"><label>Current Images:</label><div class="image-thumbnail-container"><img src="${pageContext.request.contextPath}/images/guitar deviser.jpg" alt="Current Image 1" class="image-thumbnail"><img src="${pageContext.request.contextPath}/images/guitar deviser.jpg" alt="Current Image 2" class="image-thumbnail"><img src="${pageContext.request.contextPath}/images/guitar deviser.jpg" alt="Current Image 3" class="image-thumbnail"></div><p style="font-size: 0.8em; color: #bbb; margin-top: 10px;">(Static placeholder images shown)</p></div><div class="form-group upload-new"><label for="images">Upload New Images (Optional)</label><input type="file" id="images" name="images" multiple accept="image/jpeg, image/png, image/webp, image/gif"><span class="file-upload-info">Newly uploaded images will be added (or replace existing ones, depending on implementation).</span></div></div>

                    <div class="form-actions">
                        <a href="#" class="btn btn-delete" onclick="confirm('DEMO: Are you sure you want to permanently delete Fender Am Std Strat? (Action disabled)'); return false;">Delete Guitar</a>
                        <div>
                            <a href="${pageContext.request.contextPath}/manage-inventory" class="btn btn-cancel">Cancel</a>
                            <button type="submit" class="btn btn-save">Save Changes</button>
                        </div>
                    </div>
                </form>

            </div>

        </div>
    </div>

    <jsp:include page="/WEB-INF/pages/footer.jsp" />

</body>
</html>