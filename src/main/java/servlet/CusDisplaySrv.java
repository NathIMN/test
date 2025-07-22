package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Customer;
import model.InquiryModel;
import service.CustomerCtrl;
import service.InquiryController;

/**
 * Servlet implementation class CusDisplaySrv
 */
@WebServlet("/CusDisplaySrv")
public class CusDisplaySrv extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CusDisplaySrv() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		System.out.println("are u there");
		if (session == null || session.getAttribute("user") == null || !"customer".equals(session.getAttribute("user"))) {
            // Not logged in as customer
            response.sendRedirect(request.getContextPath() + "/login.jsp?role=customer");
            return;
        }
		
        if (session != null && "customer".equals(session.getAttribute("user"))) {
        	
        	//user profile information
            int cusId = (Integer) session.getAttribute("userId");
            CustomerCtrl controller = new CustomerCtrl();
            Customer customer = controller.getCustomerById(cusId);
            System.out.println("i got here");
            request.setAttribute("customer", customer);
            
            //user inquiry information
            List<InquiryModel> allInquiries = null;
            allInquiries = InquiryController.getInquiriesByCustomerId(cusId);
            request.setAttribute("allInquiries", allInquiries);
            
            request.getRequestDispatcher("/Customer/customerProfile.jsp").forward(request, response);

            
        }
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		System.out.println("are u there");
		if (session == null || session.getAttribute("user") == null || !"customer".equals(session.getAttribute("user"))) {
            // Not logged in as customer
            response.sendRedirect(request.getContextPath() + "/login.jsp?role=customer");
            return;
        }
		
        if (session != null && "customer".equals(session.getAttribute("user"))) {
            int cusId = (Integer) session.getAttribute("userId");
            CustomerCtrl controller = new CustomerCtrl();
            Customer customer = controller.getCustomerById(cusId);
            System.out.println("i got here");
            request.setAttribute("customer", customer);
            
            //user inquiry information
            List<InquiryModel> allInquiries = null;
            allInquiries = InquiryController.getInquiriesByCustomerId(cusId);
            request.setAttribute("allInquiries", allInquiries);
            
            request.getRequestDispatcher("/Customer/customerProfile.jsp").forward(request, response);

            
        }
	}

}
