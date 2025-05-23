<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>

<%@ page import="java.util.*, model.Cart, model.Item, service.InventoryService" %>
<%
//edited 
    if (session == null || session.getAttribute("user") == null || !"customer".equals(session.getAttribute("user"))) {
        // Not logged in as customer
        response.sendRedirect(request.getContextPath() + "/login.jsp?role=customer");
        return;
    }
    
    // Initialize ItemCtrl for item lookups
    InventoryService inventory = new InventoryService();
    //System.out.println("cart1");
    // Get cart items from session
    //System.out.println(session.getAttribute("cartCount"));
    List<Cart> cartItems = (List<Cart>) request.getAttribute("cartItems");
    boolean cartIsEmpty = (cartItems == null || cartItems.isEmpty());
    //System.out.println("cart2");
    // Calculate totals if cart has items
    double subtotal = 0.0;
    //if (!cartIsEmpty) {
    //    for (Cart cart : cartItems) {
    //    	System.out.println(cart.getItemId());
    //        Item item = itemCtrl.getItemDetails(Integer.parseInt(cart.getItemId()));
    //        System.out.println(cart);
    //        if (item != null) {
    //            subtotal += item.getItemPrice() * cart.getQuantity();
    //        }
     //   }
    //}
    
    // Calculate tax and total
    double tax = 20;
    double total = 0;
    //double total = subtotal + tax;
%>
 
