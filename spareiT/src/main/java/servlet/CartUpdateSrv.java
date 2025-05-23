package servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import service.CartCtrl;

@WebServlet("/CartUpdateSrv")
public class CartUpdateSrv extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CartCtrl cartCtrl;

    @Override
    public void init() throws ServletException {
        cartCtrl = new CartCtrl();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null && "customer".equals(session.getAttribute("user"))) {
            int cusId = (Integer) session.getAttribute("userId");
            int itemId = Integer.parseInt(request.getParameter("itemId"));
            int newQty = Integer.parseInt(request.getParameter("quantity"));

            String result = cartCtrl.updateItemToCart(cusId, itemId, newQty);
            
            int updatedCount = cartCtrl.getCartCount(cusId);
        	System.out.println("updatedCount" + updatedCount);
        	session.setAttribute("cartCount", updatedCount);

            request.setAttribute("updateResult", result);
            request.getRequestDispatcher("/CartGetAllSrv").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/login.jsp?role=customer");
        }
    }
}
