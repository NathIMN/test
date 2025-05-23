<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="model.Item , model.Make, model.Model, model.Year"%>

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
</head>

<body>

	<jsp:include page="/Partials/header.jsp"></jsp:include>
	
	<!-- Search Results -->
    <div class="container my-5">
        <h1 class="text-light mb-4">Search Results</h1>
        
        <% 
        ArrayList<Item> results = (ArrayList<Item>) request.getAttribute("results");
        if (results != null && !results.isEmpty()) { 
        %>
            <div class="row row-cols-1 row-cols-md-3 g-4">
                <% for (Item item : results) { %>
                    <div class="col">
                        <div class="card h-100">
                            <div class="card-body">
                                <h5 class="card-title text-light"><%= item.getItemName() %></h5>
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <span class="text-warning">
                                        <i class="fas fa-car feature-icon me-2"></i>
                                        <%= item.getItemBrand() %> | <%= item.getItemCategory() %>
                                    </span>
                                </div>
                                <div class="d-flex justify-content-between align-items-center">
                                    <h4 class="text-light">$<%= String.format("%.2f", item.getItemPrice()) %></h4>
                                    <span class="badge bg-primary">
                                    <%if(item.getItemStocks()> 0){ %>
                                        in stock
                                    <% }else{ %>   
                                    	out of stock
                                    <% } %> 
                                    </span>
                                </div>
                                
                                <% if (item.getYearList() != null && !item.getYearList().isEmpty()) { %>
                                    <div class="mt-3">
                                        <small class="text-lighter-gray">Compatible Years:</small>
                                        <div class="d-flex flex-wrap">
                                            <% 
                                            ArrayList<Year> years = item.getYearList();
                                            LinkedHashSet<Integer> uniqueYears = new LinkedHashSet<>();
                                            for (Year year : years) {
                                                uniqueYears.add(year.getYear());
                                            }
                                            for (Integer yearNo : uniqueYears) { 
                                            %>
                                                <span class="badge bg-gray me-1 mb-1"><%= yearNo %></span>
                                            <% } %>
                                        </div>
                                    </div>
                                <% } %>
                            </div>
                            <div class="card-footer bg-dark-accent border-0">
                                <form action="CartInsertSrv" method="post" class="d-grid">
                                    <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-cart-plus me-2"></i>Add to Cart
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } else { %>
            <div class="alert bg-gray text-light" role="alert">
                No results found. Please try a different search query.
            </div>
        <% } %>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	
	<jsp:include page="/Partials/footer.jsp"></jsp:include>
	
</body>
</html>