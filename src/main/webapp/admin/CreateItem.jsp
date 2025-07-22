<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
@SuppressWarnings("unchecked")
List<String> categories = (List<String>)request.getAttribute("categories");
@SuppressWarnings("unchecked")
List<Map<String, Object>> makes = (List<Map<String, Object>>)request.getAttribute("makes");
@SuppressWarnings("unchecked")
List<Map<String, Object>> models = (List<Map<String, Object>>)request.getAttribute("models");
@SuppressWarnings("unchecked")
List<Map<String, Object>> years = (List<Map<String, Object>>)request.getAttribute("years");
int nextItemId = (int)request.getAttribute("nextItemId");
%>

<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Create New Auto Part</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <link rel="stylesheet" href="styles.css">
  <style>
    /* Specific create item page styles with dark theme */
    .form-container {
      background-color: var(--bs-dark-accent);
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
      margin: 20px auto;
      padding: 20px;
      max-width: 900px;
    }

    .form-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
      border-bottom: 2px solid var(--bs-primary);
      padding-bottom: 15px;
    }

    .form-title {
      color: var(--bs-primary);
      margin: 0;
      font-size: 28px;
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-label {
      color: #e0e0e0;
      font-weight: 600;
      display: block;
      margin-bottom: 5px;
    }

    .form-control, .form-select {
      background-color: var(--bs-gray);
      border: none;
      color: #e0e0e0;
      padding: 10px 12px;
      border-radius: 4px;
    }

    .form-select option {
      background-color: var(--bs-gray);
      color: #e0e0e0;
    }

    .btn-primary {
      background-color: var(--bs-primary);
      border-color: var(--bs-primary);
      padding: 10px 20px;
      font-weight: 600;
    }

    .btn-primary:hover {
      background-color: var(--bs-primary-dark);
      border-color: var(--bs-primary-dark);
    }

    .compatibility-section {
      background-color: rgba(30, 30, 30, 0.6);
      border-radius: 6px;
      padding: 15px;
      margin-bottom: 15px;
      border-left: 3px solid var(--bs-primary);
    }

    .compatibility-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 10px;
    }

    .compatibility-title {
      color: var(--bs-primary);
      font-size: 18px;
      margin: 0;
    }

    .btn-remove {
      background-color: rgba(244, 67, 54, 0.8);
      color: white;
      border: none;
      padding: 4px 10px;
      border-radius: 4px;
      font-size: 14px;
    }

    .btn-remove:hover {
      background-color: rgba(244, 67, 54, 1);
    }

    .btn-add {
      background-color: var(--bs-primary);
      color: white;
      border: none;
      padding: 6px 12px;
      border-radius: 4px;
      margin-top: 10px;
      font-weight: 600;
      display: flex;
      align-items: center;
      gap: 5px;
    }

    .btn-add:hover {
      background-color: var(--bs-primary-dark);
    }

    .info-text {
      color: var(--bs-lighter-gray);
      font-size: 14px;
      margin-top: 5px;
    }

    .make-model-year {
      display: grid;
      grid-template-columns: 1fr 1fr 1fr;
      gap: 15px;
    }

    @media (max-width: 768px) {
      .make-model-year {
        grid-template-columns: 1fr;
      }
    }

    select[multiple] {
      height: 120px;
    }

    .action-buttons {
      display: flex;
      justify-content: center;
      gap: 15px;
      margin-top: 30px;
    }

    .btn-secondary {
      background-color: var(--bs-light-gray);
      border-color: var(--bs-light-gray);
      color: white;
      padding: 10px 20px;
      font-weight: 600;
    }

    .btn-secondary:hover {
      background-color: var(--bs-lighter-gray);
      border-color: var(--bs-lighter-gray);
    }
    
	    /* Additional styles for the improved compatibility section */
	.year-checkbox-container {
	  max-height: 150px;
	  overflow-y: auto;
	  padding: 10px;
	  background-color: var(--bs-gray);
	  border-radius: 4px;
	  margin-bottom: 5px;
	}
	
	.year-checkbox-container .form-check {
	  margin-bottom: 5px;
	}
	
	.year-checkbox-container .form-check-label {
	  color: #e0e0e0;
	  margin-left: 5px;
	}
	
	.selected-years-count {
	  font-size: 13px;
	  font-weight: 500;
	  margin-top: 5px;
	}
	
	/* Add a separator between the select all and the grid */
	.year-checkbox-container > div:first-child {
	  padding-bottom: 8px;
	  margin-bottom: 8px;
	  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
	}
	
	/* Ensure the year checkboxes stay visible */
	.form-check-input:checked {
	  background-color: var(--bs-primary);
	  border-color: var(--bs-primary);
	}
	
	/* Make the select all option more prominent */
	#year_container_selectors .form-check-input {
	  margin-right: 8px;
	}
  </style>
