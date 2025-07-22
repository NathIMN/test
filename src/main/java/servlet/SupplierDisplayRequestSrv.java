package servlet;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.RestockRequestModel;
import service.RestockRequestController;

/**
 * Servlet implementation class DisplayRequestSvr
 */
@WebServlet("/SupplierDisplayRequestSrv")
public class SupplierDisplayRequestSrv extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SupplierDisplayRequestSrv() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		int supplierID = (int)session.getAttribute("userId");
        
		ArrayList<RestockRequestModel> requests = RestockRequestController.getdata(supplierID);
		
		for(RestockRequestModel rq : requests) {
			System.out.println(rq.getRequestDate());
		}
        
		request.setAttribute("requests", requests);
		RequestDispatcher dis2 = request.getRequestDispatcher("supplier/displayRequest.jsp");
        dis2.forward(request, response);
	}

}
