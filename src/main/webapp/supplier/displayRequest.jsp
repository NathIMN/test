<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Restock Requests</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

	<jsp:include page="/Partials/header.jsp"></jsp:include>

    <!-- Main Content -->
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 col-md-12">
                <div class="card shadow">
                    <div class="card-body p-4">
                        <h2 class="card-title text-center mb-4 text-primary">View Restock Requests</h2>

                        <table class="table table-striped table-bordered">
                            <thead>
                                <tr>
                                    <th scope="col">Item Name</th>
                                    <th scope="col">Quantity</th>
                                    <th scope="col">Request Date</th>
                                    <th scope="col">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="request" items="${requests}">
                                    <tr>
                                        <td>${request.itemName}</td>
                                        <td>${request.quantity}</td>
                                        <td>${request.requestDate}</td>
                                        <td>
                                            <a href="<%= request.getContextPath() %>/supplier/updateRequest.jsp?id=${request.requestID}" class="btn btn-warning btn-sm">
                                                <i class="fas fa-edit"></i> Edit
                                            </a>
                                            <a href="<%= request.getContextPath() %>/SupplierDeleteRequestSrv?id=${request.requestID}" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this record?')">
                                                <i class="fas fa-trash-alt"></i> Delete
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Quick Navigation Links -->
                <div class="text-center mt-3">
                    <a href="<%= request.getContextPath() %>/SupplierGetRegisteredItems" class="text-primary me-3">
                        <i class="fas fa-plus me-1"></i>Create New Request
                    </a>
                    <a href="<%= request.getContextPath() %>/index.jsp" class="text-primary">
                        <i class="fas fa-home me-1"></i>Back to Home
                    </a>
                </div>
            </div>
        </div>
    </div>

	<jsp:include page="/Partials/footer.jsp"></jsp:include>

    <!-- JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>