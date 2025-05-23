package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.SuppliesController;

@WebServlet("/SupplierGetRegisteredItems")
public class SupplierGetRegisteredItems extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public SupplierGetRegisteredItems() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Get supplier ID from session
		HttpSession session = request.getSession();
		Integer supId = (Integer) session.getAttribute("userId");

		if (supId == null) {
			// Handle unauthorized access
			response.sendRedirect("login.jsp");
			return;
		}

		// Get item names
		SuppliesController controller = new SuppliesController();
		List<String[]> itemNames = controller.getItemNames(supId);
		
		// Add item list to request
		request.setAttribute("itemNames", itemNames);

		// Forward to JSP
		RequestDispatcher dispatcher = request.getRequestDispatcher("supplier/insertRequest.jsp");
		dispatcher.forward(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
}
