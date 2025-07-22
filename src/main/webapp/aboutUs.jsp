<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>SpareIt - About Us</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="styles.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
</head>
<body>

	<jsp:include page="/Partials/header.jsp"></jsp:include>

    <!-- About Us Content -->
    <div class="container py-5">
        <div class="row">
            <div class="col-lg-6 mb-4">
                <h1 class="text-light mb-4">About SpareIt</h1>
                <p class="lead text-light-gray">
                    SpareIt is a revolutionary online platform dedicated to simplifying vehicle spare parts management 
                    for automotive enthusiasts, mechanics, and vehicle owners.
                </p>
                <div class="bg-gray p-4 rounded">
                    <h4 class="text-primary mb-3">Our Mission</h4>
                    <p class="text-light">
                        To provide a seamless, efficient, and reliable solution for sourcing, purchasing, 
                        and managing automotive spare parts across various makes, models, and years.
                    </p>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="card bg-dark-accent h-100">
                    <div class="card-body">
                        <h4 class="card-title text-primary mb-4">
                            <i class="fas fa-cogs feature-icon me-2"></i>Key Features
                        </h4>
                        <ul class="list-unstyled text-white">
                            <li class="mb-3">
                                <i class="fas fa-check text-primary me-2"></i>
                                Comprehensive Vehicle Parts Catalog
                            </li>
                            <li class="mb-3">
                                <i class="fas fa-check text-primary me-2"></i>
                                Real-time Inventory Management
                            </li>
                            <li class="mb-3">
                                <i class="fas fa-check text-primary me-2"></i>
                                Multi-user Platform (Customers, Suppliers, Agents)
                            </li>
                            <li class="mb-3">
                                <i class="fas fa-check text-primary me-2"></i>
                                Advanced Search and Compatibility Matching
                            </li>
                            <li class="mb-3">
                                <i class="fas fa-check text-primary me-2"></i>
                                Secure Ordering and Tracking
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <!-- Our Story Section -->
        <div class="row mt-5">
            <div class="col-12">
                <h2 class="text-light mb-4">Our Story</h2>
                <div class="bg-dark-accent p-4 rounded">
                    <p class="text-light-gray">
                        Founded in 2023, SpareIt emerged from a passionate group of automotive professionals 
                        who recognized the challenges in the spare parts procurement process. Our team 
                        consists of automotive experts, software engineers, and supply chain specialists 
                        committed to revolutionizing how vehicle parts are sourced and managed.
                    </p>
                </div>
            </div>
        </div>

        <!-- Team Highlights -->
        <div class="row mt-5">
            <div class="col-12">
                <h2 class="text-light mb-4">Our Team</h2>
                <div class="row">
                    <div class="col-md-4 mb-4">
                        <div class="card bg-gray h-100">
                            <div class="card-body text-center">
                                <i class="fas fa-user-tie feature-icon text-primary mb-3"></i>
                                <h5 class="card-title text-light">John Automotive</h5>
                                <p class="text-light-gray">Founder & CEO</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="card bg-gray h-100">
                            <div class="card-body text-center">
                                <i class="fas fa-code feature-icon text-primary mb-3"></i>
                                <h5 class="card-title text-light">Sarah Tech</h5>
                                <p class="text-light-gray">Chief Technology Officer</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="card bg-gray h-100">
                            <div class="card-body text-center">
                                <i class="fas fa-chart-line feature-icon text-primary mb-3"></i>
                                <h5 class="card-title text-light">Mike Operations</h5>
                                <p class="text-light-gray">Operations Director</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Call to Action -->
        <div class="row mt-5">
            <div class="col-12">
                <div class="bg-primary p-5 text-center rounded">
                    <h3 class="text-light mb-3">Ready to Simplify Your Spare Parts Journey?</h3>
                    <p class="text-light-gray mb-4">
                        Join thousands of automotive professionals and enthusiasts who trust SpareIt 
                        for their vehicle parts needs.
                    </p>
                    <a href="<%= request.getContextPath() %>/Customer/register.jsp" class="btn btn-outline-light btn-lg">
                        Create Your Account
                    </a>
                </div>
            </div>
        </div>
    </div>

   <jsp:include page="/Partials/footer.jsp"></jsp:include>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>