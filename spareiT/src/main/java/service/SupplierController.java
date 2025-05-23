package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.function.Supplier;

import model.SupplierModel;
import model.User;
import util.DBConnectionUtil;

public class SupplierController extends UserCtrl{

	public SupplierController() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public SupplierModel loginValidate(String un, String pw) {
		// TODO Auto-generated method stub
		SupplierModel supplier = null;
		System.out.println("im here");
	    try (Connection conn = DBConnectionUtil.getConnection()) {
	        String sql = "SELECT * FROM supplier WHERE email = ? AND password = ?";
	        PreparedStatement stmt = conn.prepareStatement(sql);
	        stmt.setString(1, un);
	        stmt.setString(2, pw);

	        ResultSet rs = stmt.executeQuery();
	        System.out.println("im there" + rs);
	        if (rs.next()) {
	        	supplier = new SupplierModel();
	        	supplier.setSupplierID(rs.getInt("supplierID"));
	        	supplier.setName(rs.getString("name"));
	        	supplier.setEmail(rs.getString("email"));
	        	supplier.setPassword(rs.getString("password"));
	        	supplier.setCompanyName(rs.getString("companyName"));
	            System.out.println(supplier);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return supplier;
	}

}
