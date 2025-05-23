package servlet;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Item;
import service.InventoryService;

@WebServlet("/UpdateItem")
public class AdminUpdateItem extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminUpdateItem() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
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
		RequestDispatcher rd = req.getRequestDispatcher("admin/UpdateItem.jsp");
		rd.forward(req, res);
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		Item item = new Item();
		res.setContentType("text/html");
		InventoryService inventoryService = new InventoryService();
		
		req.getParameterMap().forEach((key, val) -> System.out.println(key + " = " + Arrays.toString(val)));

		
		item.setItemId(Integer.parseInt(req.getParameter("itemId")));
		item.setItemName(req.getParameter("itemName"));
		item.setItemBrand(req.getParameter("itemBrand"));
		item.setItemCategory(req.getParameter("itemCategory"));
		item.setItemPrice(Double.parseDouble(req.getParameter("itemPrice")));
		item.setItemStocks(Integer.parseInt(req.getParameter("itemStocks")));
		
		inventoryService.updateItem(item);
		
		req.setAttribute("item", item);
		req.setAttribute("itemId", item.getItemId());
		RequestDispatcher rd = req.getRequestDispatcher("GetAllItems");
		rd.forward(req, res);
	}
}
