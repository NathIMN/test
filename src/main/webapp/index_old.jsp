<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>spareiT | Home</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <!-- Custom theme CSS (minimal) -->
    <link rel="stylesheet" type="text/css" href="./styles.css">
    <style>
    	.hero-section {
		  position: relative;
		  background-image: url('./assets/gears.jpg');
		  background-size: cover;
		  background-position: center;
		  background-repeat: no-repeat;
		  z-index: 0;
		}
		
		.hero-section::before {
		  content: "";
		  position: absolute;
		  top: 0; left: 0;
		  width: 100%;
		  height: 100%;
		  background-color: rgba(0, 0, 0, 0.2);
		  z-index: 1;
		}
		
		/* Ensure content sits above the overlay */
		.hero-section > * {
		  position: relative;
		  z-index: 2;
		}

    </style>
</head>
<body>
	
	<jsp:include page="/Partials/header.jsp"></jsp:include>
	
    <!-- Hero Section -->
    <section class="hero-section py-5">
        <div class="container text-center py-5">
            <h1 class="display-4 fw-bold mb-4">Find the Right Parts for Your Vehicle</h1>
            <p class="lead mb-5 fw-semibold">Your one-stop platform for quality automotive parts with guaranteed authenticity</p>
            <div class="d-flex justify-content-center">
                <a href="#" class="btn btn-primary btn-lg me-3">Shop Now</a>
                <a href="#" class="btn btn-outline-light btn-lg">Become a Supplier</a>
            </div>
        </div>
    </section>
	
	<!-- Search Bar -->
	<section class="py-5 bg-gray">
	    <div class="container">
	        <div class="row justify-content-center">
	            <div class="col-md-8">
	                <div class="card shadow">
	                    <div class="card-body">
	                        <h4 class="card-title text-center mb-4">Quick Parts Search</h4>
	                        <form action="${pageContext.request.contextPath}/SearchSrv" method="get">
	                            <div class="row g-3">
	                                <div class="col-md-4">
	                                    <select class="form-select" id="makeSelect" name="make" required>
	                                        <option value="" selected disabled>Select Make</option>
	                                        <c:forEach items="${makes}" var="make">
	                                            <option value="${make.makeId}">${make.makeName}</option>
	                                        </c:forEach>
	                                    </select>
	                                </div>
	                                <div class="col-md-4">
	                                    <select class="form-select" id="modelSelect" name="model" disabled required>
	                                        <option value="" selected disabled>Select Model</option>
	                                    </select>
	                                </div>
	                                <div class="col-md-4">
	                                    <select class="form-select" id="yearSelect" name="year" disabled required>
	                                        <option value="" selected disabled>Select Year</option>
	                                    </select>
	                                </div>
	                                <div class="col-12">
	                                    <div class="input-group">
	                                        <input type="text" class="form-control" name="keyword" placeholder="Search parts (e.g., brake pads, oil filter)" required>
	                                        <button class="btn btn-primary" type="submit">
	                                            <i class="fas fa-search"></i> Search
	                                        </button>
	                                    </div>
	                                </div>
	                            </div>
	                        </form>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</section>


    <!-- Features Section -->
    <section class="py-5">
        <div class="container">
            <h2 class="text-center mb-5">Why Choose AutoSpare?</h2>
            <div class="row g-4">
                <div class="col-md-4 text-center">
                    <div class="feature-icon">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <h3>Genuine Parts</h3>
                    <p class="text-muted">All parts are sourced directly from manufacturers and verified suppliers to ensure authenticity and quality.</p>
                </div>
                <div class="col-md-4 text-center">
                    <div class="feature-icon">
                        <i class="fas fa-truck"></i>
                    </div>
                    <h3>Fast Delivery</h3>
                    <p class="text-muted">Get your parts delivered quickly with our efficient logistics network spanning across the country.</p>
                </div>
                <div class="col-md-4 text-center">
                    <div class="feature-icon">
                        <i class="fas fa-headset"></i>
                    </div>
                    <h3>Expert Support</h3>
                    <p class="text-muted">Our knowledgeable support agents are always ready to help you find the right parts for your vehicle.</p>
                </div>
            </div>
        </div>
    </section>
	
	<!-- For Suppliers Section -->
    <section class="py-5 bg-primary">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="mb-4">Are You a Parts Supplier?</h2>
                    <p class="lead mb-4">Join our network of trusted suppliers and expand your business. AutoSpare connects you with thousands of customers looking for quality parts.</p>
                    <ul class="list-unstyled">
                        <li class="mb-2"><i class="fas fa-check me-2"></i> Access to nationwide customer base</li>
                        <li class="mb-2"><i class="fas fa-check me-2"></i> Simplified inventory management</li>
                        <li class="mb-2"><i class="fas fa-check me-2"></i> Real-time analytics and reporting</li>
                    </ul>
                </div>
                <div class="col-md-4 text-center text-md-end mt-4 mt-md-0">
                    <a href="#" class="btn btn-light btn-lg">Become a Supplier</a>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Testimonials -->
    <section class="py-5">
        <div class="container">
            <h2 class="text-center mb-5">What Our Users Say</h2>
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="card h-100 shadow-sm">
                        <div class="card-body">
                            <div class="mb-3 text-warning">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                            </div>
                            <p class="card-text">"Finding the right parts for my vintage car has always been a challenge until I discovered AutoSpare. Their support team went above and beyond to source rare components."</p>
                        </div>
                        <div class="card-footer bg-transparent border-0">
                            <div class="d-flex align-items-center">
                                <img src="/api/placeholder/50/50" class="rounded-circle me-3" alt="Customer">
                                <div>
                                    <h6 class="mb-0">Michael Johnson</h6>
                                    <small class="text-muted">Car Enthusiast</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card h-100 shadow-sm">
                        <div class="card-body">
                            <div class="mb-3 text-warning">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                            </div>
                            <p class="card-text">"As a repair shop owner, I need reliable parts fast. AutoSpare has consistently delivered quality components on time, which has helped our business tremendously."</p>
                        </div>
                        <div class="card-footer bg-transparent border-0">
                            <div class="d-flex align-items-center">
                                <img src="/api/placeholder/50/50" class="rounded-circle me-3" alt="Customer">
                                <div>
                                    <h6 class="mb-0">Sarah Williams</h6>
                                    <small class="text-muted">Repair Shop Owner</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card h-100 shadow-sm">
                        <div class="card-body">
                            <div class="mb-3 text-warning">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star-half-alt"></i>
                            </div>
                            <p class="card-text">"Joining AutoSpare as a supplier has transformed our distribution capabilities. The platform's analytics help us understand market demand and optimize our inventory."</p>
                        </div>
                        <div class="card-footer bg-transparent border-0">
                            <div class="d-flex align-items-center">
                                <img src="/api/placeholder/50/50" class="rounded-circle me-3" alt="Supplier">
                                <div>
                                    <h6 class="mb-0">David Chen</h6>
                                    <small class="text-muted">Parts Distributor</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Partners -->
    <section class="py-5 bg-gray">
        <div class="container">
            <h2 class="text-center mb-5">Our Trusted Partners</h2>
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="d-flex flex-wrap justify-content-center align-items-center">
                        <img src="/api/placeholder/150/60" alt="Partner 1" class="partner-logo">
                        <img src="/api/placeholder/150/60" alt="Partner 2" class="partner-logo">
                        <img src="/api/placeholder/150/60" alt="Partner 3" class="partner-logo">
                        <img src="/api/placeholder/150/60" alt="Partner 4" class="partner-logo">
                        <img src="/api/placeholder/150/60" alt="Partner 5" class="partner-logo">
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Rest of the HTML content remains the same -->
    
    <jsp:include page="/Partials/footer.jsp"></jsp:include>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    
    <!-- Script for the dynamic dependent dropdowns -->
    <script>
    document.addEventListener('DOMContentLoaded', function() {
        // Store all models and years data in JavaScript variables
        const models = [
            <c:forEach items="${models}" var="model" varStatus="status">
                {
                    modelId: ${model.modelId},
                    modelName: "${model.modelName}",
                    makeId: ${model.makeId}
                }<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];
        
        const years = [
            <c:forEach items="${years}" var="year" varStatus="status">
                {
                    yearId: ${year.yearId},
                    year: ${year.year},
                    modelId: ${year.modelId}
                }<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];
        
        const makeSelect = document.getElementById('makeSelect');
        const modelSelect = document.getElementById('modelSelect');
        const yearSelect = document.getElementById('yearSelect');
        
        // When make is selected, populate models dropdown
        makeSelect.addEventListener('change', function() {
            const selectedMakeId = parseInt(this.value);
            
            // Reset and disable year dropdown
            yearSelect.innerHTML = '<option value="" selected disabled>Select Year</option>';
            yearSelect.disabled = true;
            
            // Filter models for the selected make
            const filteredModels = models.filter(model => model.makeId === selectedMakeId);
            
            // Update model dropdown
            modelSelect.innerHTML = '<option value="" selected disabled>Select Model</option>';
            filteredModels.forEach(model => {
                const option = document.createElement('option');
                option.value = model.modelId;
                option.textContent = model.modelName;
                modelSelect.appendChild(option);
            });
            
            // Enable model dropdown if there are models available
            modelSelect.disabled = filteredModels.length === 0;
        });
        
        // When model is selected, populate years dropdown
        modelSelect.addEventListener('change', function() {
            const selectedModelId = parseInt(this.value);
            
            // Filter years for the selected model
            const filteredYears = years.filter(year => year.modelId === selectedModelId);
            
            // Update year dropdown
            yearSelect.innerHTML = '<option value="" selected disabled>Select Year</option>';
            filteredYears.forEach(year => {
                const option = document.createElement('option');
                option.value = year.yearId;
                option.textContent = year.year;
                yearSelect.appendChild(option);
            });
            
            // Enable year dropdown if there are years available
            yearSelect.disabled = filteredYears.length === 0;
        });
        
        // Make sure form can only be submitted when all required fields are filled
        /*const searchForm = document.querySelector('form[action*="SearchPartsSrv"]');
        if (searchForm) {
            searchForm.addEventListener('submit', function(event) {
                if (modelSelect.disabled || yearSelect.disabled || 
                    !makeSelect.value || !modelSelect.value || !yearSelect.value) {
                    event.preventDefault();
                    alert('Please select make, model, and year before searching');
                }
            });
        }*/
    });
    </script>
</body>
</html>