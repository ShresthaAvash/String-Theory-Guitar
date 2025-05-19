<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Guitar - String Theory Guitars</title>
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
        .form-group input[type="url"],
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
        .image-url-info {
            font-size: 0.85em;
            color: #bbb;
            margin-top: 5px;
            display: block;
        }
        .image-url-inputs .form-group { 
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px dotted #5f5f5f;
        }
        .image-url-inputs .form-group:last-child {
            border-bottom: none;
            padding-bottom: 5px; 
        }
        .image-url-inputs .input-group { 
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .image-url-inputs input[type="url"] {
            flex-grow: 1;
        }
        .image-url-inputs input[type="radio"] {
            margin-left: 5px;
            flex-shrink: 0;
        }
        .image-url-inputs label.radio-label { 
            font-weight: normal;
            font-size: 0.9em;
            color: #ccc;
            margin-bottom: 0;
            flex-shrink: 0;
        }
        .btn-add-url {
            background-color: #5a5a5a;
            color: #e0e0e0;
            padding: 6px 12px;
            font-size: 0.9em;
            margin-top: 5px;
            cursor: pointer;
            border: none;
            border-radius: 3px;
        }
        .btn-add-url:hover {
            background-color: #686868;
        }
        .btn-remove-url { 
            background-color: #785050;
            color: #e0e0e0;
            padding: 3px 8px;
            font-size: 0.8em;
            margin-left: 5px;
            cursor: pointer;
            border:none;
            border-radius:3px;
            flex-shrink: 0;
        }
        .btn-remove-url:hover {
            background-color: #8a6060;
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
        .error-message ul {
            list-style-type: disc;
            margin-left: 20px;
            padding-left: 5px;
            text-align: left;
        }
        .success-message {
            background-color: #5cb85c;
            color: white;
            border: 1px solid #4cae4c;
        }
        @media (max-width: 768px) {
            .page-title { font-size: 2em; }
            .form-box { padding: 25px 20px; }

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
                <c:if test="${not empty errors}">
                    <div class="message error-message">
                        <strong>Please correct the following errors:</strong>
                        <ul>
                            <c:forEach var="error" items="${errors}">
                                <li><c:out value="${error}"/></li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:if>
                <c:if test="${not empty errorMessage && empty errors}"><p class="message error-message"><c:out value="${errorMessage}"/></p></c:if>
                <c:if test="${not empty successMessage}"><p class="message success-message"><c:out value="${successMessage}"/></p></c:if>

                <form action="${pageContext.request.contextPath}/add-guitar" method="post" novalidate>
                    <div class="form-section">
                        <h3 class="section-title">Basic Information</h3>
                        <div class="form-group">
                            <label for="brand">Brand</label>
                            <input type="text" id="brand" name="brand" required value="${fn:escapeXml(guitar.brand)}">
                        </div>
                        <div class="form-group">
                            <label for="model">Model</label>
                            <input type="text" id="model" name="model" required value="${fn:escapeXml(guitar.model)}">
                        </div>
                        <div class="form-group">
                            <label for="guitarType">Type (e.g., Solid Body, Acoustic)</label>
                            <input type="text" id="guitarType" name="guitarType" value="${fn:escapeXml(guitar.guitarType)}">
                        </div>
                        <div class="form-group">
                            <label for="year">Year</label>
                            <input type="number" id="year" name="year" min="1900" max="<%= java.time.Year.now().getValue() + 1 %>" value="${guitar.yearProduced}">
                        </div>
                         <div class="form-group">
                            <label for="serialNumber">Serial Number</label>
                            <input type="text" id="serialNumber" name="serialNumber" value="${fn:escapeXml(guitar.serialNumber)}">
                        </div>
                         <div class="form-group">
                            <label for="finishColor">Finish / Color</label>
                            <input type="text" id="finishColor" name="finishColor" value="${fn:escapeXml(guitar.finishColor)}">
                        </div>
                    </div>

                    <div class="form-section">
                        <h3 class="section-title">Specifications</h3>
                        <div class="form-group"><label for="bodyWood">Body Wood</label><input type="text" id="bodyWood" name="bodyWood" value="${fn:escapeXml(guitar.bodyWood)}"></div>
                        <div class="form-group"><label for="neckWood">Neck Wood</label><input type="text" id="neckWood" name="neckWood" value="${fn:escapeXml(guitar.neckWood)}"></div>
                        <div class="form-group"><label for="fretboardWood">Fretboard Wood</label><input type="text" id="fretboardWood" name="fretboardWood" value="${fn:escapeXml(guitar.fretboardWood)}"></div>
                        <div class="form-group"><label for="pickups">Pickups</label><input type="text" id="pickups" name="pickups" value="${fn:escapeXml(guitar.pickups)}"></div>
                    </div>

                    <div class="form-section">
                         <h3 class="section-title">Condition & Pricing</h3>
                         <div class="form-group">
                            <label for="condition">Condition</label>
                            <select id="condition" name="condition">
                                <option value="" disabled ${empty guitar.conditionRating ? 'selected' : ''}>-- Select Condition --</option>
                                <option value="New" ${guitar.conditionRating == 'New' ? 'selected' : ''}>New</option>
                                <option value="Mint" ${guitar.conditionRating == 'Mint' ? 'selected' : ''}>Mint</option>
                                <option value="Excellent" ${guitar.conditionRating == 'Excellent' ? 'selected' : ''}>Excellent</option>
                                <option value="Very Good" ${guitar.conditionRating == 'Very Good' ? 'selected' : ''}>Very Good</option>
                                <option value="Good" ${guitar.conditionRating == 'Good' ? 'selected' : ''}>Good</option>
                                <option value="Fair" ${guitar.conditionRating == 'Fair' ? 'selected' : ''}>Fair</option>
                                <option value="Poor" ${guitar.conditionRating == 'Poor' ? 'selected' : ''}>Poor</option>
                            </select>
                         </div>
                          <div class="form-group">
                             <label for="conditionDetails">Condition Details / Description</label>
                             <textarea id="conditionDetails" name="conditionDetails" rows="4">${fn:escapeXml(guitar.conditionDetails)}</textarea>
                         </div>
                          <div class="form-group">
                             <label for="price">Price ($)</label>
                             <input type="number" id="price" name="price" step="0.01" min="0" value="${guitar.price}">
                         </div>
                    </div>

                    <div class="form-section">
                        <h3 class="section-title">Images</h3>
                        <div id="image-url-container" class="image-url-inputs">
                            <%-- Image URL fields will be added here by JavaScript --%>
                            <%-- Repopulation on error will also be handled by JavaScript --%>
                        </div>
                        <button type="button" id="add-more-urls" class="btn-add-url">Add Image URL</button>
                        <span class="image-url-info">Provide direct links to online images. Select one as the main image.</span>
                    </div>

                    <button type="submit" class="btn btn-submit-guitar">Add Guitar to Inventory</button>
                </form>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/pages/footer.jsp" />

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const addMoreUrlsButton = document.getElementById('add-more-urls');
            const imageUrlContainer = document.getElementById('image-url-container');
            let imageUrlCount = 0;

            function addUrlField(urlValue = '', isMain = false) {
                const newUrlFieldGroup = document.createElement('div');
                newUrlFieldGroup.classList.add('form-group');

                const label = document.createElement('label');
                label.setAttribute('for', 'imageUrl_' + imageUrlCount);
                label.textContent = 'Image URL ' + (imageUrlCount + 1);

                const inputGroup = document.createElement('div');
                inputGroup.classList.add('input-group');

                const input = document.createElement('input');
                input.setAttribute('type', 'url');
                input.setAttribute('id', 'imageUrl_' + imageUrlCount);
                input.setAttribute('name', 'imageUrl');
                input.setAttribute('placeholder', 'Enter full URL e.g., https://example.com/image.jpg');
                input.value = urlValue;

                const radio = document.createElement('input');
                radio.setAttribute('type', 'radio');
                radio.setAttribute('id', 'mainImageIndex_' + imageUrlCount);
                radio.setAttribute('name', 'mainImageIndex');
                radio.setAttribute('value', imageUrlCount.toString());
                if (isMain) {
                     radio.checked = true;
                }

                const radioLabel = document.createElement('label');
                radioLabel.setAttribute('for', 'mainImageIndex_' + imageUrlCount);
                radioLabel.classList.add('radio-label');
                radioLabel.textContent = 'Main';

                const removeButton = document.createElement('button');
                removeButton.setAttribute('type', 'button');
                removeButton.classList.add('btn-remove-url');
                removeButton.textContent = 'Remove';
                removeButton.onclick = function() {
                    const wasChecked = radio.checked;
                    newUrlFieldGroup.remove();
                    imageUrlCount--; 
                    if (wasChecked && !document.querySelector('input[name="mainImageIndex"]:checked')) {
                        const firstRadio = imageUrlContainer.querySelector('input[name="mainImageIndex"]');
                        if (firstRadio) {
                            firstRadio.checked = true;
                        }
                    }
                    updateLabels();
                };

                inputGroup.appendChild(input);
                inputGroup.appendChild(radio);
                inputGroup.appendChild(radioLabel);
                inputGroup.appendChild(removeButton);

                newUrlFieldGroup.appendChild(label);
                newUrlFieldGroup.appendChild(inputGroup);
                imageUrlContainer.appendChild(newUrlFieldGroup);

                imageUrlCount++;
                updateLabels();
            }

            function updateLabels() {
                const groups = imageUrlContainer.querySelectorAll('.form-group');
                groups.forEach((group, index) => {
                    const label = group.querySelector('label:not(.radio-label)');
                    if (label) {
                        label.textContent = 'Image URL ' + (index + 1);
                        label.setAttribute('for', 'imageUrl_' + index);
                    }
                    const urlInput = group.querySelector('input[type="url"]');
                    if (urlInput) urlInput.id = 'imageUrl_' + index;

                    const radioInput = group.querySelector('input[type="radio"]');
                    if (radioInput) {
                        radioInput.id = 'mainImageIndex_' + index;
                        radioInput.value = index.toString();
                    }
                    const radioLabel = group.querySelector('label.radio-label');
                    if (radioLabel) radioLabel.setAttribute('for', 'mainImageIndex_' + index);
                });
            }



            <c:if test="${not empty submittedImageUrls}">
                const submittedUrls = [
                    <c:forEach var="url" items="${submittedImageUrls}" varStatus="loop">
                        "${fn:escapeXml(url)}"<c:if test="${not loop.last}">,</c:if>
                    </c:forEach>
                ];
                const submittedMainIndex = parseInt("${submittedMainImageIndex}", 10);

                if (submittedUrls.length > 0) {
                    submittedUrls.forEach(function(url, index) {
                        if (url.trim() !== '') { 
                             addUrlField(url, index === submittedMainIndex);
                        }
                    });
                }
            </c:if>


            if (imageUrlContainer.children.length === 0) {
                addUrlField('', true);
            }


            addMoreUrlsButton.addEventListener('click', function() {

                const isFirstDynamicAdd = imageUrlContainer.children.length === 0;
                addUrlField('', isFirstDynamicAdd);
            });
        });
    </script>

</body>
</html>