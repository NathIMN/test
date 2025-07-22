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
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
   
    <link rel="stylesheet" type="text/css" href="./styles.css">
</head>

<body>

	<jsp:include page="/Partials/header.jsp"></jsp:include>
	
	
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
                            	<div class="d-flex justify-content-between align-items-center">
                                    <h5 class="card-title text-light"><%= item.getItemName() %></h5>
                                    <span class="text-warning m-2">
									  <% 
									    String category = item.getItemCategory().toLowerCase();
									    String iconClass = "fas fa-car"; // default icon
									
									    switch (category) {
									      case "brakes":
									        iconClass = "fas fa-tools";
									        break;
									      case "suspension":
									        iconClass = "fas fa-compress-arrows-alt";
									        break;
									      case "engine":
									        iconClass = "fas fa-cogs";
									        break;
									      case "electrical":
									        iconClass = "fas fa-bolt";
									        break;
									      case "transmission":
									        iconClass = "fas fa-cogs";
									        break;
									      case "exhaust":
									        iconClass = "fas fa-smog";
									        break;
									      case "cooling":
									        iconClass = "fas fa-fan";
									        break;
									      case "steering":
									        iconClass = "fas fa-compass";
									        break;
									      case "body":
									        iconClass = "fas fa-cube";
									        break;
									    }
									  %>
									  <i class="<%= iconClass %> feature-icon"  style="font-size: 1.5rem;"></i>
									</span>

                                </div>
                                
								
								<div class="bg-gray rounded mb-3 position-relative" style="width: auto; height: 250px; display: flex; align-items: center; justify-content: center; overflow: hidden;">
  
								 
								  <img src="https://raw.githubusercontent.com/BadgerMole6276/spareiTimages/main/items/<%= item.getItemId() %>.jpg" 
								       alt="Item ${item.itemId}" 
								       class="item-image"
								       style="width: 100%; height: 100%; object-fit: fill; display: none;"
								       onerror="this.style.display='none'; this.nextElementSibling.style.display='inline-block';" 
								       onload="this.style.display='block'; this.nextElementSibling.style.display='none';">
								
								  
								  <i class="fas fa-tools text-primary" style="font-size: 2rem; display: none;"></i>
								
								 
								  <span class="badge bg-primary position-absolute" style="bottom: 10px; right: 10px;">
								    <% if(item.getItemStocks() > 0) { %>
								      In Stock
								    <% } else { %>   
								      Out of Stock
								    <% } %> 
								  </span>
								</div>

                                                    
                                <div class="d-flex justify-content-between align-items-center">
                                    <h4 class="text-light">$<%= String.format("%.2f", item.getItemPrice()) %></h4>
                                    <span class="text-warning">
								    	<%= item.getItemBrand() %> | <%= item.getItemCategory() %>
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