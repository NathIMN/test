<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Inquiry Information</title>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
<!-- Custom CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css">



</head>
<body>
	<jsp:include page="/Partials/header.jsp"></jsp:include>
<div class="container-fluid py-4">
  <h2 class="mx-4">Inquiry Information</h2>
  
  <div class="table-responsive m-3">
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
		  <th>Response</th>
          <th>Action</th>
          
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
            <td>${inquiry.response}</td>
            <td>
              <div class="action-buttons">
                <a href="Inquiry/inquiryUpdate.jsp?id=${inquiry.inquiryId}" class="btn btn-primary btn-sm">Update</a>
                <form method="post" action="InquiryDeleteSrv" style="display: inline;">
                  <input type="hidden" name="inquiryId" value="${inquiry.inquiryId}" />
                  <button type="submit" class="btn btn-danger btn-sm m-1">Delete</button>
                </form>
              </div>
            </td>
            
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
</div>

<!-- Bootstrap JS Bundle (optional) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<jsp:include page="/Partials/footer.jsp"></jsp:include>
</body>
</html>