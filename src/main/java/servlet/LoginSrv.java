package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Agent;
import model.Customer;
import model.SupplierModel;
import model.User;
import service.AgentCtrl;
import service.CustomerCtrl;
import service.SupplierController;
import service.UserCtrl;


@WebServlet("/LoginSrv")
public class LoginSrv extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String email = request.getParameter("email");
	    String password = request.getParameter("password");
	    String userRole = request.getParameter("user");

	    UserCtrl controller = null;
	    User user = null;
	    
	    final String ADMIN_EMAIL = "nath@gmail.com";
	    final String ADMIN_PASSWORD = "nath";

	    // Admin login
	    if ("admin".equalsIgnoreCase(userRole)) {
	        if (ADMIN_EMAIL.equals(email) && ADMIN_PASSWORD.equals(password)) {
	            HttpSession session = request.getSession();
	            session.setAttribute("user", "admin");
	            session.setAttribute("name", "Nath");
	            session.setAttribute("userId", 1);
	            
	            //a url that doesnt exist yet. add ur inventory thing
	            response.getWriter().println("<script>alert('Admin logged in successfully'); window.location.href='" + request.getContextPath() + "/GetAllItems';</script>");
	        } else {
	            request.setAttribute("error", "Invalid admin credentials.");
	            request.getRequestDispatcher("/login.jsp?role=admin").forward(request, response);
	        }
	        return;
	    }
	    
	    switch (userRole.toLowerCase()) {
	        case "customer":
	            controller = new CustomerCtrl();
	            break;
	        case "agent":
	            controller = new AgentCtrl();
	            break;
	        case "supplier":
	            controller = new SupplierController();
	            break;
	        
	        default:
	            request.setAttribute("error", "Invalid user role.");
	            request.getRequestDispatcher("/login.jsp").forward(request, response);
	            return;
	    }

	    user = controller.loginValidate(email, password);

	    if (user == null) {
	        request.setAttribute("error", "Invalid email or password.");
	        request.getRequestDispatcher("/login.jsp?role=" + userRole).forward(request, response);
	        return;
	    }

	    HttpSession session = request.getSession();
	    session.setAttribute("user", userRole.toLowerCase());


	    String name = "";
	    int userId = -1;

	    switch (userRole.toLowerCase()) {
	        case "customer":
	            Customer customer = (Customer) user;
	            name = customer.getFirstName();
	            userId = customer.getCusId();
	            break;
	        case "agent":
	            Agent agent = (Agent) user;
	            name = agent.getSupporterName();
	            userId = agent.getSupporterId();
	            break;
	        case "supplier":
	            SupplierModel supplier = (SupplierModel) user;
	            name = supplier.getName();
	            userId = supplier.getSupplierID();
	            break;
	    }

	    session.setAttribute("name", name);
	    session.setAttribute("userId", userId);

	    response.getWriter().println("<script>alert('Logged in Successfully'); window.location.href='" + request.getContextPath() + "/IndexSrv';</script>");
	}

}
