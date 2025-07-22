<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Auto Parts Catalog</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <link rel="stylesheet" href="styles.css">
  <style>
    .catalog-container {
      background-color: var(--bs-dark-accent);
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
      margin: 20px auto;
      padding: 20px;
      max-width: 1200px;
    }

    .table-responsive {
      overflow-x: auto;
    }

    .parts-table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
      font-size: 14px;
      color: #e0e0e0;
    }

    .parts-table th {
      background-color: var(--bs-primary-dark);
      color: white;
      font-weight: 600;
      text-align: center;
      padding: 12px 15px;
      position: sticky;
      top: 0;
    }

    .parts-table td {
      padding: 12px 15px;
      border-bottom: 1px solid var(--bs-gray);
      text-align: center;
    }

    .parts-table tr:nth-child(even) {
      background-color: rgba(30, 30, 30, 0.5);
    }

    .parts-table tr:hover {
      background-color: var(--bs-gray);
    }

    .item-id {
      font-weight: 600;
      color: var(--bs-primary);
    }

    .item-price {
      font-weight: 600;
      color: #4caf50;
    }

    .low-stock {
      color: var(--bs-primary);
      font-weight: 600;
    }

    .make {
      margin: 8px 0 4px 0;
      font-weight: 600;
      color: #e0e0e0;
    }

    .model-year {
      margin: 4px 0 4px 20px;
      color: #cccccc;
    }

    .btn-outline-primary {
      color: var(--bs-primary);
      border-color: var(--bs-primary);
    }

    .btn-outline-primary:hover {
      background-color: var(--bs-primary);
      border-color: var(--bs-primary);
      color: white;
    }

    .btn-outline-danger {
      color: #f44336;
      border-color: #f44336;
    }

    .btn-outline-danger:hover {
      background-color: #f44336;
      border-color: #f44336;
      color: white;
    }

    .catalog-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
      border-bottom: 2px solid var(--bs-primary);
      padding-bottom: 15px;
    }

    .catalog-title {
      color: var(--bs-primary);
      margin: 0;
      font-size: 28px;
    }

    .badge {
      display: inline-block;
      padding: 3px 8px;
      border-radius: 4px;
      font-size: 12px;
      font-weight: 600;
    }

    .badge-category {
      background-color: var(--bs-dark-accent);
      color: var(--bs-primary-light);
      border: 1px solid var(--bs-primary-light);
      font-size: 14px;
    }

    .badge-brand {
      background-color: var(--bs-dark-accent);
      color: var(--bs-primary);
      border: 1px solid var(--bs-primary);
      font-size: 14px;
    }

    .search-input {
      background-color: var(--bs-gray);
      border: none;
      color: #e0e0e0;
      padding: 8px 12px;
      border-radius: 4px 0 0 4px;
    }
    
    .search-input:focus {
	  outline: none;
 	  box-shadow: inset 0 0 0 2px var(--bs-primary); 
/*  	  background-color: #2c2c2c;  */
	}

    .search-button {
      background-color: var(--bs-primary);
      color: white;
      border: none;
      padding: 8px 16px;
      border-radius: 0 4px 4px 0;
      cursor: pointer;
    }

    .search-button:hover {
      background-color: var(--bs-primary-dark);
    }

    .actions-container {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin: 20px 0;
    }

    .create-btn {
      background-color: var(--bs-primary);
      color: white;
      padding: 10px 20px;
      border-radius: 4px;
      border: none;
      font-weight: 600;
      display: flex;
      align-items: center;
      gap: 8px;
      transition: background-color 0.3s;
    }

    .create-btn:hover {
      background-color: var(--bs-primary-dark);
      color: white;
    }
    
    /* Vehicle compatibility container styles */
    .vehicle-compatibility-container {
      max-height: 150px;
      overflow-y: auto;
      border: 1px solid #444;
      border-radius: 4px;
      padding: 8px;
      background-color: rgba(25, 25, 25, 0.6);
      scrollbar-width: thin;
      scrollbar-color: var(--bs-primary) #333;
    }
    
    .vehicle-compatibility-container::-webkit-scrollbar {
      width: 8px;
    }
    
    .vehicle-compatibility-container::-webkit-scrollbar-track {
      background: #333;
      border-radius: 4px;
    }
    
    .vehicle-compatibility-container::-webkit-scrollbar-thumb {
      background-color: var(--bs-primary);
      border-radius: 4px;
    }
    
    .vehicle-make-pill {
      display: inline-block;
      background-color: rgba(40, 40, 40, 0.9);
      border: 1px solid var(--bs-primary);
      border-radius: 4px;
      padding: 3px 8px;
      margin: 3px;
      font-size: 12px;
      color: #e0e0e0;
      cursor: pointer;
    }
    
    .vehicle-make-pill.active {
      background-color: var(--bs-primary);
      color: white;
    }
    
    .vehicle-details {
      padding: 8px 0;
      font-size: 13px;
    }
    
    .compact-make {
      margin: 0;
      font-weight: 600;
      color: #e0e0e0;
      font-size: 13px;
      padding-top: 4px;
      padding-bottom: 2px;
      border-top: 1px solid #444;
    }
    
    .make-details:first-child .compact-make {
      border-top: none;
      padding-top: 0;
    }
    
    .compact-model-year {
      margin: 2px 0 2px 12px;
      color: #cccccc;
      font-size: 12px;
    }
    
    .vehicle-toggle-btn {
      font-size: 12px;
      color: var(--bs-primary);
      background: none;
      border: none;
      padding: 2px 4px;
      cursor: pointer;
      display: inline-flex;
      align-items: center;
      margin-top: 5px;
    }
    
    .vehicle-toggle-btn:hover {
      text-decoration: underline;
    }
    
    .vehicle-count-badge {
      background-color: var(--bs-primary);
      color: white;
      border-radius: 10px;
      padding: 2px 6px;
      font-size: 11px;
      margin-left: 5px;
    }
  </style>
