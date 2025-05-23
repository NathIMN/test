<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Inquiry Information</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

<link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css">
</head>


<body class="d-flex flex-column min-vh-100">

    <jsp:include page="/Partials/header.jsp" />

    <main class="flex-grow-1">
        <div class="container-fluid py-4">
            <h2>Inquiry Information</h2>
            <div class="table-responsive">
                <table class="table table-dark table-bordered">
                    <thead>
                        <tr>
                            <th>InquiryId</th>
                            <th>CustomerId</th>
                            <th>Vehicle Make</th>
                            <th>Vehicle Model</th>
                            <th>Manufacture Year</th>
                            <th>Part Name</th>
                            <th>Inquiry Date</th>
                            <th>Description</th>
                            <th>Quantity Required</th>
                            <th>Urgency Level</th>
                            <th>Inquiry Type</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="inquiry" items="${allInquiries}">
                            <tr>
                                <td>${inquiry.inquiryId}</td>
                                <td>${inquiry.cusId}</td>
                                <td>${inquiry.vehicleMake}</td>
                                <td>${inquiry.vehicleModel}</td>
                                <td>${inquiry.yearOfManufacture}</td>
                                <td>${inquiry.partName}</td>
                                <td>${inquiry.inquiryDate}</td>
                                <td>${inquiry.description}</td>
                                <td>${inquiry.quantityRequired}</td>
                                <td>${inquiry.urgencyLevel}</td>
                                <td>${inquiry.inquiryType}</td>
                                <td>${inquiry.status}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <!-- Footer (stays at the bottom even with small content) -->
    <jsp:include page="/Partials/footer.jsp" />

<!-- Bootstrap Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
