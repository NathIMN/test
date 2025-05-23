package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Item;
import service.InventoryService;

@WebServlet("/GetItemById")
public class AdminGetItemById extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminGetItemById() {
        super();
    }

	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setContentType("text/html");
		
		HttpSession session = req.getSession();
		String user = new String();
		if(session != null) user = (String)session.getAttribute("user");
		if(user == null || !user.equalsIgnoreCase("admin")) {
			String alertMessage = "must be logged in as admin";
			res.getWriter().println("<script> alert('" + alertMessage + "'); window.location.href='" + req.getContextPath() + "/admin/Home.jsp';</script>");
			return;
		}
		
		InventoryService inventoryService = new InventoryService();

		Item item = inventoryService.getItemById(Integer.parseInt(req.getParameter("itemId")));
		System.out.println(item.getIndex());
		
		req.setAttribute("item", item);
		RequestDispatcher rd = req.getRequestDispatcher("admin/Item.jsp");
		rd.forward(req, res);
	}
}
