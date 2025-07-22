<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="model.Item" %>
<%@ page import="model.RestockRequestModel" %>
<%@ page import="service.RestockRequestController" %>
<%@ page import="service.SuppliesController" %>

<%
int supplierID = (int)session.getAttribute("userId");

ArrayList<RestockRequestModel> requests = RestockRequestController.getdata(supplierID);

RestockRequestModel currentRequest = null;

for(RestockRequestModel req : requests){
	if(req.getRequestID() == Integer.parseInt(request.getParameter("id"))){
		currentRequest = req;
		break;
	}
}

SuppliesController controller = new SuppliesController();
List<String[]> itemList = controller.getItemNames(supplierID);
%>
    
<html lang="en" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Restock Request</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="supplier.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

    <jsp:include page="/Partials/header.jsp"></jsp:include>

    <!-- Main Content -->
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8 col-md-10">
                <div class="card shadow">
                    <div class="card-body p-4">
                        <h2 class="card-title text-center mb-4" style="color: #888888;">Update Restock Request</h2>
                        
                        <%
                            
                            if (currentRequest == null) {
                        %>
                            <div class="alert alert-warning">
                                <i class="fas fa-exclamation-triangle me-2"></i>No request selected for update.
                                <a href="<%= request.getContextPath() %>/SupplierDisplayRequestSrv" class="alert-link">View all requests</a>
                            </div>
                        <% } else { %>

                        <form action="<%= request.getContextPath() %>/SupplierUpdateRequestSrv" method="post" id="updateForm" class="needs-validation" novalidate>
                            <!-- Hidden field for request ID -->
                            <input type="hidden" name="requestID" value="<%= currentRequest.getRequestID() %>">

                            <div class="mb-3">
                                <label for="itemName" class="form-label" style="color: #888888;">Item Name</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-gray"><i class="fas fa-box-open"></i></span>
                                    <select class="form-select" id="itemName" name="itemID" required>
                                        <%
                                            if (itemList != null) {
                                                for (String[] item : itemList) {
                                                    boolean isSelected = (currentRequest.getItemID() == Integer.parseInt(item[0]));
                                        %>
                                                    <option value="<%= item[0] %>" <%= isSelected ? "selected" : "" %>><%= item[1] %></option>
                                        <%
                                                }
                                            } else {
                                        %>
                                                <option value="">No items found</option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                                <div class="invalid-feedback">Please select an item</div>
                            </div>

                            <div class="mb-3">
                                <label for="quantity" class="form-label" style="color: #888888;">Quantity</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-gray"><i class="fas fa-sort-amount-up"></i></span>
                                    <input type="number" class="form-control" id="quantity" name="quantity" 
                                           required min="1" value="<%= currentRequest.getQuantity() %>">
                                </div>
                                <div class="invalid-feedback">Quantity must be at least 1</div>
                            </div>

                            <div class="mb-3">
                                <label for="requestDate" class="form-label" style="color: #888888;">Request Date</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-gray"><i class="fas fa-calendar-alt"></i></span>
                                    <input type="date" class="form-control" id="requestDate" name="requestDate" 
                                           required value="<%= currentRequest.getRequestDate() %>">
                                </div>
                                <div class="invalid-feedback">Please select a date</div>
                            </div>

                            <div class="mb-3">
                                <label for="status" class="form-label" style="color: #888888;">Request Status</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-gray"><i class="fas fa-tasks"></i></span>
                                    <select class="form-select" id="status" name="status" required>
                                        <option value="Pending" <%= "Pending".equals(currentRequest.getStatus()) ? "selected" : "" %>>Pending</option>
                                        <option value="Approved" <%= "Approved".equals(currentRequest.getStatus()) ? "selected" : "" %>>Approved</option>
                                        <option value="Completed" <%= "Completed".equals(currentRequest.getStatus()) ? "selected" : "" %>>Completed</option>
                                        <option value="Cancelled" <%= "Cancelled".equals(currentRequest.getStatus()) ? "selected" : "" %>>Cancelled</option>
                                    </select>
                                </div>
                                <div class="invalid-feedback">Please select a status</div>
                            </div>

                            <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                                <a href="<%= request.getContextPath() %>/SupplierDisplayRequestSrv" class="btn btn-outline-light me-md-2">
                                    <i class="fas fa-times me-1"></i>Cancel
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-1"></i>Update Request
                                </button>
                            </div>
                        </form>
                        <% } %>
                    </div>
                </div>

                <!-- Quick Navigation Links -->
                <div class="text-center mt-3">
                    <a href="<%= request.getContextPath() %>/SupplierDisplayRequestSrv" class="text-primary-light me-3">
                        <i class="fas fa-list me-1"></i>View All Requests
                    </a>
                    <a href="<%= request.getContextPath() %>/SupplierGetRegisteredItems" class="text-primary-light me-3">
                        <i class="fas fa-plus me-1"></i>Create New Request
                    </a>
                    <a href="<%= request.getContextPath() %>/index.jsp" class="text-primary-light">
                        <i class="fas fa-home me-1"></i>Back to Home
                    </a>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/Partials/footer.jsp"></jsp:include>

    <!-- JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Form validation
        document.addEventListener('DOMContentLoaded', function() {
            // Bootstrap validation
            const form = document.getElementById('updateForm');
            if (form) {
                form.addEventListener('submit', function(event) {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }

                    const quantity = document.getElementById('quantity').value;
                    if (quantity <= 0) {
                        alert('Quantity must be a positive number');
                        event.preventDefault();
                    }

                    form.classList.add('was-validated');
                });
            }
        });
    </script>
</body>
</html>