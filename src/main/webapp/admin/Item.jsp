<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Item Details - Auto Parts</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <link rel="stylesheet" href="styles.css">
  <style>
    /* Item details specific styles */
    .details-container {
      background-color: var(--bs-dark-accent);
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
      margin: 20px auto;
      padding: 20px;
      max-width: 1000px;
    }

    .details-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
      border-bottom: 2px solid var(--bs-primary);
      padding-bottom: 15px;
    }

    .details-title {
      color: var(--bs-primary);
      margin: 0;
      font-size: 28px;
    }

    .item-info-row {
      display: flex;
      margin-bottom: 20px;
    }

    .item-image-container {
      width: 300px;
      height: 300px;
      background-color: var(--bs-gray);
      border-radius: 8px;
      overflow: hidden;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-right: 30px;
    }
    
    .item-image {
      width: 100%;
      height: 100%;
      object-fit: contain;
      border-radius: 8px;
    }

    .item-image-placeholder {
      font-size: 100px;
      color: var(--bs-dark-accent);
    }

    .item-details {
      flex: 1;
    }

    .item-category-badges {
      display: flex;
      gap: 10px;
      margin-bottom: 15px;
    }

    .badge {
      display: inline-block;
      padding: 6px 12px;
      border-radius: 4px;
      font-size: 14px;
      font-weight: 600;
    }

    .badge-category {
      background-color: var(--bs-dark-accent);
      color: var(--bs-primary-light);
      border: 1px solid var(--bs-primary-light);
    }

    .badge-brand {
      background-color: var(--bs-dark-accent);
      color: var(--bs-primary);
      border: 1px solid var(--bs-primary);
    }

    .item-name {
      font-size: 32px;
      color: #e0e0e0;
      margin-bottom: 10px;
    }

    .item-id {
      font-size: 16px;
      color: var(--bs-lighter-gray);
      margin-bottom: 20px;
    }

    .item-price {
      font-size: 28px;
      color: #4caf50;
      font-weight: 600;
      margin-bottom: 15px;
    }

    .stock-container {
      display: flex;
      align-items: center;
      margin-bottom: 20px;
    }

    .stock-label {
      margin-right: 10px;
      color: #cccccc;
    }

    .stock-value {
      font-size: 18px;
      font-weight: 600;
    }

    .low-stock {
      color: var(--bs-primary);
    }

    .info-section {
      background-color: rgba(30, 30, 30, 0.5);
      border-radius: 8px;
      padding: 20px;
      margin-bottom: 20px;
    }

    .section-title {
      font-size: 20px;
      color: var(--bs-primary);
      margin-bottom: 15px;
      border-bottom: 1px solid var(--bs-light-gray);
      padding-bottom: 8px;
    }

    .vehicle-make {
      margin: 15px 0 8px 0;
      font-weight: 600;
      font-size: 18px;
      color: #e0e0e0;
    }

    .vehicle-model {
      margin: 5px 0 5px 20px;
      color: #cccccc;
      font-weight: 500;
      font-size: 16px;
    }

    .vehicle-years {
      margin: 3px 0 3px 40px;
      color: var(--bs-lighter-gray);
      font-size: 14px;
    }

    .action-buttons {
      display: flex;
      gap: 10px;
      margin-top: 20px;
    }

    .btn-back {
      background-color: var(--bs-gray);
      color: #e0e0e0;
      border: none;
      padding: 8px 16px;
    }

    .btn-back:hover {
      background-color: var(--bs-light-gray);
      color: white;
    }

    .btn-edit {
      background-color: var(--bs-primary);
      color: white;
      border: none;
    }

    .btn-edit:hover {
      background-color: var(--bs-primary-dark);
      color: white;
    }
  </style>
</head>

<body>
  <!-- Header Include -->
  <jsp:include page="/Partials/header.jsp" />

  <div class="main-content py-4">
    <div class="container">
      <div class="details-container">
        <div class="details-header">
          <h1 class="details-title">Item Details</h1>
          <div>
            <a href="<%= request.getContextPath() %>/GetAllItems" class="btn btn-back" style="text-decoration: none;">
              <i class="fas fa-arrow-left"></i> Back to Catalog
            </a>
          </div>
        </div>

        <div class="item-info-row">
