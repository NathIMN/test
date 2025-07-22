package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import service.CartCtrl;

@WebServlet("/CartInsertSrv")
public class CartInsertSrv extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private CartCtrl cartCtrl;

    @Override
    public void init() throws ServletException {
        cartCtrl = new CartCtrl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	HttpSession session = request.getSession();
    	if (session == null || session.getAttribute("user") == null || !"customer".equals(session.getAttribute("user"))) {
            // if not logged in as a customer redirect to customer login page
            response.sendRedirect(request.getContextPath() + "/login.jsp?role=customer");
            return;
        }
    	
        try {
        	
        	int cusId = (int) session.getAttribute("userId");
            int itemId = Integer.parseInt(request.getParameter("itemId"));
            int quantity = 1; 
            System.out.println(cusId + itemId + quantity);
            String result = cartCtrl.addToCart(cusId, itemId, quantity);

            if ("Success".equals(result)) {
            	int updatedCount = cartCtrl.getCartCount(cusId);
            	System.out.println("updatedCount" + updatedCount);
            	session.setAttribute("cartCount", updatedCount);
            	response.getWriter().println("<script>alert('Item added successfully!'); window.location.href=document.referrer;</script>");


//                response.getWriter().println("<script>alert('Item added to cart successfully!');"
//                        + "window.location.href='" + request.getContextPath() + "/Customer/cart.jsp';</script>");
            } else {
                response.getWriter().println("<script>alert('Failed to add item: " + result + "');"
                        + "window.location.href='" + request.getContextPath() + "/Customer/cart.jsp';</script>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Something went wrong');"
                    + "window.location.href='" + request.getContextPath() + "/index.jsp';</script>");
        }
    }
}

