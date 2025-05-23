<%@ page import="java.util.List" %>
<%@ page import="model.InquiryModel" %>
<%@ page import="service.InquiryController" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page session="true" %>

<%
String role = (String) session.getAttribute("user");
String inquiryId = request.getParameter("id");
List<InquiryModel> inquiries = InquiryController.getById(inquiryId);
DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>View / Update Inquiry</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="../styles.css">
    <style>
        
        .inquiry-card {
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            padding: 20px;
            margin-bottom: 20px;
        }
        
        .form-label {
            font-weight: 500;
            color: var(--bs-lighter-gray);
        }
        
        .form-control, .form-select {
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 15px;
        }
        
        .btn-update {
            padding: 10px 25px;
            font-weight: 600;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        
        .btn-update:hover {
            transform: translateY(-2px);
        }
        
        .status-badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        
        .status-pending {
            background-color: #ffc107;
            color: #212529;
        }
        
        .status-progress {
            background-color: #0d6efd;
            color: white;
        }
        
        .status-completed {
            background-color: #198754;
            color: white;
        }
        
        .inquiry-header {
            border-bottom: 1px solid var(--bs-gray);
            margin-bottom: 20px;
            padding-bottom: 10px;
        }
        
        .section-heading {
            color: var(--bs-primary);
            margin: 20px 0 10px 0;
            font-size: 1.1rem;
            font-weight: 600;
        }
    </style>
    
    <jsp:include page="/Partials/header.jsp"></jsp:include>
</head>
<body>
    <div class="container mt-4 mb-5">
        <div class="row">
            <div class="col-md-10 mx-auto">
                <div class="inquiry-card bg-dark-accent">
                    <h2 class="inquiry-header text-center mb-4">
                        <i class="fas fa-clipboard-list me-2" style="color: var(--bs-primary);"></i>
                        Inquiry Details
                    </h2>
                    
                    <%
                    if (!inquiries.isEmpty()) {
                        InquiryModel iq = inquiries.get(0);
                        // Handle null inquiryDate gracefully
                        String dtValue = iq.getInquiryDate() != null ? iq.getInquiryDate().toLocalDateTime().format(fmt) : "";
                        boolean isSupporter = "agent".equals(role);
                    %>
                    
                    <form action="<%= isSupporter ? request.getContextPath() + "/InquiryUpdateSrv" : "#" %>" method="post">
                        <input type="hidden" name="inquiryId" value="<%= iq.getInquiryId() %>" />
                        <input type="hidden" name="cusId" value="<%= iq.getCusId() %>" />
                        
                        <!-- Status display -->
                        <div class="text-end mb-3">
                            <span class="status-badge <%= "Pending".equals(iq.getStatus()) ? "status-pending" : ("In Progress".equals(iq.getStatus()) ? "status-progress" : "status-completed") %>">
                                <%= iq.getStatus() %>
                            </span>
                        </div>
                        
                        <div class="row">
                            <h5 class="section-heading">Vehicle Information</h5>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Vehicle Make</label>
                                <input type="text" class="form-control" name="vehicleMake" value="<%= iq.getVehicleMake() %>" readonly />
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Vehicle Model</label>
                                <input type="text" class="form-control" name="vehicleModel" value="<%= iq.getVehicleModel() %>" readonly />
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Year of Manufacture</label>
                                <input type="number" class="form-control" name="yearOfManufacture" value="<%= iq.getYearOfManufacture() %>" readonly />
                            </div>
                        </div>
                        
                        <div class="row">
                            <h5 class="section-heading">Part Information</h5>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Part Name</label>
                                <input type="text" class="form-control" name="partName" value="<%= iq.getPartName() %>" readonly />
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Quantity Required</label>
                                <input type="number" class="form-control" name="quantityRequired" value="<%= iq.getQuantityRequired() %>" readonly />
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Inquiry Date</label>
                                <input type="datetime-local" class="form-control" name="inquiryDate" value="<%= dtValue %>" readonly />
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Urgency Level</label>
                                <input type="text" class="form-control" name="urgencyLevel" value="<%= iq.getUrgencyLevel() %>" readonly />
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Inquiry Type</label>
                                <input type="text" class="form-control" name="inquiryType" value="<%= iq.getInquiryType() %>" readonly />
                            </div>
                        </div>
                        
                        <div class="row mb-3">
                            <div class="col-12">
                                <label class="form-label">Description</label>
                                <textarea class="form-control" name="description" rows="3" readonly><%= iq.getDescription() %></textarea>
                            </div>
                        </div>
                        
                        <!-- Only these are editable for supporters -->
                        <div class="row">
                            <h5 class="section-heading">Status & Response</h5>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Status</label>
                                <% if (isSupporter) { %>
                                <select name="status" class="form-select" required>
                                    <option value="Pending" <%= "Pending".equals(iq.getStatus()) ? "selected" : "" %>>Pending</option>
                                    <option value="In Progress" <%= "In Progress".equals(iq.getStatus()) ? "selected" : "" %>>In Progress</option>
                                    <option value="Completed" <%= "Completed".equals(iq.getStatus()) ? "selected" : "" %>>Completed</option>
                                </select>
                                <% } else { %>
                                <input type="text" class="form-control" value="<%= iq.getStatus() %>" readonly />
                                <% } %>
                            </div>
                            <div class="col-md-8 mb-3">
                                <label class="form-label">Response</label>
                                <% if (isSupporter) { %>
                                <textarea name="response" rows="4" class="form-control" required><%= iq.getResponse() != null ? iq.getResponse() : "" %></textarea>
                                <% } else { %>
                                <textarea readonly rows="4" class="form-control"><%= iq.getResponse() != null ? iq.getResponse() : "" %></textarea>
                                <% } %>
                            </div>
                        </div>
                        
                        <div class="text-center mt-4">
                            <% if (isSupporter) { %>
                            <button type="submit" class="btn btn-primary btn-update">
                                <i class="fas fa-save me-2"></i>Update Inquiry
                            </button>
                            <% } %>
                            <a href="javascript:history.back()" class="btn btn-outline-primary ms-2">
                                <i class="fas fa-arrow-left me-2"></i>Back
                            </a>
                        </div>
                    </form>
                    
                    <% } else { %>
                    <div class="alert alert-warning" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        Inquiry not found. The requested inquiry may have been deleted or is unavailable.
                    </div>
                    <div class="text-center mt-4">
                        <a href="javascript:history.back()" class="btn btn-outline-primary">
                            <i class="fas fa-arrow-left me-2"></i>Go Back
                        </a>
                    </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <jsp:include page="/Partials/footer.jsp"></jsp:include>
</body>
</html>