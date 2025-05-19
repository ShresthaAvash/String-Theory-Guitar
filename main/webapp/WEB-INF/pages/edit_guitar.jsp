<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Guitar: <c:out value="${guitar.brand}"/> <c:out value="${guitar.model}"/> - String Theory Guitars</title>
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
        .form-group label:not(.inline-label) { 
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
        .current-images-section, .new-images-section {
             margin-bottom: 20px;
        }
        .section-label { 
             display: block;
             font-size: 1em;
             color: #FFC107;
             font-weight: 700;
             margin-bottom: 15px;
        }
        .image-item { 
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px dotted #5f5f5f;
            display: flex;
            flex-direction: column; 
            gap: 5px;
        }
        .image-item:last-child {
            border-bottom: none;
            padding-bottom: 5px;
        }
        .image-input-group { 
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .image-item input[type="url"] {
            flex-grow: 1;
        }
        .image-item input[type="radio"],
        .image-item input[type="checkbox"] {
            margin-left: 5px;
            flex-shrink: 0;
        }
        .image-item label.inline-label { 
            font-weight: normal;
            font-size: 0.9em;
            color: #ccc;
            margin-bottom: 0;
            margin-left: 2px; 
            flex-shrink: 0;
        }
         .current-image-preview {
            width: 60px; height: 60px; object-fit: cover; border-radius: 4px;
            border: 1px solid #666; margin-right:10px; background-color: #505050;
            flex-shrink: 0;
        }
        .btn-add-url {
            background-color: #5a5a5a; color: #e0e0e0; padding: 6px 12px;
            font-size: 0.9em; margin-top: 5px; cursor: pointer; border:none; border-radius:3px;
        }
        .btn-add-url:hover { background-color: #686868; }
        .btn-remove-url {
            background-color: #785050; color: #e0e0e0; padding: 3px 8px;
            font-size: 0.8em; margin-left: 5px; cursor: pointer; border:none; border-radius:3px;
            flex-shrink: 0;
        }
        .btn-remove-url:hover { background-color: #8a6060; }
        .form-actions {
            margin-top: 30px; padding-top: 20px; border-top: 1px solid #5f5f5f;
            display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 15px;
        }
        .btn {
            display: inline-block; padding: 10px 25px; border: none; border-radius: 5px;
            text-decoration: none; font-size: 1.0em; font-weight: 700; cursor: pointer;
            transition: background-color 0.2s ease, color 0.2s ease, transform 0.1s ease;
            text-align: center; font-family: inherit; white-space: nowrap;
        }
        .btn:active { transform: scale(0.97); }
        .btn-save { background-color: #FFC107; color: #333333; }
        .btn-save:hover { background-color: #e0a800; }
        .btn-cancel { background-color: #6c757d; color: #ffffff; }
        .btn-cancel:hover { background-color: #5a6268; }
        .btn-delete { background-color: #d9534f; color: #ffffff; }
        .btn-delete:hover { background-color: #c9302c; }
        .message { padding: 10px 15px; margin-bottom: 20px; border-radius: 5px; text-align: center; font-weight: 400; font-size: 0.95em; line-height: 1.4; }
        .error-message { background-color: #d9534f; color: white; border: 1px solid #d43f3a; }
        .error-message ul { list-style-type: disc; margin-left: 20px; padding-left: 5px; text-align: left;}
        .success-message { background-color: #5cb85c; color: white; border: 1px solid #4cae4c; }

        @media (max-width: 768px) {
            .page-title { font-size: 1.8em; }
            .form-box { padding: 25px 20px; }

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
                 <span class="page-title-details">
                     <c:out value="${guitar.brand}"/> <c:out value="${guitar.model}"/>
                     <c:if test="${not empty guitar.serialNumber}"> (<c:out value="${guitar.serialNumber}"/>)</c:if>
                 </span>
             </h1>

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

                <form action="${pageContext.request.contextPath}/edit-guitar" method="post" novalidate>
                    <input type="hidden" name="guitarId" value="${guitar.id}">

                    <%-- Basic Information, Specifications, Condition & Pricing sections --%>
                    <%-- These are the same as your existing edit_guitar.jsp --%>
                     <div class="form-section">
                        <h3 class="section-title">Basic Information</h3>
                        <div class="form-group"><label for="brand">Brand</label><input type="text" id="brand" name="brand" required value="${fn:escapeXml(guitar.brand)}"></div>
                        <div class="form-group"><label for="model">Model</label><input type="text" id="model" name="model" required value="${fn:escapeXml(guitar.model)}"></div>
                        <div class="form-group"><label for="guitarType">Type</label><input type="text" id="guitarType" name="guitarType" value="${fn:escapeXml(guitar.guitarType)}"></div>
                        <div class="form-group"><label for="year">Year</label><input type="number" id="year" name="year" min="1900" max="<%= java.time.Year.now().getValue() + 1 %>" value="${guitar.yearProduced}"></div>
                        <div class="form-group"><label for="serialNumber">Serial Number</label><input type="text" id="serialNumber" name="serialNumber" value="${fn:escapeXml(guitar.serialNumber)}"></div>
                        <div class="form-group"><label for="finishColor">Finish / Color</label><input type="text" id="finishColor" name="finishColor" value="${fn:escapeXml(guitar.finishColor)}"></div>
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
                        <div class="form-group"><label for="conditionDetails">Condition Details</label><textarea id="conditionDetails" name="conditionDetails" rows="4">${fn:escapeXml(guitar.conditionDetails)}</textarea></div>
                        <div class="form-group">
                            <label for="price">Price ($)</label>
                            <fmt:formatNumber var="formattedPrice" value="${guitar.price}" type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2"/>
                            <input type="number" id="price" name="price" step="0.01" min="0" value="${formattedPrice}">
                        </div>
                    </div>


                    <div class="form-section">
                        <h3 class="section-title">Images</h3>

                        <div class="current-images-section">
                            <label class="section-label">Current Images:</label>
                            <div id="current-image-container">
                                <c:choose>
                                    <c:when test="${not empty guitar.images}">
                                        <c:forEach var="img" items="${guitar.images}" varStatus="loop">
                                            <div class="image-item" data-image-id="${img.imageId}">
                                                <label for="existingImageUrl_${loop.index}">URL ${loop.count}:</label>
                                                <div class="image-input-group">
                                                    <input type="hidden" name="imageId" value="${img.imageId}">
                                                    <c:if test="${not empty img.imageUrlPath}">
                                                         <img src="${fn:escapeXml(img.imageUrlPath)}" alt="Preview" class="current-image-preview">
                                                    </c:if>
                                                    <input type="url" id="existingImageUrl_${loop.index}" name="existingImageUrl" value="${fn:escapeXml(img.imageUrlPath)}" placeholder="https://example.com/image.jpg">
                                                    <input type="radio" id="mainImageRadio_existing_${img.imageId}" name="mainImageRadio" value="existing_${img.imageId}" ${img.mainImage ? 'checked' : ''}>
                                                    <label for="mainImageRadio_existing_${img.imageId}" class="inline-label">Main</label>
                                                    <input type="checkbox" id="deleteImageCheckbox_${img.imageId}" name="deleteImageCheckbox" value="${img.imageId}">
                                                    <label for="deleteImageCheckbox_${img.imageId}" class="inline-label">Delete</label>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <p style="font-size: 0.9em; color: #bbb;">No current images for this guitar.</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div class="new-images-section">
                            <label class="section-label">Add New Image URLs:</label>
                            <div id="new-image-url-container">
                                <%-- New URL fields will be added here by JavaScript --%>
                            </div>
                            <button type="button" id="add-more-new-urls" class="btn-add-url">Add New Image URL</button>
                        </div>
                        <span class="image-url-info">Provide direct links to online images. Select one as the main image (overall).</span>
                    </div>

                    <div class="form-actions">
                         <a href="#" class="btn btn-delete"
                           onclick="event.preventDefault(); if(confirm('Are you sure you want to permanently delete ${fn:escapeXml(guitar.brand)} ${fn:escapeXml(guitar.model)} (ID: ${guitar.id})? This action cannot be undone.')) { document.getElementById('deleteForm').submit(); } return false;">Delete Guitar</a>
                        <div>
                            <c:url var="manageInventoryUrl" value="/manage-inventory" />
                            <a href="${manageInventoryUrl}" class="btn btn-cancel">Cancel</a>
                            <button type="submit" class="btn btn-save">Save Changes</button>
                        </div>
                    </div>
                </form>

                 <form id="deleteForm" action="${pageContext.request.contextPath}/manage-inventory" method="post" style="display:none;">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="guitarId" value="${guitar.id}">
                </form>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/pages/footer.jsp" />

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const addNewImageUrlButton = document.getElementById('add-more-new-urls');
            const newImageUrlContainer = document.getElementById('new-image-url-container');
            let newImageUrlCount = 0; 

            function addNewImageField(urlValue = '', isMain = false) {
                const fieldIdSuffix = 'new_' + newImageUrlCount;
                const imageItemDiv = document.createElement('div');
                imageItemDiv.classList.add('image-item');
                imageItemDiv.setAttribute('data-new-field-id', newImageUrlCount);

                const label = document.createElement('label');
                label.setAttribute('for', 'newImageUrl_' + fieldIdSuffix);
                label.textContent = 'New URL ' + (newImageUrlCount + 1) + ':';

                const inputGroupDiv = document.createElement('div');
                inputGroupDiv.classList.add('image-input-group');

                const urlInput = document.createElement('input');
                urlInput.setAttribute('type', 'url');
                urlInput.setAttribute('id', 'newImageUrl_' + fieldIdSuffix);
                urlInput.setAttribute('name', 'newImageUrl'); 
                urlInput.setAttribute('placeholder', 'Enter full URL e.g., https://example.com/image.jpg');
                urlInput.value = urlValue;

                const radioInput = document.createElement('input');
                radioInput.setAttribute('type', 'radio');
                radioInput.setAttribute('id', 'mainImageRadio_' + fieldIdSuffix);
                radioInput.setAttribute('name', 'mainImageRadio'); 
                radioInput.setAttribute('value', fieldIdSuffix); 
                if (isMain) {
                    radioInput.checked = true;
                }

                const radioLabel = document.createElement('label');
                radioLabel.setAttribute('for', 'mainImageRadio_' + fieldIdSuffix);
                radioLabel.classList.add('inline-label');
                radioLabel.textContent = 'Main';

                const removeButton = document.createElement('button');
                removeButton.setAttribute('type', 'button');
                removeButton.classList.add('btn-remove-url');
                removeButton.textContent = 'Remove';
                removeButton.onclick = function() {
                    const wasChecked = radioInput.checked;
                    imageItemDiv.remove();

                    if (wasChecked && !document.querySelector('input[name="mainImageRadio"]:checked')) {
                        const firstRadio = document.querySelector('input[name="mainImageRadio"]');
                        if (firstRadio) {
                            firstRadio.checked = true;
                        }
                    }
                    updateNewFieldLabels();
                };

                inputGroupDiv.appendChild(urlInput);
                inputGroupDiv.appendChild(radioInput);
                inputGroupDiv.appendChild(radioLabel);
                inputGroupDiv.appendChild(removeButton);

                imageItemDiv.appendChild(label);
                imageItemDiv.appendChild(inputGroupDiv);
                newImageUrlContainer.appendChild(imageItemDiv);

                newImageUrlCount++;
                updateNewFieldLabels();
            }

            function updateNewFieldLabels() {
                const newImageItems = newImageUrlContainer.querySelectorAll('.image-item');
                newImageItems.forEach((item, index) => {
                    const label = item.querySelector('label:not(.inline-label)');
                    if (label) {
                         label.textContent = 'New URL ' + (index + 1) + ':';

                    }
                });
            }

            addNewImageUrlButton.addEventListener('click', function() {

                const noMainSelected = !document.querySelector('input[name="mainImageRadio"]:checked');
                addNewImageField('', noMainSelected);
            });


            const existingRadios = document.querySelectorAll('input[name="mainImageRadio"][id^="mainImageRadio_existing_"]');
            let isAnyExistingMain = false;
            existingRadios.forEach(radio => {
                if (radio.checked) {
                    isAnyExistingMain = true;
                }
            });
            if (!isAnyExistingMain && existingRadios.length > 0) {
                existingRadios[0].checked = true; 
            } else if (existingRadios.length === 0) {

            }
        });
    </script>
</body>
</html>