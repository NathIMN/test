package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.RequestDispatcher;

import model.Cart;
import service.CartCtrl;
//edited
@WebServlet("/CartGetAllSrv")
public class CartGetAllSrv extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private CartCtrl cartCtrl;

    @Override
    public void init() throws ServletException {
        cartCtrl = new CartCtrl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    	
        HttpSession session = request.getSession(false); // false to avoid creating if not exists

        if (session == null || session.getAttribute("user") == null || !"customer".equals(session.getAttribute("user"))) {
            // Not logged in as customer
            response.sendRedirect(request.getContextPath() + "/login.jsp?role=customer");
            return;
        }

        try {
            int cusId = (Integer) session.getAttribute("userId");
            List<Cart> cartItems = cartCtrl.getAllCartItems(cusId);

            request.setAttribute("cartItems", cartItems);
            
            int updatedCount = cartCtrl.getCartCount(cusId);
        	System.out.println("updatedCount" + updatedCount);
        	session.setAttribute("cartCount", updatedCount);
        	
        	String updateResult = (String) request.getAttribute("updateResult");
        	request.setAttribute("updateResult", updateResult);
        	
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Customer/cart.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/indexSrv.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        doGet(request, response); 
    }
}