<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>spareiT | Shopping Cart</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <!-- Custom theme CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css">
</head>
<body>
    
    <jsp:include page="/Partials/header.jsp"></jsp:include>

    <!-- Shopping Cart Section -->
    <section class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-12">
                	<div class="d-flex align-items-center gap-3">
					    <h2 class="mb-4">Your Shopping Cart</h2>
					    
					    <% String message = (String) request.getAttribute("updateResult"); %>
						<% if (message != null) { %>
						    <div class="alert alert-info mb-0 p-2"><%= message %></div>
						<% } %>
					</div>
                    
                    
						
						
                    <% if (cartIsEmpty) { %>
                        <!-- Empty Cart Message -->
                        <div class="card bg-dark-accent p-5 text-center">
                            <div class="py-5">
                                <i class="fas fa-shopping-cart text-primary mb-4" style="font-size: 4rem;"></i>
                                <h3 class="mb-3">Your cart is empty</h3>
                                <p class="text-muted mb-4">Looks like you haven't added any items to your cart yet.</p>
                                <a href="${pageContext.request.contextPath}/IndexSrv" class="btn btn-primary">Search Spare Parts</a>
                            </div>
                        </div>
                        
                    <% } else { %>
                    
                    	
						
                        <!-- Cart Items -->
                        <div class="card bg-dark-accent mb-4">
                            <div class="card-header bg-dark-accent d-flex justify-content-between align-items-center">
                                <span><i class="fas fa-shopping-cart text-primary me-2"></i> Cart Items (<%= cartItems.size() %>)</span>
                                <a href="${pageContext.request.contextPath}/CartDeleteSrv" class="btn btn-sm btn-outline-danger">
                                    <i class="fas fa-trash-alt me-1"></i> Clear Cart
                                </a>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-dark mb-0">
                                        <thead>
                                            <tr>
                                                <th scope="col" style="width: 100px">Image</th>
                                                <th scope="col">Product</th>
                                                <th scope="col">Price</th>
                                                <th scope="col">Quantity</th>
                                                <th scope="col">Total</th>
                                                <th scope="col">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                for (Cart cart : cartItems) {
                                                    int quantity = cart.getQuantity();
                                                    Item item = inventory.getItemById(cart.getItemId());

                                                    if (item == null) continue;

                                                    double itemTotal = item.getItemPrice() * quantity;
                                                    total += total + itemTotal;
                                            %>
                                            <tr>
                                                <td>
                                                    <div class="bg-gray rounded" style="width: 80px; height: 80px; display: flex; align-items: center; justify-content: center;">
                                                        <i class="fas fa-tools text-primary" style="font-size: 2rem;"></i>
                                                    </div>
                                                </td>
                                                <td>
                                                    <h6 class="mb-1"><%= item.getItemName() %></h6>
                                                    <p class="text-muted small mb-0">Brand: <%= item.getItemBrand() %></p>
                                                    <span class="badge bg-primary-dark">Added on: <%= cart.calcDatediff() %></span>
                                                </td>
                                                <td>$<%= String.format("%.2f", item.getItemPrice()) %></td>
                                                <td>
                                                    <form action="${pageContext.request.contextPath}/CartUpdateSrv" method="post" class="quantity-form">
                                                        <div class="input-group input-group-sm" style="width: 120px;">
                                                            <button class="btn btn-outline-secondary decrement-btn" type="button">-</button>
                                                            <input type="text" name="quantity" class="form-control text-center" value="<%= quantity %>">
                                                            <button class="btn btn-outline-secondary increment-btn" type="button">+</button>
                                                            <input type="hidden" name="itemId" value="<%= cart.getItemId() %>">
                                                        </div>
                                                    </form>
                                                </td>
                                                <td class="fw-semibold">$<%= String.format("%.2f", itemTotal) %></td>
                                                <td>
                                                    <form action="${pageContext.request.contextPath}/CartItemDeletetSrv" method="post">
                                                        <input type="hidden" name="itemId" value="<%= cart.getItemId() %>"/>
                                                        <button type="submit" class="btn btn-sm btn-outline-danger">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                            <%
                                                } // end for
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Order Summary -->
                        <div class="row">
                        <!--  
                            <div class="col-md-8 mb-4 mb-md-0">
                                <div class="card bg-dark-accent mb-3">
                                    <div class="card-body">
                                        <h5 class="mb-3">Special Instructions</h5>
                                        <textarea class="form-control" name="specialInstructions" rows="3" placeholder="Add notes about your order"></textarea>
                                    </div>
                                </div>
                                
                                <div class="card bg-dark-accent">
                                    <div class="card-body">
                                        <h5 class="mb-3">Shipping Policy</h5>
                                        <p class="text-muted mb-0">Free shipping on orders over $100. Standard shipping takes 3-5 business days. Express shipping options available at checkout.</p>
                                    </div>
                                </div>
                            </div>-->
                            <div class="col-md-4">
                                <div class="card bg-dark-accent">
                                    <div class="card-header bg-dark-accent">
                                        <h5 class="mb-0">Order Summary</h5>
                                    </div>
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between mb-2">
                                            <span>Subtotal</span>
                                            <span>$<%= String.format("%.2f", total) %></span>
                                        </div>
                                        <div class="d-flex justify-content-between mb-2">
                                            <span>Shipping</span>
                                            <span class="text-success">Free</span>
                                        </div>
                                        <div class="d-flex justify-content-between mb-2">
                                            <span>Tax</span>
                                            <span>$<%= String.format("%.2f", tax) %></span>
                                        </div>
                                        <hr>
                                        <% double finalPrice = total + tax; %>
                                        <div class="d-flex justify-content-between mb-3 fw-bold">
                                            <span>Total</span>
                                            <span class="text-primary">$<%= String.format("%.2f", finalPrice) %></span>
                                        </div>
                                        
                                        <!-- Promo Code Input 
                                        <div class="mb-3">
                                            <label for="promoCode" class="form-label">Promo Code</label>
                                            <div class="input-group mb-3">
                                                <input type="text" class="form-control" id="promoCode" name="promoCode" placeholder="Enter code">
                                                <button class="btn btn-outline-primary" type="button" id="applyPromo">Apply</button>
                                            </div>
                                        </div>
                                        -->
                                        
                                        <div class="d-grid gap-2">
                                            <a href="${pageContext.request.contextPath}/#" class="btn btn-primary btn-lg">Proceed to Checkout</a>
                                            <a href="${pageContext.request.contextPath}/LoginSrv" class="btn btn-outline-light">Continue Shopping</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
    </section>

    <jsp:include page="/Partials/footer.jsp"></jsp:include>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script src="./cartscript.js"></script>
    <script>

        document.addEventListener('DOMContentLoaded', function() {
            const quantityForms = document.querySelectorAll('.quantity-form');
            
            quantityForms.forEach(form => {
                const decrementBtn = form.querySelector('.decrement-btn');
                const incrementBtn = form.querySelector('.increment-btn');
                const quantityInput = form.querySelector('input[name="quantity"]');
                
                decrementBtn.addEventListener('click', function() {
                    const value = parseInt(quantityInput.value);
                    if (value > 1) {
                        quantityInput.value = value - 1;
                        form.submit();
                    }
                });
                
                incrementBtn.addEventListener('click', function() {
                    const value = parseInt(quantityInput.value);
                    quantityInput.value = value + 1;
                    form.submit();
                });
                

                quantityInput.addEventListener('blur', function() {
                    const value = parseInt(quantityInput.value);
                    if (value < 1) {
                        quantityInput.value = 1;
                    }
                    form.submit();
                });
            });
            
        });
    </script>
    
    <script>
	    setTimeout(() => {
	        const alertBox = document.querySelector('.alert');
	        if (alertBox) {
	            alertBox.style.display = 'none';
	        }
	    }, 2000); // Hide after 3 seconds
	</script>
</body>
</html>