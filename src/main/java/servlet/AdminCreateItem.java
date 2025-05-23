package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Item;
import service.InventoryService;
import util.DBConnectionUtil;

@WebServlet("/CreateItem")
public class AdminCreateItem extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminCreateItem() {
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
    	
    	Connection conn = null;
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;

    	List<String> categories = new ArrayList<>();
    	List<Map<String, Object>> makes = new ArrayList<>();
    	List<Map<String, Object>> models = new ArrayList<>();
    	List<Map<String, Object>> years = new ArrayList<>();

    	int nextItemId = 1;

    	try {
    	    conn = DBConnectionUtil.getConnection();

    	    pstmt = conn.prepareStatement("SELECT DISTINCT itemCategory FROM Item WHERE itemCategory IS NOT NULL");
    	    rs = pstmt.executeQuery();
    	    while (rs.next()) {
    	        categories.add(rs.getString("itemCategory"));
    	    }

    	    pstmt = conn.prepareStatement("SELECT makeId, makeName FROM Make");
    	    rs = pstmt.executeQuery();
    	    while (rs.next()) {
    	        Map<String, Object> make = new HashMap<>();
    	        make.put("makeId", rs.getInt("makeId"));
    	        make.put("makeName", rs.getString("makeName"));
    	        makes.add(make);
    	    }

    	    pstmt = conn.prepareStatement("SELECT modelId, modelName, makeId FROM Model");
    	    rs = pstmt.executeQuery();
    	    while (rs.next()) {
    	        Map<String, Object> model = new HashMap<>();
    	        model.put("modelId", rs.getInt("modelId"));
    	        model.put("modelName", rs.getString("modelName"));
    	        model.put("makeId", rs.getInt("makeId"));
    	        models.add(model);
    	    }

    	    pstmt = conn.prepareStatement("SELECT yearId, year, modelId FROM Year");
    	    rs = pstmt.executeQuery();
    	    while (rs.next()) {
    	        Map<String, Object> year = new HashMap<>();
    	        year.put("yearId", rs.getInt("yearId"));
    	        year.put("year", rs.getInt("year"));
    	        year.put("modelId", rs.getInt("modelId"));
    	        years.add(year);
    	    }

    	    pstmt = conn.prepareStatement("SELECT MAX(itemId) as maxId FROM Item");
    	    rs = pstmt.executeQuery();
    	    if (rs.next()) {
    	        nextItemId = rs.getInt("maxId") + 1;
    	    }

    	} catch (Exception e) {
    	    e.printStackTrace();
    	} finally {
    	    if (rs != null) try { rs.close(); } catch (SQLException e) { }
    	    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { }
    	    if (conn != null) try { conn.close(); } catch (SQLException e) { }
    	}
    	
    	req.setAttribute("categories", categories);
    	req.setAttribute("makes", makes);
    	req.setAttribute("models", models);
    	req.setAttribute("years", years);
    	req.setAttribute("nextItemId", nextItemId);
    	
    	RequestDispatcher rd = req.getRequestDispatcher("admin/CreateItem.jsp");
		rd.forward(req, res);
    }

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		Item item = new Item();
		ArrayList<Integer> comp = new ArrayList<>();
		res.setContentType("text/html");
		InventoryService inventoryService = new InventoryService();
		
		item.setItemId(Integer.parseInt(req.getParameter("itemId")));
		item.setItemName(req.getParameter("itemName"));
		item.setItemBrand(req.getParameter("itemBrand"));
		item.setItemCategory(req.getParameter("itemCategory"));
		item.setItemPrice(Double.parseDouble(req.getParameter("itemPrice")));
		item.setItemStocks(Integer.parseInt(req.getParameter("itemStocks")));
		
		int compatCount = Integer.parseInt(req.getParameter("compatCount"));
	    
	    for (int i = 1; i <= compatCount; i++) {
	        if (req.getParameter("make_" + i) != null) {
	            String[] selectedYears = req.getParameterValues("years_" + i + "[]");
	            
	            if (selectedYears != null && selectedYears.length > 0) {
	                for (String yearId : selectedYears) {
	                    try {
	                        comp.add(Integer.parseInt(yearId));
	                    } catch (NumberFormatException e) {
	                        System.out.println("Invalid yearId: " + yearId);
	                    }
	                }
	            }
	        }
	    }
		
		inventoryService.createItem(item, comp);
		
		req.setAttribute("item", item);
		req.setAttribute("itemId", item.getItemId());
		RequestDispatcher rd = req.getRequestDispatcher("GetItemById");
		rd.forward(req, res);
	}
}
