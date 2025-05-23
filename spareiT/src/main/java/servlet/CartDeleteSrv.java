package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.CartCtrl;

@WebServlet("/CartDeleteSrv")
public class CartDeleteSrv extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public CartDeleteSrv() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?role=customer");
            return;
        }

        int cusId = (Integer) session.getAttribute("userId");

        CartCtrl controller = new CartCtrl();
        String result = controller.clearCart(cusId);
        System.out.println("Cart deletion result: " + result);

        session.setAttribute("cartCount", 0);

        if ("Success".equalsIgnoreCase(result)) {
            response.sendRedirect(request.getContextPath() + "/CartGetAllSrv");
        } else {
            response.getWriter().println("<script>alert('Failed to clear cart: " + result + "');"
                    + "window.location.href='" + request.getContextPath() + "/Customer/cart.jsp';</script>");
        }
    }
}
