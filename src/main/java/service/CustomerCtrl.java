package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import model.Customer;
import model.Item;
import model.User;
import util.DBConnectionUtil;

public class CustomerCtrl extends UserCtrl{

	private static boolean isSuccess;
	private static Connection conn = null;
	private static Statement stmt = null;
	private static ResultSet rs = null;
	
	@Override
	public Customer loginValidate(String un, String pw) {
		// TODO Auto-generated method stub
		Customer customer = null;
		System.out.println("im here");
	    try (Connection conn = DBConnectionUtil.getConnection()) {
	        String sql = "SELECT * FROM customer WHERE email = ? AND password = ?";
	        PreparedStatement stmt = conn.prepareStatement(sql);
	        stmt.setString(1, un);
	        stmt.setString(2, pw);

	        ResultSet rs = stmt.executeQuery();
	        System.out.println("im there" + rs);
	        if (rs.next()) {
	            customer = new Customer();
	            customer.setCusId(rs.getInt("cusId"));
	            customer.setFirstName(rs.getString("firstName"));
	            customer.setLastName(rs.getString("lastName"));
	            customer.setEmail(rs.getString("email"));
	            customer.setPhoneNo(rs.getString("phoneNo"));
	            customer.setPassword(rs.getString("password"));
	            customer.setNoOfOrders(rs.getInt("noOfOrders"));
	            System.out.println(customer);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return customer;
	}
	
	public static boolean registerCustomer(Customer cus) {
		boolean isSuccess = false;
		
		try (Connection conn = DBConnectionUtil.getConnection()) {
            String sql = "INSERT INTO customer (firstName, lastName, email, phoneNo, password, noOfOrders) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, cus.getFirstName());
            stmt.setString(2, cus.getLastName());
            stmt.setString(3, cus.getEmail());
            stmt.setString(4, cus.getPhoneNo());
            stmt.setString(5, cus.getPassword());
            stmt.setInt(6, 0);
            isSuccess = stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isSuccess;
		
	}
	
	public boolean isEmailRegistered(String email) {
        boolean exists = false;
        try (Connection conn = DBConnectionUtil.getConnection()) {
        	
            String sql = "SELECT email FROM customer WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            exists = rs.next();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return exists;
    }

	public Customer getCustomerById(int cusId) {
		
		Customer customer = new Customer();
		try {
			Connection conn = DBConnectionUtil.getConnection();
			String sql = "SELECT * FROM customer WHERE cusId = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cusId);
			ResultSet rs = stmt.executeQuery();
			
			if (rs.next()) {
	            customer = new Customer();
	            customer.setCusId(rs.getInt("cusId"));
	            customer.setFirstName(rs.getString("firstName"));
	            customer.setLastName(rs.getString("lastName"));
	            customer.setEmail(rs.getString("email"));
	            customer.setPhoneNo(rs.getString("phoneNo"));
	            customer.setPassword(rs.getString("password"));
	            customer.setNoOfOrders(rs.getInt("noOfOrders"));
	            System.out.println(customer);
	        }
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return customer;
	}
	
	public String updateCustomer(int cusId, String firstName, String lastName, String email, String phoneNo ) {
        try (Connection conn = DBConnectionUtil.getConnection()) {
            
            String sql = "UPDATE customer SET firstName = ?, lastName = ?, email = ?, phoneNo = ? WHERE cusId = ? ";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, firstName);
            stmt.setString(2, lastName);
            stmt.setString(3, email);
            stmt.setString(4, phoneNo);
            stmt.setInt(5, cusId);
            int rows = stmt.executeUpdate();
            
            String message = null;
            if(rows > 0) {
            	message = "Updated Customer data successfully";
            }else {
            	message = "Update Unsuccessful";
            }
            return  message;

        } catch (Exception e) {
            e.printStackTrace();
            return "Error";
        }
    }
	
	public boolean verifyCustomer(int cusId, String password) {
		boolean isTrue = false;
		try (Connection conn = DBConnectionUtil.getConnection()) {
            
            String sql = "SELECT password FROM customer WHERE cusId = ? ";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, cusId);
            
            ResultSet rs = stmt.executeQuery();
            String actualPassword = null;
            if (rs.next()) {
            	actualPassword = rs.getString("password");
            }
            
            
            if(actualPassword.equals(password) ) {
            	isTrue = true;
            }else {
            	isTrue = false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
		
		return isTrue;
	}
	
	public boolean deleteCustomer(int cusId) {
	    boolean isDeleted = false;

	    String sql = "DELETE FROM customer WHERE cusId = ?";

	    try (Connection conn = DBConnectionUtil.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {

	        stmt.setInt(1, cusId);
	        int rowsAffected = stmt.executeUpdate();

	        if (rowsAffected > 0) {
	            isDeleted = true;
	            System.out.println("Customer deleted successfully.");
	        } else {
	            System.out.println("Customer deletion failed or cusId not found.");
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return isDeleted;
	}

	
	//login validation
//	public Customer loginValidate(String un, String pw){
//		Customer customer = null;
//		System.out.println("im here");
//	    try (Connection conn = DBConnectionUtil.getConnection()) {
//	        String sql = "SELECT * FROM customer WHERE email = ? AND password = ?";
//	        PreparedStatement stmt = conn.prepareStatement(sql);
//	        stmt.setString(1, un);
//	        stmt.setString(2, pw);
//
//	        ResultSet rs = stmt.executeQuery();
//	        System.out.println("im there" + rs);
//	        if (rs.next()) {
//	            customer = new Customer();
//	            customer.setCusId(rs.getInt("cusId"));
//	            customer.setFirstName(rs.getString("firstName"));
//	            customer.setLastName(rs.getString("lastName"));
//	            customer.setEmail(rs.getString("email"));
//	            customer.setPhoneNo(rs.getString("phoneNo"));
//	            customer.setPassword(rs.getString("password"));
//	            System.out.println(customer);
//	        }
//
//	    } catch (Exception e) {
//	        e.printStackTrace();
//	    }
//
//	    return customer;
//	}
	
	
	
//	public static boolean registerCustomer (String firstName, String lastName, String email, String phoneNo, String password) {
//	boolean isSuccess = false;
//	
//	try {
//		//DB connection call
//		conn = DBConnectionUtil.getConnection();
//		stmt = conn.createStatement(); 
//		
//		String sql = "insert into customer values(0, '"+firstName+"', '"+lastName+"', '"+email+"', '"+phoneNo+"', '"+password+"')";
//		int rs = stmt.executeUpdate(sql);
//		
//		if(rs > 0) {
//			isSuccess = true;//1300 2150
//		}
//		else {
//			isSuccess = false;
//		}
//		
//	}catch(Exception e){
//		e.printStackTrace();
//	}
//	return isSuccess;
//}
	
	

}


