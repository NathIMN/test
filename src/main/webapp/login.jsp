<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>spareiT | Login</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <!-- Custom theme CSS (minimal) -->
    <link rel="stylesheet" href="./styles.css">
</head>
<body>
    
    <jsp:include page="/Partials/header.jsp"></jsp:include>

    <!-- Login Section -->
    <section class="py-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6 col-lg-5">
                    <div class="card shadow">
                        <div class="card-body p-5">
                            <div class="text-center mb-4">
                                <i class="fas fa-user-circle text-primary" style="font-size: 4rem;"></i>
                                <%
                                
								    String role = request.getParameter("role");
								    String userRole = "User";
								    if ("customer".equalsIgnoreCase(role)) {
								        userRole = "Customer";//dont change the uppercase here. heeeee
								    } else if ("agent".equalsIgnoreCase(role)) {
								        userRole = "Agent";
								    } else if ("supplier".equalsIgnoreCase(role)) {
								        userRole = "Supplier";
								    }else if ("admin".equalsIgnoreCase(role)) {
								        userRole = "Admin";
								    }
								%>
								<h2 class="mt-3 mb-4"><%= userRole %> Login</h2>
                            </div>
                            
                            <form action="LoginSrv" method="post">
                                <!-- Username input -->
                                <div class="mb-4">
                                    <label for="username" class="form-label">Username</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-dark-accent border-0">
                                            <i class="fas fa-user"></i>
                                        </span>
                                        <input type="text" class="form-control" id="username" name="email" placeholder="Enter your username" required>
                                    </div>
                                </div>
                                
                                <!-- Password input -->
                                <div class="mb-4">
                                    <div class="d-flex justify-content-between">
                                        <label for="password" class="form-label" >Password</label>
                                        <a href="#" class="text-primary small">Forgot Password?</a>
                                    </div>
                                    <div class="input-group">
                                        <span class="input-group-text bg-dark-accent border-0">
                                            <i class="fas fa-lock"></i>
                                        </span>
                                        <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
                                    </div>
                                </div>
                                
                                <input type="hidden" name="user" value="<%= userRole %>">
                                
                                <% if (request.getAttribute("error") != null) { %>
						            <div class="mt-3 alert alert-danger">
						                <%= request.getAttribute("error") %>
						            </div>
						        <% } %>
                                <!-- Login button -->
                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-primary btn-lg">Login</button>
                                </div>
                            </form>
                            
                            <% if("customer".equals(role)){ %>
                            <div class="text-center mt-4">
                                <p class="mb-0">Don't have an account? <a href="/mypro/Customer/register.jsp" class="text-primary">Register</a></p>
                            </div>
                            <% } %>
                            <!-- Social login -->
                            <div class="text-center mt-4">
                                <p class="text-muted mb-3">Or login with</p>
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

    <jsp:include page="/Partials/footer.jsp"></jsp:include>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>