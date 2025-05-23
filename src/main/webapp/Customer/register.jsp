<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>spareiT | Register</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <!-- Custom theme CSS -->
    <link rel="stylesheet" href="../styles.css">
</head>
<body>

	<jsp:include page="../Partials/header.jsp"></jsp:include>
	
    <!-- Registration Section -->
    <section class="py-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-8 col-lg-7">
                    <div class="card shadow">
                        <div class="card-body p-5">
                            <div class="text-center mb-4">
                                <i class="fas fa-user-plus text-primary" style="font-size: 4rem;"></i>
                                <h2 class="mt-3 mb-4">Create an Account</h2>
                            </div>
                            
                            <form action="../CusInsertSrv" method="post">
                                <!-- Name inputs -->
                                <div class="row mb-4">
                                    <div class="col-md-6 mb-3 mb-md-0">
                                        <label for="firstName" class="form-label">First Name</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-dark-accent border-0">
                                                <i class="fas fa-user"></i>
                                            </span>
                                            <input type="text" class="form-control" id="firstName" name="firstName" placeholder="Enter first name" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="lastName" class="form-label">Last Name</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-dark-accent border-0">
                                                <i class="fas fa-user"></i>
                                            </span>
                                            <input type="text" class="form-control" id="lastName" name="lastName" placeholder="Enter last name" required>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Email input -->
                                <div class="mb-4">
                                    <label for="email" class="form-label">Email Address</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-dark-accent border-0">
                                            <i class="fas fa-envelope"></i>
                                        </span>
                                        <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
                                    </div>
                                </div>
                                
                                <!-- Phone input -->
                                <div class="mb-4">
                                    <label for="phone" class="form-label">Phone Number</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-dark-accent border-0">
                                            <i class="fas fa-phone"></i>
                                        </span>
                                        <input type="tel" class="form-control" id="phone" name="phoneNo" placeholder="Enter phone number" required>
                                    </div>
                                </div>
                                
                                <!-- Address input 
                                <div class="mb-4">
                                    <label for="address" class="form-label">Address</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-dark-accent border-0">
                                            <i class="fas fa-home"></i>
                                        </span>
                                        <input type="text" class="form-control" id="address" name="address" placeholder="Enter your address" required>
                                    </div>
                                </div>
                                -->
                                <!-- Password input -->
                                <div class="mb-4">
                                    <label for="password" class="form-label">Password</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-dark-accent border-0">
                                            <i class="fas fa-lock"></i>
                                        </span>
                                        <input type="password" class="form-control" id="password" name="password" placeholder="Create password" required>
                                    </div>
                                    <div class="form-text text-muted">
                                        Password must be at least 8 characters long with numbers and letters
                                    </div>
                                </div>
                                
                                <!-- Confirm Password input -->
                                <div class="mb-4">
                                    <label for="confirmPassword" class="form-label">Confirm Password</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-dark-accent border-0">
                                            <i class="fas fa-lock"></i>
                                        </span>
                                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm password" required>
                                    </div>
                                </div>
                                
                                <!-- Terms checkbox -->
                                <div class="mb-4 form-check">
                                    <input type="checkbox" class="form-check-input" id="agreeTerms" required>
                                    <label class="form-check-label" for="agreeTerms">
                                        I agree to the <a href="#" class="text-primary">Terms of Service</a> and <a href="#" class="text-primary">Privacy Policy</a>
                                    </label>
                                </div>
                                
                                <!-- Register button -->
                                <div class="d-grid gap-2 mb-4">
                                    <button type="submit" class="btn btn-primary btn-lg">Create Account</button>
                                </div>
                            </form>
                            
                            <!-- Login link -->
                            <div class="text-center">
                                <p class="mb-0">Already have an account? <a href="login.jsp" class="text-primary">Login</a></p>
                            </div>
                            
                            <!-- Social signup -->
                            <div class="text-center mt-4">
                                <p class="text-muted mb-3">Or register with</p>
                                <div class="d-flex justify-content-center gap-3">
                                    <a href="#" class="btn btn-outline-light px-3">
                                        <i class="fab fa-google"></i>
                                    </a>
                                    <a href="#" class="btn btn-outline-light px-3">
                                        <i class="fab fa-facebook-f"></i>
                                    </a>
                                    <a href="#" class="btn btn-outline-light px-3">
                                        <i class="fab fa-apple"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <jsp:include page="../Partials/footer.jsp"></jsp:include>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>