</head>

<body>
  <!-- Header Include -->
  <jsp:include page="/Partials/header.jsp" />

  <div class="main-content py-4">
    <div class="container">
      <div class="catalog-container">
        <div class="catalog-header">
          <h1 class="catalog-title">Auto Parts Catalog</h1>
          <div class="search-container d-flex">
            <input type="text" id="partSearch" placeholder="Search parts..." class="search-input">
            <button class="search-button">
              <i class="fas fa-search"></i> Search
            </button>
          </div>
        </div>

        <div class="actions-container">
          <a href="<%= request.getContextPath() %>/CreateItem" class="create-btn" style="text-decoration: none;">
            <i class="fas fa-plus-circle"></i> Create New Item
          </a>
        </div>

        <div class="table-responsive">
          <table class="parts-table">
            <thead>
              <tr>
                <th>ID</th>
                <th>Part Name</th>
                <th>Brand</th>
                <th>Category</th>
                <th>Price</th>
                <th>Stocks</th>
                <th>Compatible Vehicles</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="item" items="${itemList}">
                <tr data-item-id="${item.itemId}" style="cursor: pointer;">
                  <td><span class="item-id">#<c:out value="${item.itemId}" /></span></td>
                  <td style="font-weight: bold;"><c:out value="${item.itemName}" /></td>
                  <td><span class="badge badge-brand"><c:out value="${item.itemBrand}" /></span></td>
                  <td><span class="badge badge-category"><c:out value="${item.itemCategory}" /></span></td>
                  <td><span class="item-price">$<c:out value="${item.itemPrice}" /></span></td>
                  <td>
                    <c:choose>
                      <c:when test="${item.itemStocks < 5}">
                        <span class="low-stock"><c:out value="${item.itemStocks}" /></span>
                      </c:when>
                      <c:otherwise>
                        <c:out value="${item.itemStocks}" />
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td>
                    <div class="vehicle-compatibility-container" id="vehicle-container-${item.itemId}">
                      <div class="vehicle-makes-filter" id="makes-filter-${item.itemId}">
                        <!-- Make pills will be populated via JavaScript -->
                      </div>
                      <div class="vehicle-details" id="vehicle-details-${item.itemId}">
                        <c:forEach var="makeEntry" items="${item.index.entrySet()}">
                          <div class="make-details" data-make="${makeEntry.key}">
                            <div class="compact-make">
                              <c:out value="${makeEntry.key}" />
                            </div>
                            <c:forEach var="modelMap" items="${makeEntry.value}">
                              <c:forEach var="modelEntry" items="${modelMap.entrySet()}">
                                <div class="compact-model-year">
                                  <c:out value="${modelEntry.key}" />: 
                                  <script>
                                    (function() {
                                      // Convert the years to an array of numbers for processing
                                      const years = [
                                        <c:forEach var="year" items="${modelEntry.value}" varStatus="status">
                                          ${year}<c:if test="${!status.last}">,</c:if>
                                        </c:forEach>
                                      ].sort((a, b) => a - b); // Sort numerically
                                      
                                      if (years.length === 0) {
                                        document.write("N/A");
                                      } else {
                                        let result = [];
                                        let rangeStart = years[0];
                                        let rangeEnd = years[0];
                                        
                                        // Process each year to find sequences
                                        for (let i = 1; i < years.length; i++) {
                                          if (years[i] === rangeEnd + 1) {
                                            // Continue the current range
                                            rangeEnd = years[i];
                                          } else {
                                            // Add the completed range to results
                                            if (rangeStart === rangeEnd) {
                                              result.push(rangeStart);
                                            } else {
                                              result.push(rangeStart + " - " + rangeEnd);
                                            }
                                            // Start a new range
                                            rangeStart = rangeEnd = years[i];
                                          }
                                        }
                                        
                                        // Add the last range
                                        if (rangeStart === rangeEnd) {
                                          result.push(rangeStart);
                                        } else {
                                          result.push(rangeStart + " - " + rangeEnd);
                                        }
                                        
                                        document.write(result.join(", "));
                                      }
                                    })();
                                  </script>
                                </div>
                              </c:forEach>
                            </c:forEach>
                          </div>
                        </c:forEach>
                      </div>
                    </div>
                  </td>
                  <td>
                    <div class="d-flex gap-2">
                      <button class="btn btn-sm btn-outline-primary" onclick="editItem(${item.itemId})">
                        <i class="fas fa-edit"></i> Edit
                      </button>
                      <button class="btn btn-sm btn-outline-danger" onclick="deleteItem(${item.itemId})">
                        <i class="fas fa-trash"></i> Delete
                      </button>
                    </div>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

  <!-- Update Item Modal -->
  <div class="modal fade" id="updateItemModal" tabindex="-1" aria-labelledby="updateItemModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content bg-dark text-light">
        <div class="modal-header border-bottom border-primary">
          <h5 class="modal-title text-primary" id="updateItemModalLabel">Update Item</h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <form id="updateItemForm" action="/spareiT/UpdateItem" method="post">
            <input type="hidden" id="edit-itemId" name="itemId">
            
            <div class="mb-3">
              <label for="edit-itemName" class="form-label">Part Name</label>
              <input type="text" class="form-control bg-gray text-light" id="edit-itemName" name="itemName" required>
            </div>
            
            <div class="mb-3">
            <label for="edit-itemBrand" class="form-label">Brand&nbsp;</label>
            <span id="edit-itemBrandBadge" class="badge badge-brand">BrandName</span>
            <input type="hidden" id="edit-itemBrand" name="itemBrand">
            <label for="edit-itemCategory" class="form-label">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Category&nbsp;</label>
            <span id="edit-itemCategoryBadge" class="badge badge-category">CategoryName</span>
            <input type="hidden" id="edit-itemCategory" name="itemCategory">
            </div>
          
            <div class="mb-3">
            
            </div>

            
            <div class="mb-3">
              <label for="edit-itemPrice" class="form-label">Price ($)</label>
              <input type="number" step="0.01" class="form-control bg-gray text-light" id="edit-itemPrice" name="itemPrice" required>
            </div>
            
            <div class="mb-3">
              <label for="edit-itemStocks" class="form-label">Stock Quantity</label>
              <input type="number" class="form-control bg-gray text-light" id="edit-itemStocks" name="itemStocks" required>
            </div>
            
            <div class="d-flex justify-content-end gap-2 mt-4">
              <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
              <button type="submit" class="btn btn-primary">Save Changes</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>

  <!-- Footer Include -->
  <jsp:include page="/Partials/footer.jsp" />
  
  <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

  <script>
    document.addEventListener("DOMContentLoaded", function () {
      // Handle row click for viewing item details
      document.querySelectorAll("tr[data-item-id]").forEach(function (row) {
        row.addEventListener("click", function (event) {
          // Prevent redirect if a button or inside a button is clicked
          if (
            event.target.closest("button") ||
            event.target.closest("a") ||
            event.target.tagName === "BUTTON" ||
            event.target.closest(".vehicle-compatibility-container")
          ) {
            return;
          }
  
          const itemId = this.dataset.itemId;
          // Redirect to the desired URL
          window.location.href = `<%= request.getContextPath() %>/GetItemById?itemId=`+itemId;
        });
      });
      
      // Initialize vehicle compatibility filters for each item
      document.querySelectorAll("tr[data-item-id]").forEach(function (row) {
        const itemId = row.dataset.itemId;
        initializeVehicleFilter(itemId);
      });
    });
    
    // Function to initialize vehicle make filters
    function initializeVehicleFilter(itemId) {
      const container = document.getElementById(`vehicle-container-${itemId}`);
      const makesFilter = document.getElementById(`makes-filter-${itemId}`);
      const detailsContainer = document.getElementById(`vehicle-details-${itemId}`);
      
      // Get all make elements
      const makeElements = detailsContainer.querySelectorAll('.make-details');
      const makeCount = makeElements.length;
      
      if (makeCount === 0) return;
      
      // Create "All" button
      const allBtn = document.createElement('span');
      allBtn.className = 'vehicle-make-pill active';
      allBtn.dataset.make = 'all';
      allBtn.textContent = 'All';
      allBtn.appendChild(document.createElement('span')).className = 'vehicle-count-badge';
      allBtn.querySelector('.vehicle-count-badge').textContent = makeCount;
      makesFilter.appendChild(allBtn);
      
      // Create make filter pills
      makeElements.forEach(makeEl => {
        const makeName = makeEl.dataset.make;
        const pill = document.createElement('span');
        pill.className = 'vehicle-make-pill';
        pill.dataset.make = makeName;
        pill.textContent = makeName;
        makesFilter.appendChild(pill);
      });
      
      // Add click event to filter pills
      makesFilter.querySelectorAll('.vehicle-make-pill').forEach(pill => {
        pill.addEventListener('click', function() {
          // Update active state
          makesFilter.querySelectorAll('.vehicle-make-pill').forEach(p => p.classList.remove('active'));
          this.classList.add('active');
          
          const selectedMake = this.dataset.make;
          
          // Show/hide makes based on selection
          if (selectedMake === 'all') {
            makeElements.forEach(el => el.style.display = '');
          } else {
            makeElements.forEach(el => {
              el.style.display = (el.dataset.make === selectedMake) ? '' : 'none';
            });
          }
        });
      });
    }
    
    // Simple search functionality
    document.getElementById('partSearch').addEventListener('keyup', function() {
      const searchText = this.value.toLowerCase();
      const rows = document.querySelectorAll('.parts-table tbody tr');
      
      rows.forEach(row => {
        const text = row.textContent.toLowerCase();
        if(text.includes(searchText)) {
          row.style.display = '';
        } else {
          row.style.display = 'none';
        }
      });
    });
    
    function deleteItem(itemId) {
      console.log(itemId);
      if(confirm(`Are you sure you want to delete item #`+itemId+`?`)) {
        console.log("itemId:", itemId, "| typeof:", typeof itemId, "| toString:", String(itemId));
        fetch(`/spareiT/DeleteItem?itemId=`+itemId, { method: 'POST' })
          .then(data => {
            document.querySelector(`tr[data-item-id="`+itemId+`"]`).remove();
          });
      }
    }

    function editItem(itemId) {
      // Fetch the item data
      const row = document.querySelector(`tr[data-item-id="`+itemId+`"]`);
      
      if (!row) {
        console.error(`Item with ID `+itemId+` not found`);
        return;
      }
      
      // Extract data from the row
      const itemName = row.cells[1].textContent.trim();
      const itemBrand = row.querySelector('.badge-brand').textContent.trim();
      const itemCategory = row.querySelector('.badge-category').textContent.trim();
      const itemPrice = row.querySelector('.item-price').textContent.trim().replace('$', '');
      const itemStocks = row.cells[5].textContent.trim();
      
      // Fill the form with the extracted data
      document.getElementById('edit-itemId').value = itemId;
      document.getElementById('edit-itemName').value = itemName;
      document.getElementById('edit-itemBrand').value = itemBrand;
      document.getElementById('edit-itemBrandBadge').textContent = itemBrand;
      document.getElementById('edit-itemCategory').value = itemCategory;
      document.getElementById('edit-itemCategoryBadge').textContent = itemCategory;
      document.getElementById('edit-itemPrice').value = itemPrice;
      document.getElementById('edit-itemStocks').value = itemStocks;
      
      // Show the modal
      const updateModal = new bootstrap.Modal(document.getElementById('updateItemModal'));
      updateModal.show();
    }
    
    // Update Form submission handler
    document.getElementById('updateItemForm').addEventListener('submit', function(e) {
      e.preventDefault();
      
      const formData = new FormData(this);
      const itemId = formData.get('itemId');
      const itemName = formData.get('itemName');
      const itemBrand = formData.get('itemBrand');
      const itemCategory = formData.get('itemCategory');
      const itemPrice = formData.get('itemPrice');
      const itemStocks = formData.get('itemStocks');
      
      fetch(`/spareiT/UpdateItem?itemId=`+itemId+`&itemName=`+itemName+`&itemBrand=`+itemBrand+`&itemCategory=`+itemCategory+`&itemPrice=`+itemPrice+`&itemStocks=`+itemStocks, {
        method: 'POST',
      })
      .then(response => {
        if (response.ok) {
          // Close the modal
          const modal = bootstrap.Modal.getInstance(document.getElementById('updateItemModal'));
          modal.hide();
          
          // Update the row in the table with new values
          const row = document.querySelector(`tr[data-item-id="`+itemId+`"]`);
          if (row) {
            row.cells[1].textContent = itemName;
            row.cells[4].innerHTML = `<span class="item-price">$`+itemPrice+`</span>`; // Preserve the price formatting
            row.cells[5].textContent = itemStocks;
            
            if (itemStocks < 5) {
                row.cells[5].innerHTML = `<span class="low-stock">`+itemStocks+`</span>`;
            }
          }
        } else {
          alert('Error updating item. Please try again.');
        }
      })
      .catch(error => {
        console.error('Error:', error);
        alert('Error updating item. Please try again.');
      });
    });
  </script>
</body>

</html>