<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
<head>
<meta charset="UTF-8">
</head>
<body>
<%@ page session="true" %>

<%
    String user = null;
    String name = null;
    int id;
    
   
    if (session.getAttribute("user") != null) {
        user = (String) session.getAttribute("user");
        name = (String) session.getAttribute("name");
        //id = Integer.parseInt((String) session.getAttribute("userId"));
        if (name != null && name.length() > 0) {
            name = name.substring(0, 1).toUpperCase() + name.substring(1);
        }
        
    }
%>

<%
    String currentPage = request.getRequestURI();
%>
<!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark-accent sticky-top">
        <div class="container">
        	
            <a class="navbar-brand" href="#">spareiT</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                	
                    <%if(!"admin".equals(user)){%>
	                    <li class="nav-item">
	                        <a class="nav-link <%= currentPage.endsWith("index.jsp") ? "active" : "" %>" href="<%= request.getContextPath() %>/IndexSrv">Home</a>
	                    </li>
	                    <li class="nav-item">
	                       	<a class="nav-link <%= currentPage.endsWith("inquiryInsert.jsp") ? "active" : "" %>" href="<%= request.getContextPath() %>/Inquiry/inquiryInsert.jsp">Support</a>
	                   	</li>
	                   	<li class="nav-item">
	                        <a class="nav-link <%= currentPage.endsWith("aboutUs.jsp") ? "active" : "" %>" href="<%= request.getContextPath() %>/aboutUs.jsp">About Us</a>
	                    </li>
                    <% } %> 
                    <%if("admin".equals(user)){%>
                    	<li class="nav-item">
                        	<a class="nav-link <%= currentPage.endsWith("partsCatalog.jsp") ? "active" : "" %>" href="<%= request.getContextPath() %>/GetAllItems">Parts Catalog</a>
                    	</li>
                    	<li class="nav-item">
                        	<a class="nav-link <%= currentPage.endsWith("CreateItem.jsp") ? "active" : "" %>" href="<%= request.getContextPath() %>/CreateItem">Add Item</a>
                    	</li>
                    <% } %> 
                    <%if("supplier".equals(user)){%>
                    	<li class="nav-item">
                        	<a class="nav-link <%= currentPage.endsWith("insertRequest.jsp") ? "active" : "" %>" href="<%= request.getContextPath() %>/SupplierGetRegisteredItems">Restock Requests</a>
                    	</li>
                    <% } %> 
                    
                </ul>
                
                
                
                <div class="d-flex align-items-center">
                
                <!-- if logged in -->
                <%if(user != null){ %>
                
                	<!-- if user = customer display cart icon with the cart count -->
	                <% if ("customer".equals(user)) { 
		                    int cartCount = 0;
			                if (session.getAttribute("cartCount") != null) {
					        	cartCount = (Integer) session.getAttribute("cartCount");}%>
					        
		                    <a href="<%= request.getContextPath() %>/CartGetAllSrv" class="me-3 position-relative d-flex align-items-center text-decoration-none">
		                        <i class="fas fa-shopping-cart text-primary" style="font-size: 1.4rem;"></i>
		                        
		                    <% if (cartCount > 0) { %>
		                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-primary">
		                            <%= cartCount %>
		                            <span class="visually-hidden">items in cart</span>
		                        </span>
		                    <% } %>
		                    </a>
                    <% } %>
                    
                    
                    
                    <!-- for all logged in user display name and profile icon -->
                    <div class="dropdown">
                        <button class="btn d-flex align-items-center gap-2" type="button" id="userMenu"
                                data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fas fa-user-circle fs-4 text-primary" style="font-size: 1.8rem;"></i>
                            <span class="text-white fw-semibold"><%= name %></span>
                        </button>
                        
                        <ul class="dropdown-menu dropdown-menu-end dropdown-menu-dark" aria-labelledby="userMenu">
                        
							<% if("customer".equals(user)) { %>
                            <li><a class="dropdown-item" href="<%= request.getContextPath() %>/CusDisplaySrv">Profile</a></li>
                            
                            <% } else if("agent".equals(user)){ %>
                            <li><a class="dropdown-item" href="<%= request.getContextPath() %>/InquiryDisplaySrv">View Inquiries</a></li>
                            
                           	<% } else if("supplier".equals(user)){ %>
                            <li><a class="dropdown-item" href="<%= request.getContextPath() %>/SupplierDisplayRequestSrv">View Requests</a></li>
                            
                           	<% } %>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="<%= request.getContextPath() %>/LogoutSrv">Logout</a></li>
                        </ul>
                        
                    </div>
                    
                    <!-- if not logged in -->
                <% } else { %>
                    <div class="dropdown me-2">
                        <button class="btn btn-outline-light" type="button" id="signinDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                            Sign In
                        </button>
                        <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="signinDropdown">
                            <li><a class="dropdown-item" href="<%= request.getContextPath() %>/login.jsp?role=customer">Customer</a></li>
                            <li><a class="dropdown-item" href="<%= request.getContextPath() %>/login.jsp?role=agent">Agent</a></li>
                            <li><a class="dropdown-item" href="<%= request.getContextPath() %>/login.jsp?role=supplier">Supplier</a></li>
                            <li><a class="dropdown-item" href="<%= request.getContextPath() %>/login.jsp?role=admin">Admin</a></li>
                        </ul>
                    </div>
                    
                    <!-- only customer can register -->
                    <a href="<%= request.getContextPath() %>/Customer/register.jsp" class="btn btn-primary">Register</a>
                    
                <% } %>
                
                </div>
            </div>
        </div>
    </nav>

</body>
</html>