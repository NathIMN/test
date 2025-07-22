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

@WebServlet("/SupplierInsertRequestSrv")
public class SupplierInsertRequestSrv extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Parse integer and string values correctly
		HttpSession session = request.getSession();
//		int supplierID = Integer.parseInt((String) session.getAttribute("userId"));
		int supplierID = (int)session.getAttribute("userId");
        int itemID = Integer.parseInt(request.getParameter("itemID"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String requestDateStr = request.getParameter("requestDate");
        Date requestDate = Date.valueOf(requestDateStr);
        String status = "Pending";
 
        boolean isTrue;
        
        
        isTrue = RestockRequestController.insertdata(itemID, supplierID, quantity, requestDate, 
                                               status);
        
        
        if(isTrue) {
            String alertMessage = "Data Insert Successful";
            response.getWriter().println("<script> alert('" + alertMessage + "'); window.location.href='"+request.getContextPath()+"/SupplierDisplayRequestSrv';</script>");
        } else {
            RequestDispatcher dis2 = request.getRequestDispatcher("wrong.jsp");
            dis2.forward(request, response);
        }
    }
}

