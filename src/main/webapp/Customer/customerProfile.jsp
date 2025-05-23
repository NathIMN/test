<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Customer, service.CustomerCtrl" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>spareiT | Profile</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <!-- Custom theme CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css">
</head>
<body>
	<%
	if (session == null || session.getAttribute("user") == null || !"customer".equals(session.getAttribute("user"))) {
        // Not logged in as customer
        response.sendRedirect(request.getContextPath() + "/login.jsp?role=customer");
        return;
    }
    
    Customer customer = (Customer) request.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect("login.jsp?role=customer");
        return;
    }
    
    // Get any success or error messages
    String successMessage = (String) request.getAttribute("successMessage");
    String errorMessage = (String) request.getAttribute("errorMessage");
    %>

	<jsp:include page="/Partials/header.jsp"></jsp:include>

    <!-- Main Content -->
    <div class="container py-5">
        <div class="row">
            <!--Profile Information -->
            <div class="col-lg-8">
                <div class="card bg-dark-accent mb-4">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h2 class="card-title text-light mb-0">
                                <i class="fas fa-user-circle feature-icon me-2"></i>My Profile
                            </h2>
                            <button class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#editProfileModal">
                                <i class="fas fa-edit me-2"></i>Edit Profile
                            </button>
                        </div>
                        
                        <% if (successMessage != null) { %>
                            <div class="alert alert-success" role="alert">
                                <%= successMessage %>
                            </div>
                        <% } %>
                        
                        <% if (errorMessage != null) { %>
                            <div class="alert alert-danger" role="alert">
                                <%= errorMessage %>
                            </div>
                        <% } %>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <div class="card bg-gray">
                                    <div class="card-body">
                                        <h6 class="text-lighter-gray">First Name</h6>
                                        <p class="text-light mb-0 fs-5"><%= customer.getFirstName() %> </p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <div class="card bg-gray">
                                    <div class="card-body">
                                        <h6 class="text-lighter-gray">Last Name</h6>
                                        <p class="text-light mb-0 fs-5"><%= customer.getLastName() %></p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <div class="card bg-gray">
                                    <div class="card-body">
                                        <h6 class="text-lighter-gray">Email Address</h6>
                                        <p class="text-light mb-0"><%= customer.getEmail() %></p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <div class="card bg-gray">
                                    <div class="card-body">
                                        <h6 class="text-lighter-gray">Phone Number</h6>
                                        <p class="text-light mb-0"><%= customer.getPhoneNo() %></p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="card bg-gray">
                                    <div class="card-body">
                                        <h6 class="text-lighter-gray">Order History</h6>
                                        <div class="d-flex align-items-center">
                                            <span class="text-light mb-0 fs-5 me-3"><%= customer.getNoOfOrders() %> Orders</span>
                                            <a href="orders.jsp" class="btn btn-outline-primary btn-sm">View Orders</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Inquiry Information  -->
                <div class="card bg-dark-accent mb-4">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h2 class="card-title text-light mb-0">
                                <i class="fas fa-question-circle feature-icon me-2"></i>Inquiry Information
                            </h2>
                            <a href="newInquiry.jsp" class="btn btn-outline-primary">
                                <i class="fas fa-plus me-2"></i>New Inquiry
                            </a>
                        </div>
                        
                        <div class="table-responsive">
                            <table class="table table-dark table-bordered">
                                <thead>
                                    <tr>
                                        <th>InquiryId</th>
                                        <th>Vehicle Make</th>
                                        <th>Vehicle Model</th>
                                        <th>Part Name</th>
                                        <th>Inquiry Date</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="inquiry" items="${allInquiries}">
                                        <tr>
                                            <td>${inquiry.inquiryId}</td>
                                            <td>${inquiry.vehicleMake}</td>
                                            <td>${inquiry.vehicleModel}</td>
                                            <td>${inquiry.partName}</td>
                                            <td>${inquiry.inquiryDate}</td>
                                            <td>
                                                <span class="badge ${inquiry.status eq 'Pending' ? 'bg-warning' : 
                                                                      inquiry.status eq 'Processing' ? 'bg-primary' : 
                                                                      inquiry.status eq 'Completed' ? 'bg-success' : 
                                                                      inquiry.status eq 'Rejected' ? 'bg-danger' : 'bg-secondary'}">
                                                    ${inquiry.status}
                                                </span>
                                            </td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#inquiryDetailsModal${inquiry.inquiryId}">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        
                        <!-- If no inquiriesaas -->
                        <c:if test="${empty allInquiries}">
                            <div class="text-center py-4">
                                <p class="text-lighter-gray">You don't have any inquiries yet.</p>
                                <a href="<%= request.getContextPath() %>/Inquiry/inquiryInsert.jsp" class="btn btn-primary mt-2">
                                    <i class="fas fa-plus me-2"></i>Create Your First Inquiry
                                </a>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
            
            <!-- Account Actionssss -->
            <div class="col-lg-4">
                <div class="card bg-dark-accent">
                    <div class="card-body">
                        <h4 class="card-title text-light mb-4">
                            <i class="fas fa-cog feature-icon me-2"></i>Account Actions
                        </h4>
                        
                        <div class="d-grid gap-3">
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#changePasswordModal">
                                <i class="fas fa-key me-2"></i>Change Password
                            </button>
                            
                            <button class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#deleteAccountModal">
                                <i class="fas fa-trash-alt me-2"></i>Delete Account
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit Profile overlayss -->
    <div class="modal fade" id="editProfileModal" tabindex="-1" aria-labelledby="editProfileModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content bg-dark-accent">
                <div class="modal-header">
                    <h5 class="modal-title text-light" id="editProfileModalLabel">Edit Profile</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="CusUpdateSrv" method="post">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="firstName" class="form-label text-light">First Name</label>
                            <input type="text" class="form-control" id="firstName" name="firstName" value="<%= customer.getFirstName() %>" required>
                        </div>
                        <div class="mb-3">
                            <label for="lastName" class="form-label text-light">Last Name</label>
                            <input type="text" class="form-control" id="lastName" name="lastName" value="<%= customer.getLastName() %>" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label text-light">Email Address</label>
                            <input type="email" class="form-control" id="email" name="email" value="<%= customer.getEmail() %>" required>
                        </div>
                        <div class="mb-3">
                            <label for="phoneNo" class="form-label text-light">Phone Number</label>
                            <input type="tel" class="form-control" id="phoneNo" name="phoneNo" value="<%= customer.getPhoneNo() %>" required>
                        </div>
                        <!-- Hidden field for customer ID -->
                        <input type="hidden" name="cusId" value="<%= customer.getCusId() %>">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>


    <!-- Delete Account overlayss -->
    <div class="modal fade" id="deleteAccountModal" tabindex="-1" aria-labelledby="deleteAccountModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content bg-dark-accent">
                <div class="modal-header">
                    <h5 class="modal-title text-light" id="deleteAccountModalLabel">Delete Account</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="alert bg-primary text-light">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        <strong>Warning:</strong> This action cannot be undone. All your data will be permanently deleted.
                    </div>
                    <form action="CusDeleteSrv" method="post" id="deleteAccountForm">
                        <div class="mb-3">
                            <label for="deletePassword" class="form-label text-light">Enter Your Password to Confirm</label>
                            <input type="password" class="form-control" id="deletePassword" name="password" required>
                        </div>
                        <!-- Hidden field for customer ID -->
                        <input type="hidden" name="cusId" value="<%= customer.getCusId() %>">
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-danger" onclick="confirmDelete()">Delete My Account</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Inquiry Detail overlaysss (one for each inquiry) -->
    <c:forEach var="inquiry" items="${allInquiries}">
        <div class="modal fade" id="inquiryDetailsModal${inquiry.inquiryId}" tabindex="-1" aria-labelledby="inquiryDetailsModalLabel${inquiry.inquiryId}" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content bg-dark-accent">
                    <div class="modal-header">
                        <h5 class="modal-title text-light" id="inquiryDetailsModalLabel${inquiry.inquiryId}">
                            Inquiry Details #${inquiry.inquiryId}
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <h6 class="text-lighter-gray">Vehicle Information</h6>
                                <div class="card bg-gray mb-2">
                                    <div class="card-body">
                                        <p class="mb-1"><strong>Make:</strong> ${inquiry.vehicleMake}</p>
                                        <p class="mb-1"><strong>Model:</strong> ${inquiry.vehicleModel}</p>
                                        <p class="mb-0"><strong>Year:</strong> ${inquiry.yearOfManufacture}</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <h6 class="text-lighter-gray">Part Information</h6>
                                <div class="card bg-gray mb-2">
                                    <div class="card-body">
                                        <p class="mb-1"><strong>Part Name:</strong> ${inquiry.partName}</p>
                                        <p class="mb-1"><strong>Quantity:</strong> ${inquiry.quantityRequired}</p>
                                        <p class="mb-0"><strong>Urgency:</strong> ${inquiry.urgencyLevel}</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 mb-3">
                                <h6 class="text-lighter-gray">Inquiry Details</h6>
                                <div class="card bg-gray">
                                    <div class="card-body">
                                        <p class="mb-1"><strong>Date:</strong> ${inquiry.inquiryDate}</p>
                                        <p class="mb-1"><strong>Type:</strong> ${inquiry.inquiryType}</p>
                                        <p class="mb-1"><strong>Status:</strong> 
                                            <span class="badge ${inquiry.status eq 'Pending' ? 'bg-warning' : 
                                                                inquiry.status eq 'Processing' ? 'bg-primary' : 
                                                                inquiry.status eq 'Completed' ? 'bg-success' : 
                                                                inquiry.status eq 'Rejected' ? 'bg-danger' : 'bg-secondary'}">
                                                ${inquiry.status}
                                            </span>
                                        </p>
                                        <hr class="my-2">
                                        <h6 class="text-lighter-gray">Description</h6>
                                        <p class="mb-0">${inquiry.description}</p>
                                        <hr class="my-2">
                                        <h6 class="text-lighter-gray">Response</h6>
                                        <p class="mb-0">${inquiry.response}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>
                        <c:if test="${inquiry.status eq 'Pending'}">
                            <form action="InquiryDeleteSrv" method="post" style="display: inline;">
                                <input type="hidden" name="inquiryId" value="${inquiry.inquiryId}">
                                <button type="submit" class="btn btn-danger">Cancel Inquiry</button>
                            </form>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>

	<jsp:include page="/Partials/footer.jsp"></jsp:include>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function confirmDelete() {
            if (confirm("Are you absolutely sure you want to delete your account? This action cannot be undone.")) {
                document.getElementById("deleteAccountForm").submit();
            }
        }
    </script>
</body>
</html>