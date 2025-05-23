package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.CartCtrl;
import service.CustomerCtrl;

/**
 * Servlet implementation class CusDeleteSrv
 */
@WebServlet("/CusDeleteSrv")
public class CusDeleteSrv extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CusDeleteSrv() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?role=customer");
            return;
        }
        
        boolean isTrue;
        CustomerCtrl controller = new CustomerCtrl();
        int cusId = (Integer) session.getAttribute("userId");
        String password = request.getParameter("password");
        isTrue = controller.verifyCustomer(cusId, password);
        
        System.out.println("Customer deletion result: " + isTrue);

        boolean isDelete;
        
        if (isTrue) {
            
            session.invalidate(); 
            isDelete = controller.deleteCustomer(cusId);
            
            if(isDelete) {
            	response.sendRedirect(request.getContextPath() + "/IndexSrv");
            }else {
                
                request.setAttribute("errorMessage", "Coudn't Delete the Account. Try again");
                request.getRequestDispatcher("/Customer/profile.jsp").forward(request, response);
            }
            
        }else {
        	request.setAttribute("errorMessage", "Password incorrect. Try again");
            request.getRequestDispatcher("/Customer/profile.jsp").forward(request, response);
        }
	}

}
