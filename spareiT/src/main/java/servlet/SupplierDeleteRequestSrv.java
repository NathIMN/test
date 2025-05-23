package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.RestockRequestController;

/**
 * Servlet implementation class DeleteRequestSvr
 */
@WebServlet("/SupplierDeleteRequestSrv")
public class SupplierDeleteRequestSrv extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SupplierDeleteRequestSrv() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		int supplierID = (int)session.getAttribute("userId");
		int requestID = Integer.parseInt(request.getParameter("id"));
		
		RestockRequestController.deletedata(requestID);
		
		RequestDispatcher dis2 = request.getRequestDispatcher("SupplierDisplayRequestSrv");
        dis2.forward(request, response);
	}

}
