package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.CustomerCtrl;

/**
 * Servlet implementation class CusUpdateSrv
 */
@WebServlet("/CusUpdateSrv")
public class CusUpdateSrv extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
        if (session != null && "customer".equals(session.getAttribute("user"))) {
        	
        	CustomerCtrl controller = new CustomerCtrl();
            int cusId = (Integer) session.getAttribute("userId");
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
    		String email = request.getParameter("email");
    		String phoneNo = request.getParameter("phoneNo");

			String result = controller.updateCustomer(cusId, firstName, lastName, email, phoneNo);
            
            
        	System.out.println("Customer update " + result);
        	

            request.setAttribute("successMessage", result);
            request.getRequestDispatcher("/CusDisplaySrv").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/login.jsp?role=customer");
        }
	}

}
