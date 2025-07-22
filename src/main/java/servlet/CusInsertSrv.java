package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Customer;
import service.CustomerCtrl;

//@WebServlet("/CusInsertSrv")
public class CusInsertSrv extends HttpServlet {

	private static final long serialVersionUID = 1L;
    private CustomerCtrl controller;

    @Override
	public void init() throws ServletException {
		controller = new CustomerCtrl();
	}
    
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
//	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Connected");
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String email = request.getParameter("email");
		String phoneNo = request.getParameter("phoneNo");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");
		
		if (!password.equals(confirmPassword)) {
			request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("bla.jsp").forward(request, response);
            return;
		}
		
		if (controller.isEmailRegistered(email)) {
            request.setAttribute("error", "Email is already registered.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }
		
		Customer cus = new Customer();
		cus.setEmail(email);
		cus.setFirstName(firstName);
		cus.setLastName(lastName);
		cus.setPhoneNo(phoneNo);
		cus.setPassword(password);

		boolean status = CustomerCtrl.registerCustomer(cus);
		
		if(status) {
            String alertMessage = "Data Insert Successful";
            response.getWriter().println("<script> alert('" + alertMessage + "'); window.location.href='"+request.getContextPath()+"/login.jsp?role=customer';</script>");
        } else {
        	response.getWriter().println("<script> alert('" + "unsuccessful" + "'); window.location.href='"+request.getContextPath()+"/Customer/register.jsp';</script>");
//            RequestDispatcher dis2 = request.getRequestDispatcher("wrong.jsp");
//            dis2.forward(request, response);
        }
		//doGet(request, response);
	}
	
	

}
