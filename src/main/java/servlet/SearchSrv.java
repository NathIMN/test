package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
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

import model.Item;
import service.InventoryService;

@WebServlet("/SearchSrv")
public class SearchSrv extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SearchSrv() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		ArrayList<Item> results = new ArrayList<>();
		res.setContentType("text/html");
		InventoryService inventoryService = new InventoryService();
		
		String keyword = req.getParameter("keyword");
		int makeId = Integer.parseInt(req.getParameter("make"));
		int modelId = Integer.parseInt(req.getParameter("model"));
		int year = Integer.parseInt(req.getParameter("year"));
		
		results = inventoryService.searchItems(keyword, makeId, modelId, year);
		
		req.setAttribute("results", results);
		RequestDispatcher rd = req.getRequestDispatcher("/search.jsp");
		rd.forward(req, res);
	}
}