<!--           <div class="item-image-container"> -->
<!--             <i class="fas fa-car-battery item-image-placeholder"></i> -->
<!--           </div> -->
		<div class="item-image-container">
		    <img src="https://raw.githubusercontent.com/BadgerMole6276/spareiTimages/main/items/${item.itemId}.jpg" 
		         alt="Item ${item.itemId}" 
		         class="item-image"
		         onerror="this.style.display='none'; this.nextElementSibling.style.display='inline-block';" 
		         onload="this.style.display='block'; this.nextElementSibling.style.display='none';">
		    <i class="fas fa-car-battery item-image-placeholder" style="display: none;"></i>
		</div>

          <div class="item-details">
            <div class="item-category-badges">
              <span class="badge badge-brand"><c:out value="${item.itemBrand}" /></span>
              <span class="badge badge-category"><c:out value="${item.itemCategory}" /></span>
            </div>

            <h2 class="item-name" id="iName"><c:out value="${item.itemName}" /></h2>
            <div class="item-id">Part ID: #<c:out value="${item.itemId}" /></div>
            
            <div class="item-price" id="iPrice">$<c:out value="${item.itemPrice}" /></div>
            
            <div class="stock-container">
              <span class="stock-label">Available Stock:</span>
              <span id="iStocks" class="stock-value <c:if test="${item.itemStocks < 5}">low-stock</c:if>">
                <c:out value="${item.itemStocks}" /> units
              </span>
            </div>

            <div class="action-buttons">
              <button class="btn btn-edit" onclick="editItem(${item.itemId})">
                <i class="fas fa-edit"></i> Edit Item
              </button>
              <button class="btn btn-danger" onclick="deleteItem(${item.itemId})">
                <i class="fas fa-trash"></i> Delete Item
              </button>
            </div>
          </div>
        </div>

	<div class="info-section">
	  <h3 class="section-title">
	    <i class="fas fa-car"></i> Compatible Vehicles
	  </h3>
	  
	  <div class="row vehicle-compatibility-container">
	    <c:set var="totalMakes" value="${item.index.size()}" />
	    <c:set var="counter" value="0" />
	    
	    <!-- First Column -->
	    <div class="col-md-6">
	      <c:forEach var="makeEntry" items="${item.index.entrySet()}">
	        <c:set var="counter" value="${counter + 1}" />
	        <c:if test="${counter <= (totalMakes + 1) / 2}">
	          <div class="vehicle-make">
	            <i class="fas fa-angle-right"></i> <c:out value="${makeEntry.key}" />
	          </div>
	          <c:forEach var="modelMap" items="${makeEntry.value}">
	            <c:forEach var="modelEntry" items="${modelMap.entrySet()}">
	              <div class="vehicle-model">
	                <i class="fas fa-minus"></i> <c:out value="${modelEntry.key}" />
	              </div>
	              <div class="vehicle-years">
	                <i class="far fa-calendar-alt"></i> Years: 
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
	        </c:if>
	      </c:forEach>
	    </div>
	    
	    <!-- Second Column -->
	    <div class="col-md-6">
	      <c:set var="counter" value="0" />
	      <c:forEach var="makeEntry" items="${item.index.entrySet()}">
	        <c:set var="counter" value="${counter + 1}" />
	        <c:if test="${counter > (totalMakes + 1) / 2}">
	          <div class="vehicle-make">
	            <i class="fas fa-angle-right"></i> <c:out value="${makeEntry.key}" />
	          </div>
	          <c:forEach var="modelMap" items="${makeEntry.value}">
	            <c:forEach var="modelEntry" items="${modelMap.entrySet()}">
	              <div class="vehicle-model">
	                <i class="fas fa-minus"></i> <c:out value="${modelEntry.key}" />
	              </div>
	              <div class="vehicle-years">
	                <i class="far fa-calendar-alt"></i> Years: 
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
	        </c:if>
	      </c:forEach>
	    </div>
	  </div>
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
    function deleteItem(itemId) {
      if(confirm(`Are you sure you want to delete item #`+itemId+`?`)) {
        fetch(`/spareiT/DeleteItem?itemId=`+itemId, { method: 'POST' })
          .then(response => {
            if(response.ok) {
              window.location.href = '<%= request.getContextPath() %>/GetAllItems';
            } else {
              alert('Failed to delete item');
            }
          })
          .catch(error => {
            console.error('Error:', error);
            alert('Error deleting item');
          });
      }
    }
    
    function editItem(itemId) {
        // Extract data from the row
        const itemName = document.getElementById("iName").textContent;
        const itemBrand = `${item.itemBrand}`;
        const itemCategory = `${item.itemCategory}`;
        const itemPrice = document.getElementById("iPrice").textContent.slice(1);
        const itemStocks = parseInt(document.getElementById("iStocks").textContent, 10);
        
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
            
            document.getElementById("iName").textContent = itemName;
            document.getElementById("iPrice").innerHTML = `<span class="item-price">$`+itemPrice+`</span>`;
            document.getElementById("iStocks").textContent = itemStocks;
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