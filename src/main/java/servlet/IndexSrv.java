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
import java.util.ResourceBundle;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/IndexSrv")
public class IndexSrv extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public IndexSrv() {
        super();
    }
    
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    	res.setContentType("text/html");
    	
    	Connection conn = null;
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;

    	// Lists to store data
    	List<String> categories = new ArrayList<>();
    	List<Map<String, Object>> makes = new ArrayList<>();
    	List<Map<String, Object>> models = new ArrayList<>();
    	List<Map<String, Object>> years = new ArrayList<>();

    	int nextItemId = 1;

    	try {
    	    // Update with your database connection details
    		ResourceBundle rb = ResourceBundle.getBundle("application");
			String url = rb.getString("url");
			String driverName = rb.getString("driverName");
			String username = rb.getString("username");
			String password = rb.getString("password");

    	    Class.forName(driverName);
    	    conn = DriverManager.getConnection(url, username, password);

    	    pstmt = conn.prepareStatement("SELECT DISTINCT itemCategory FROM item WHERE itemCategory IS NOT NULL");
    	    rs = pstmt.executeQuery();
    	    while (rs.next()) {
    	        categories.add(rs.getString("itemCategory"));
    	    }

    	    pstmt = conn.prepareStatement("SELECT makeId, makeName FROM make");
    	    rs = pstmt.executeQuery();
    	    while (rs.next()) {
    	        Map<String, Object> make = new HashMap<>();
    	        make.put("makeId", rs.getInt("makeId"));
    	        make.put("makeName", rs.getString("makeName"));
    	        makes.add(make);
    	    }

    	    pstmt = conn.prepareStatement("SELECT modelId, modelName, makeId FROM model");
    	    rs = pstmt.executeQuery();
    	    while (rs.next()) {
    	        Map<String, Object> model = new HashMap<>();
    	        model.put("modelId", rs.getInt("modelId"));
    	        model.put("modelName", rs.getString("modelName"));
    	        model.put("makeId", rs.getInt("makeId"));
    	        models.add(model);
    	    }

    	    // Get all years with their associated modelId
    	    pstmt = conn.prepareStatement("SELECT yearId, year, modelId FROM year");
    	    rs = pstmt.executeQuery();
    	    while (rs.next()) {
    	        Map<String, Object> year = new HashMap<>();
    	        year.put("yearId", rs.getInt("yearId"));
    	        year.put("year", rs.getInt("year"));
    	        year.put("modelId", rs.getInt("modelId"));
    	        years.add(year);
    	    }

    	    pstmt = conn.prepareStatement("SELECT MAX(itemId) as maxId FROM item");
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
    	
    	RequestDispatcher rd = req.getRequestDispatcher("index.jsp");
		rd.forward(req, res);
    }
}
