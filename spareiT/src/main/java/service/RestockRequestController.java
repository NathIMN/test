package service;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import model.RestockRequestModel;
import util.DBConnectionUtil;

public class RestockRequestController {
	//Connect DB
		private static boolean isSuccess;
		private static Connection con = null;
		private static Statement stmt = null;
		private static ResultSet rs = null;
		
		//insert Data Function
		public static boolean insertdata(int itemID, int supplierID, int quantity, Date requestDate, String status) {
			
			boolean isSuccess = false;
			try {
				//DB Connection Call
				con=DBConnectionUtil.getConnection();
				stmt=con.createStatement();
				
				//SQL Query
				String sql = "insert into restock_request values (0, '"+itemID+"', '"+supplierID+"', '"+quantity+"', '"+requestDate+"', '"+status+"')";
				int rs = stmt.executeUpdate(sql);
				if(rs>0) {
					isSuccess = true;
				}
				else {
					isSuccess = false;
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return isSuccess;
		}
		
		  // Update Data Function
	    public static boolean updatedata(int requestID, int itemID, int quantity, Date requestDate, String status) {

	        boolean isSuccess = false;
	        try {
	            con = DBConnectionUtil.getConnection();
	            stmt = con.createStatement();

	            String sql = "UPDATE restock_request SET itemID='" + itemID + "', quantity='" + quantity + "', requestDate='" + requestDate + "', status='" + status + "' WHERE requestID='" + requestID + "'";
	            int rs = stmt.executeUpdate(sql);
	            System.out.println("works");
	            if (rs > 0) {
	                isSuccess = true;
	            } else {
	                isSuccess = false;
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return isSuccess;
	    }
		
	    public static ArrayList<RestockRequestModel> getdata(int id) {
	    	ArrayList<RestockRequestModel> requests = new ArrayList<>();
	    	
	    	try {
	            con = DBConnectionUtil.getConnection();
	            stmt = con.createStatement();

	            String sql = "select * from restock_request rr, item i where rr.supplierID = " + id + " and i.itemId = rr.itemID";
	            ResultSet rs = stmt.executeQuery(sql);

	            while(rs.next()) {
	            	RestockRequestModel request = new RestockRequestModel();
	            	request.setRequestID(rs.getInt("requestID"));
	            	request.setItemID(rs.getInt("itemID"));
	            	request.setItemName(rs.getString("itemName"));
	            	request.setSupplierID(rs.getInt("supplierID"));
	            	request.setQuantity(rs.getInt("quantity"));
	            	request.setRequestDate(rs.getDate("requestDate"));
	            	request.setStatus(rs.getString("status"));
	            	requests.add(request);
	            }
	        } 
	    	catch (Exception e) {
	            e.printStackTrace();
	        }
	    	
	    	return requests;
	    }
	    
	    public static void deletedata(int id) {
	    	try {
	            con = DBConnectionUtil.getConnection();
	            stmt = con.createStatement();

	            String sql = "delete from restock_request where requestID = " + id;
	            stmt.executeUpdate(sql);
	        } 
	    	catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
}
