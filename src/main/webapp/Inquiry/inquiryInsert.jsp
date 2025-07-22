<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>SpareIt | Spare Part Inquiry</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/styles.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
</head>
<body>
   
	<jsp:include page="/Partials/header.jsp"></jsp:include>

    <div class="container ">
        <div class="row justify-content-center m-5">
            <div class="col-md-10">
                <%
                String name = (String) session.getAttribute("name");
                %>
                <div class="card bg-dark-accent p-4 mb-4">
                    <div class="card-body">
                        <h2 class="card-title text-light">
                            <i class="fas fa-search feature-icon me-2"></i>
                            Spare Part Inquiry
                        </h2>
                        <p class="text-white">
                            Hello, <%= (name != null ? name : "Customer") %>! 
                            Please provide details about the spare part you're looking for.
                        </p>
                    </div>
                </div>

                <div class="card bg-dark-accent">
                    <div class="card-body p-4">
                        <form action="../InquiryInsertSrv" method="post">
                            <div class="row">
                                <div class="col-md-4 mb-3">
                                    <label for="vehicleMake" class="form-label text-light">Vehicle Make:</label>
                                    <select class="form-select" name="vehicleMake" id="vehicleMake" required>
                                        <option value="">-- Select Make --</option>
                                        <option value="Toyota">Toyota</option>
                                        <option value="Honda">Honda</option>
                                        <option value="Ford">Ford</option>
                                        <option value="BMW">BMW</option>
                                        <option value="Hyundai">Hyundai</option>
                                    </select>
                                </div>

                                <div class="col-md-4 mb-3">
                                    <label for="vehicleModel" class="form-label text-light">Vehicle Model:</label>
                                    <select class="form-select" name="vehicleModel" id="vehicleModel" required>
                                        <option value="">-- Select Model --</option>
                                        <option value="Corolla">Corolla</option>
                                        <option value="Civic">Civic</option>
                                        <option value="Focus">Focus</option>
                                        <option value="X5">X5</option>
                                        <option value="Elantra">Elantra</option>
                                    </select>
                                </div>

                                <div class="col-md-4 mb-3">
                                    <label for="yearOfManufacture" class="form-label text-light">Year of Manufacture:</label>
                                    <select class="form-select" name="yearOfManufacture" id="yearOfManufacture" required>
                                        <option value="">-- Select Year --</option>
                                        <% for (int year = 2024; year >= 2015; year--) { %>
                                            <option value="<%= year %>"><%= year %></option>
                                        <% } %>
                                    </select>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="partName" class="form-label text-light">Part Name:</label>
                                <input type="text" class="form-control" name="partName" id="partName" required 
                                       placeholder="Enter specific part name">
                            </div>

                            <div class="mb-3">
                                <label for="description" class="form-label text-light">Description:</label>
                                <textarea class="form-control" name="description" id="description" rows="4" required
                                          placeholder="Provide additional details about the part"></textarea>
                            </div>

                            <div class="row">
                                <div class="col-md-4 mb-3">
                                    <label for="quantityRequired" class="form-label text-light">Quantity Required:</label>
                                    <input type="number" class="form-control" name="quantityRequired" 
                                           id="quantityRequired" min="1" required value="1">
                                </div>

                                <div class="col-md-4 mb-3">
                                    <label for="urgencyLevel" class="form-label text-light">Urgency Level:</label>
                                    <select class="form-select" name="urgencyLevel" id="urgencyLevel" required>
                                        <option value="Low">Low</option>
                                        <option value="Medium" selected>Medium</option>
                                        <option value="High">High</option>
                                    </select>
                                </div>

                                <div class="col-md-4 mb-3">
                                    <label for="inquiryType" class="form-label text-light">Inquiry Type:</label>
                                    <select class="form-select" name="inquiryType" id="inquiryType" required>
                                        <option value="General">By Part</option>
                                        <option value="Technical">Return</option>
                                    </select>
                                </div>
                            </div>

                            <div class="d-grid">
                            
                                <button type="submit" class="btn btn-primary">
                                <%if (session == null || session.getAttribute("user") == null || !"customer".equals(session.getAttribute("user"))){%>
	                                <a href="${pageContext.request.contextPath}//login.jsp?role=customer" class="btn btn-sm btn-outline-danger">
	                                    <i class="fa-solid fa-right-to-bracket me-2"></i>Login first to Submit the Inquiry
	                                </a>
                                <% }else{ %>
                                	
                                	<i class="fas fa-paper-plane me-2"></i>Submit Inquiry
                                	
                                <% } %>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

	<jsp:include page="/Partials/footer.jsp"></jsp:include>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>