</head>

<body>
  <!-- Header Include -->
  <jsp:include page="/Partials/header.jsp" />

  <div class="main-content py-4">
    <div class="container">
      <div class="form-container">
        <div class="form-header">
          <h1 class="form-title">Create New Auto Part</h1>
          <div>
            <a href="<%= request.getContextPath() %>/GetAllItems" class="btn btn-outline-primary">
              <i class="fas fa-arrow-left"></i> Back to Catalog
            </a>
          </div>
        </div>

        <form action="<%= request.getContextPath() %>/CreateItem" method="POST">
          <input type="hidden" name="itemId" value="<%= nextItemId %>">
          
          <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label for="itemName" class="form-label">Part Name</label>
                <input type="text" id="itemName" name="itemName" class="form-control" required>
              </div>
            </div>
            <div class="col-md-6">
              <div class="form-group">
                <label for="itemBrand" class="form-label">Brand</label>
                <input type="text" id="itemBrand" name="itemBrand" class="form-control" required>
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-md-4">
              <div class="form-group">
                <label for="itemCategory" class="form-label">Category</label>
                <select id="itemCategory" name="itemCategory" class="form-select" required>
                  <option value="">Select a category</option>
                  <c:forEach var="category" items="${categories}">
                    <option value="${category}">${category}</option>
                  </c:forEach>
                </select>
              </div>
            </div>
            <div class="col-md-4">
              <div class="form-group">
                <label for="itemPrice" class="form-label">Price ($)</label>
                <input type="number" id="itemPrice" name="itemPrice" class="form-control" step="0.01" min="0" required>
              </div>
            </div>
            <div class="col-md-4">
              <div class="form-group">
                <label for="itemStocks" class="form-label">Stock</label>
                <input type="number" id="itemStocks" name="itemStocks" class="form-control" min="0" required>
              </div>
            </div>
          </div>

          <div class="form-group mt-4">
            <label class="form-label">Compatible Vehicles</label>
            <div id="compatibilityContainer">
              <!-- Compatibility sections will be added here -->
            </div>
            <input type="hidden" id="compatCount" name="compatCount" value="0">
            <button type="button" class="btn-add" onclick="addCompatibility()">
              <i class="fas fa-plus-circle"></i> Add Compatible Vehicle
            </button>
            <p class="info-text">Add the vehicle makes, models, and years this part is compatible with.</p>
          </div>

          <div class="action-buttons">
            <button type="button" class="btn btn-secondary" onclick="window.location.href='<%= request.getContextPath() %>/GetAllItems'">
              Cancel
            </button>
            <button type="submit" class="btn btn-primary">
              <i class="fas fa-save"></i> Create Item
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <!-- Footer Include -->
  <jsp:include page="/Partials/footer.jsp" />
  
  <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

  <script>
  function updateHiddenYearInputs(sectionId, selectedYears) {
	    // Find or create container for hidden inputs
	    let hiddenInputsContainer = document.getElementById('hidden_years_container_' + sectionId);
	    if (!hiddenInputsContainer) {
	        hiddenInputsContainer = document.createElement('div');
	        hiddenInputsContainer.id = 'hidden_years_container_' + sectionId;
	        hiddenInputsContainer.style.display = 'none';
	        
	        const parentSection = document.getElementById('compat_' + sectionId);
	        if (parentSection) {
	            parentSection.appendChild(hiddenInputsContainer);
	        }
	    }
	    
	    // Clear existing hidden inputs
	    hiddenInputsContainer.innerHTML = '';
	    
	    // Create a hidden input for each selected year
	    // This matches the backend's expectation for req.getParameterValues("years_" + i + "[]")
	    selectedYears.forEach(yearId => {
	        const hiddenInput = document.createElement('input');
	        hiddenInput.type = 'hidden';
	        hiddenInput.name = 'years_' + sectionId + '[]';
	        hiddenInput.value = yearId;
	        hiddenInputsContainer.appendChild(hiddenInput);
	    });
	}function updateYearSelectionAfterSelectAll(sectionId) {
	    const yearContainer = document.getElementById('year_container_' + sectionId);
	    const checkboxes = yearContainer.querySelectorAll('input[type="checkbox"]:not(#select_all_years_' + sectionId + ')');
	    
	    // Get all selected year IDs
	    const selectedYears = Array.from(checkboxes)
	        .filter(cb => cb.checked)
	        .map(cb => cb.value);
	    
	    // Create hidden inputs for each selected year to match backend's expectation
	    updateHiddenYearInputs(sectionId, selectedYears);
	    
	    // Update select all checkbox state
	    const selectAllCheckbox = document.getElementById('select_all_years_' + sectionId);
	    if (selectAllCheckbox) {
	        selectAllCheckbox.checked = selectedYears.length === checkboxes.length && checkboxes.length > 0;
	        selectAllCheckbox.indeterminate = selectedYears.length > 0 && selectedYears.length < checkboxes.length;
	    }
	    
	    // Display selected years count
	    updateSelectedYearsCount(sectionId);
	}// Store all database info in JavaScript variables
	const makes = [
	<% for (int i = 0; i < makes.size(); i++) {
	Map<String, Object> make = makes.get(i);
	%>
	{
	makeId: <%= make.get("makeId") %>,
	makeName: "<%= make.get("makeName").toString().replace("\"", "\\\"") %>"
	}<%= (i < makes.size() - 1) ? "," : "" %>
	<% } %>
	];

	const models = [
	<% for (int i = 0; i < models.size(); i++) {
	Map<String, Object> model = models.get(i);
	%>
	{
	modelId: <%= model.get("modelId") %>,
	modelName: "<%= model.get("modelName").toString().replace("\"", "\\\"") %>",
	makeId: <%= model.get("makeId") %>
	}<%= (i < models.size() - 1) ? "," : "" %>
	<% } %>
	];

	const years = [
	<% for (int i = 0; i < years.size(); i++) {
	Map<String, Object> year = years.get(i);
	%>
	{
	yearId: <%= year.get("yearId") %>,
	year: <%= year.get("year") %>,
	modelId: <%= year.get("modelId") %>
	}<%= (i < years.size() - 1) ? "," : "" %>
	<% } %>
	];

	// Debug function to help troubleshoot
	function debugData() {
	    console.log("Makes:", makes);
	    console.log("Models:", models);
	    console.log("Years:", years);
	}

	// Call debug function when page loads
	window.onload = debugData;

	let compatibilityCounter = 0;

	function addCompatibility() {
	    compatibilityCounter++;
	    let x = compatibilityCounter;
	    const container = document.getElementById('compatibilityContainer');

	    const compatDiv = document.createElement('div');
	    compatDiv.className = 'compatibility-section';
	    compatDiv.id = 'compat_' + x;

	    // Header with section number and remove button
	    const headerDiv = document.createElement('div');
	    headerDiv.className = 'compatibility-header';

	    const titleSpan = document.createElement('h4');
	    titleSpan.className = 'compatibility-title';
	    titleSpan.textContent = 'Vehicle ' + x;

	    const removeButton = document.createElement('button');
	    removeButton.type = 'button';
	    removeButton.className = 'btn-remove';
	    removeButton.innerHTML = '<i class="fas fa-trash"></i> Remove';
	    removeButton.addEventListener('click', function() {
	        removeCompatibility(x);
	    });

	    headerDiv.appendChild(titleSpan);
	    headerDiv.appendChild(removeButton);
	    compatDiv.appendChild(headerDiv);

	    // Make, Model, Year in a grid layout
	    const mmyDiv = document.createElement('div');
	    mmyDiv.className = 'make-model-year';

	    // Make dropdown
	    const makeDiv = document.createElement('div');
	    makeDiv.className = 'form-group';

	    const makeLabel = document.createElement('label');
	    makeLabel.setAttribute('for', 'make_' + x);
	    makeLabel.className = 'form-label';
	    makeLabel.textContent = 'Make';

	    const makeSelect = document.createElement('select');
	    makeSelect.id = 'make_' + x;
	    makeSelect.name = 'make_' + x;
	    makeSelect.className = 'form-select';
	    makeSelect.required = true;

	    // Add empty option
	    const emptyOption = document.createElement('option');
	    emptyOption.value = '';
	    emptyOption.textContent = 'Select a make';
	    makeSelect.appendChild(emptyOption);

	    // Add makes from database
	    makes.forEach(make => {
	        const option = document.createElement('option');
	        option.value = make.makeId;
	        option.textContent = make.makeName;
	        makeSelect.appendChild(option);
	    });

	    makeDiv.appendChild(makeLabel);
	    makeDiv.appendChild(makeSelect);

	    // Model dropdown
	    const modelDiv = document.createElement('div');
	    modelDiv.className = 'form-group';

	    const modelLabel = document.createElement('label');
	    modelLabel.setAttribute('for', 'model_' + x);
	    modelLabel.className = 'form-label';
	    modelLabel.textContent = 'Model';

	    const modelSelect = document.createElement('select');
	    modelSelect.id = 'model_' + x;
	    modelSelect.name = 'model_' + x;
	    modelSelect.className = 'form-select';
	    modelSelect.required = true;
	    modelSelect.disabled = true;

	    // Empty option
	    const emptyModelOption = document.createElement('option');
	    emptyModelOption.value = '';
	    emptyModelOption.textContent = 'Select a model';
	    modelSelect.appendChild(emptyModelOption);

	    modelDiv.appendChild(modelLabel);
	    modelDiv.appendChild(modelSelect);

	    // Year selection - replace multiple select with checkboxes
	    const yearDiv = document.createElement('div');
	    yearDiv.className = 'form-group';

	    const yearLabel = document.createElement('label');
	    yearLabel.className = 'form-label';
	    yearLabel.textContent = 'Years (select all that apply)';
	    
	    const yearContainer = document.createElement('div');
	    yearContainer.id = 'year_container_' + x;
	    yearContainer.className = 'year-checkbox-container';
	    yearContainer.style.maxHeight = '150px';
	    yearContainer.style.overflowY = 'auto';
	    yearContainer.style.padding = '8px';
	    yearContainer.style.backgroundColor = 'var(--bs-gray)';
	    yearContainer.style.borderRadius = '4px';
	    
	    // Hidden input to store selected years
	    const yearHiddenInput = document.createElement('input');
	    yearHiddenInput.type = 'hidden';
	    yearHiddenInput.id = 'years_hidden_' + x;
	    yearHiddenInput.name = 'years_' + x + '[]';
	    yearHiddenInput.required = true;
	    
	    yearDiv.appendChild(yearLabel);
	    yearDiv.appendChild(yearContainer);
	    yearDiv.appendChild(yearHiddenInput);

	    // Hidden input for compatibility ID
	    const hiddenInput = document.createElement('input');
	    hiddenInput.type = 'hidden';
	    hiddenInput.name = 'compatId_' + x;
	    hiddenInput.id = 'compatId_' + x;

	    // Add all elements to the container
	    mmyDiv.appendChild(makeDiv);
	    mmyDiv.appendChild(modelDiv);
	    mmyDiv.appendChild(yearDiv);
	    compatDiv.appendChild(mmyDiv);
	    compatDiv.appendChild(hiddenInput);

	    container.appendChild(compatDiv);

	    // Add change event to populate models
	    makeSelect.addEventListener('change', function() {
	        populateModels(this.value, x);
	    });

	    // Update compatibility count
	    document.getElementById('compatCount').value = compatibilityCounter;

	    // Log for debugging
	    console.log("Added compatibility section:", x);
	}

	function populateModels(makeId, sectionId) {
	    console.log("Populating models for make ID:", makeId, "in section:", sectionId);

	    const modelSelect = document.getElementById('model_' + sectionId);
	    const yearContainer = document.getElementById('year_container_' + sectionId);

	    if (!modelSelect) {
	        console.error("Model select element not found:", 'model_' + sectionId);
	        return;
	    }

	    // Clear existing options
	    modelSelect.innerHTML = '';
	    if (yearContainer) {
	        yearContainer.innerHTML = '';
	    }

	    // Add empty option
	    const emptyOption = document.createElement('option');
	    emptyOption.value = '';
	    emptyOption.textContent = 'Select a model';
	    modelSelect.appendChild(emptyOption);

	    // Filter models for the selected make
	    const filteredModels = models.filter(model => model.makeId == makeId);
	    console.log("Filtered models:", filteredModels);

	    // Add filtered models to dropdown
	    filteredModels.forEach(model => {
	        const option = document.createElement('option');
	        option.value = model.modelId;
	        option.textContent = model.modelName;
	        modelSelect.appendChild(option);
	    });

	    // Enable model dropdown
	    modelSelect.disabled = false;

	    // Add change event to populate years
	    modelSelect.onchange = function() {
	        populateYears(this.value, sectionId);
	    };
	}

	function populateYears(modelId, sectionId) {
	    console.log("Populating years for model ID:", modelId, "in section:", sectionId);

	    const yearContainer = document.getElementById('year_container_' + sectionId);
	    const yearHiddenInput = document.getElementById('years_hidden_' + sectionId);

	    if (!yearContainer) {
	        console.error("Year container element not found:", 'year_container_' + sectionId);
	        return;
	    }

	    // Clear existing options
	    yearContainer.innerHTML = '';
	    yearHiddenInput.value = '';

	    // Filter years for the selected model
	    const filteredYears = years.filter(year => year.modelId == modelId);
	    console.log("Filtered years:", filteredYears);

	    // Sort years in descending order
	    filteredYears.sort((a, b) => b.year - a.year);

	    // Create a set to track unique years to prevent duplicates
	    const addedYears = new Set();
	    const uniqueYears = [];

	    // Filter unique years
	    filteredYears.forEach(year => {
	        if (!addedYears.has(year.year)) {
	            addedYears.add(year.year);
	            uniqueYears.push(year);
	        }
	    });

	    // Add year checkboxes
	    if (uniqueYears.length > 0) {
	        // Create Select All option
	        const selectAllDiv = document.createElement('div');
	        selectAllDiv.className = 'mb-2';
	        
	        const selectAllCheckbox = document.createElement('input');
	        selectAllCheckbox.type = 'checkbox';
	        selectAllCheckbox.id = 'select_all_years_' + sectionId;
	        selectAllCheckbox.className = 'form-check-input me-2';
	        
	        const selectAllLabel = document.createElement('label');
	        selectAllLabel.htmlFor = 'select_all_years_' + sectionId;
	        selectAllLabel.className = 'form-check-label';
	        selectAllLabel.textContent = 'Select All Years';
	        
	        selectAllDiv.appendChild(selectAllCheckbox);
	        selectAllDiv.appendChild(selectAllLabel);
	        yearContainer.appendChild(selectAllDiv);
	        
	        // Add event listener for select all
	        selectAllCheckbox.addEventListener('change', function() {
	            const isChecked = this.checked;
	            const checkboxes = yearContainer.querySelectorAll('input[type="checkbox"]:not(#select_all_years_' + sectionId + ')');
	            
	            checkboxes.forEach(checkbox => {
	                checkbox.checked = isChecked;
	            });
	            
	            // Update hidden input after changing all checkboxes
	            updateYearSelectionAfterSelectAll(sectionId);
	        });
	        
	        // Create a flex container for checkboxes
	        const checkboxGrid = document.createElement('div');
	        checkboxGrid.style.display = 'grid';
	        checkboxGrid.style.gridTemplateColumns = 'repeat(3, 1fr)';
	        checkboxGrid.style.gap = '8px';
	        yearContainer.appendChild(checkboxGrid);

	        uniqueYears.forEach(year => {
	            const checkboxDiv = document.createElement('div');
	            checkboxDiv.className = 'form-check';
	            
	            const checkbox = document.createElement('input');
	            checkbox.type = 'checkbox';
	            checkbox.className = 'form-check-input';
	            checkbox.id = 'year_checkbox_' + sectionId + '_' + year.yearId;
	            checkbox.value = year.yearId;
	            checkbox.dataset.year = year.year;
	            
	            const label = document.createElement('label');
	            label.htmlFor = 'year_checkbox_' + sectionId + '_' + year.yearId;
	            label.className = 'form-check-label';
	            label.textContent = year.year;
	            
	            checkbox.addEventListener('change', function() {
	                updateYearSelection(this, sectionId);
	            });
	            
	            checkboxDiv.appendChild(checkbox);
	            checkboxDiv.appendChild(label);
	            checkboxGrid.appendChild(checkboxDiv);
	        });
	    } else {
	        const noYearsMsg = document.createElement('p');
	        noYearsMsg.className = 'text-center text-warning';
	        noYearsMsg.textContent = 'No years available for this model';
	        yearContainer.appendChild(noYearsMsg);
	        console.warn("No years found for model ID:", modelId);
	    }
	}

	function updateYearSelection(checkbox, sectionId) {
	    const yearHiddenInput = document.getElementById('years_hidden_' + sectionId);
	    const yearContainer = document.getElementById('year_container_' + sectionId);
	    const checkboxes = yearContainer.querySelectorAll('input[type="checkbox"]:not(#select_all_years_' + sectionId + ')');
	    
	    // Get all selected year IDs
	    const selectedYears = Array.from(checkboxes)
	        .filter(cb => cb.checked)
	        .map(cb => cb.value);
	    
	    // Create hidden inputs for each selected year to match backend's expectation
	    updateHiddenYearInputs(sectionId, selectedYears);
	    
	    // Update select all checkbox state
	    const selectAllCheckbox = document.getElementById('select_all_years_' + sectionId);
	    if (selectAllCheckbox) {
	        selectAllCheckbox.checked = selectedYears.length === checkboxes.length && checkboxes.length > 0;
	        selectAllCheckbox.indeterminate = selectedYears.length > 0 && selectedYears.length < checkboxes.length;
	    }
	    
	    // Display selected years count
	    updateSelectedYearsCount(sectionId);
	}

	function updateSelectedYearsCount(sectionId) {
	    const yearContainer = document.getElementById('year_container_' + sectionId);
	    const checkboxes = yearContainer.querySelectorAll('input[type="checkbox"]:not(#select_all_years_' + sectionId + ')');
	    const selectedCount = Array.from(checkboxes).filter(cb => cb.checked).length;
	    
	    // Find or create the count element
	    let countElement = document.getElementById('selected_years_count_' + sectionId);
	    if (!countElement) {
	        countElement = document.createElement('div');
	        countElement.id = 'selected_years_count_' + sectionId;
	        countElement.className = 'selected-years-count mt-2 text-primary';
	        yearContainer.parentNode.insertBefore(countElement, yearContainer.nextSibling);
	    }
	    
	    // Update the count message
	    if (selectedCount > 0) {
	        countElement.textContent = selectedCount + ' year' + (selectedCount > 1 ? 's' : '') + ' selected';
	    } else {
	        countElement.textContent = 'No years selected';
	    }
	}

	function removeCompatibility(id) {
	    console.log("Removing compatibility section:", id);
	    const element = document.getElementById('compat_' + id);
	    if (element) {
	        element.remove();

	        const container = document.getElementById('compatibilityContainer');
	        const remainingSections = container.getElementsByClassName('compatibility-section');

	        document.getElementById('compatCount').value = remainingSections.length;
	    } else {
	        console.error("Element not found: compat_" + id);
	    }
	}
  </script>
</body>

</html>