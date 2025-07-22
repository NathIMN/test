<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Item" %>
    

<html lang="en" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insert Restock Request</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

	<jsp:include page="/Partials/header.jsp"></jsp:include>

    <!-- Main Content -->
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8 col-md-10">
                <div class="card shadow bg-dark-accent">
                    <div class="card-body p-4">
                        <h2 class="card-title text-center mb-4 text-primary">Create Restock Request</h2>

                        <form action="<%= request.getContextPath() %>/SupplierInsertRequestSrv" method="post" id="restockForm" class="needs-validation" novalidate>

                            <div class="mb-3">
                                <label for="itemName" class="form-label text-light">Item Name</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-gray border-0"><i class="fas fa-box-open text-primary"></i></span>
                                    <select class="form-select " id="itemName" name="itemID" required>
                                        <%
										    List<String[]> itemList = (List<String[]>) request.getAttribute("itemNames");
										    if (itemList != null) {
										    	for (String[] item : itemList) {
										        	System.out.println(item[1]);
										%>
										            <option value="<%= item[0] %>"><%= item[1] %></option>

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
                                <label for="quantity" class="form-label text-light">Quantity</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-gray border-0"><i class="fas fa-sort-amount-up text-primary"></i></span>
                                    <input type="number" class="form-control" id="quantity" name="quantity" required min="1">
                                </div>
                                <div class="invalid-feedback">Quantity must be at least 1</div>
                            </div>

                            <div class="mb-3">
                                <label for="requestDate" class="form-label text-light">Request Date</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-gray border-0"><i class="fas fa-calendar-alt text-primary"></i></span>
                                    <input type="date" class="form-control" id="requestDate" name="requestDate" required>
                                </div>
                                <div class="invalid-feedback">Please select a date</div>
                            </div>

                            <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                                <button type="reset" class="btn btn-outline-light me-md-2">
                                    <i class="fas fa-undo me-1"></i>Reset
                                </button>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-1"></i>Submit Request
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
                
				<!-- Quick Navigation Links -->
                <div class="text-center mt-3">
                    <a href="<%= request.getContextPath() %>/SupplierDisplayRequestSrv" class=" me-3 text-primary">
                        <i class="fas fa-list me-1"></i>View All Requests
                    </a>
                    <a href="<%= request.getContextPath() %>/index.jsp" class="me-3 text-primary">
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
        // Set default date to today and implement form validation
        document.addEventListener('DOMContentLoaded', function() {
            // Set today's date as default
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('requestDate').value = today;

            // Bootstrap validation
            const form = document.getElementById('restockForm');
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
        });
    </script>
</body>
</html>