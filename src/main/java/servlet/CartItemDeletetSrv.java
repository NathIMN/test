package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.CartCtrl;

@WebServlet("/CartItemDeletetSrv")
public class CartItemDeletetSrv extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public CartItemDeletetSrv() {
        super();
        // TODO Auto-generated constructor stub
    }

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
            cartCtrl.removeItemFromCart(cusId, itemId);
            response.sendRedirect(request.getContextPath() + "/CartGetAllSrv");
        } else {
            response.sendRedirect(request.getContextPath() + "/login.jsp?role=customer");
        }
    }
}

