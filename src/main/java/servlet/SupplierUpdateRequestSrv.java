package servlet;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.RestockRequestController;

/**
 * Servlet implementation class UpdateRequestSvr
 */
@WebServlet("/SupplierUpdateRequestSrv")
public class SupplierUpdateRequestSrv extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SupplierUpdateRequestSrv() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		int supplierID = (int)session.getAttribute("userId");
        int itemID = Integer.parseInt(request.getParameter("itemID"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int requestID = Integer.parseInt(request.getParameter("requestID"));
        String requestDateStr = request.getParameter("requestDate");
        Date requestDate = Date.valueOf(requestDateStr);
        String status = "Pending";
 
        boolean isTrue;
        
        System.out.println(quantity);
   
        isTrue = RestockRequestController.updatedata(requestID, itemID, quantity, requestDate, 
                                               status);
 
        if(isTrue) {
            String alertMessage = "Data Update Successful";
            response.getWriter().println("<script> alert('" + alertMessage + "'); window.location.href='"+request.getContextPath()+"/SupplierDisplayRequestSrv';</script>");
        } else {
            RequestDispatcher dis2 = request.getRequestDispatcher("wrong.jsp");
            dis2.forward(request, response);
        }
	}


}
