package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Cart;
import model.Item;
import util.DBConnectionUtil;
//edited
public class CartCtrl {

	public CartCtrl() {
		// TODO Auto-generated constructor stub
	}

    private InventoryService inventory = new InventoryService();

    public String addToCart(int cusId, int itemId, int itemQty) {
        try (Connection conn = DBConnectionUtil.getConnection()) {
        	System.out.println("im 1");
            // Check stock
            Item item = null;
			item = inventory.getItemById(itemId);
            if (item == null) return "Item not found";
            System.out.println("itemQty = " + itemQty + "stocks" + item.getItemStocks());
            if (itemQty > item.getItemStocks()) return "Insufficient stock";
            System.out.println("im 2");
            
            // Check if item already in cart
            String checkSql = "SELECT quantity FROM cart WHERE cusId = ? AND itemId = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, String.valueOf(cusId));
            checkStmt.setString(2, String.valueOf(itemId));
            ResultSet rs = checkStmt.executeQuery();
            System.out.println("im 3");
            if (rs.next()) {
                // Update existing item
            	System.out.println("im 4");
                int existingQty = rs.getInt("quantity");
                int newQty = existingQty + itemQty;
                if (newQty > item.getItemStocks()) return "Exceeds stock";

                String updateSql = "UPDATE cart SET quantity = ?, addedAt = CURRENT_DATE WHERE cusId = ? AND itemId = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateSql);
                updateStmt.setInt(1, newQty);
                updateStmt.setInt(2, cusId);
                updateStmt.setInt(3, itemId);
                updateStmt.executeUpdate();
                System.out.println("im 5");
            } else {
            	System.out.println("im 6");
                // Insert new item
                String insertSql = "INSERT INTO cart (cusId, itemId, quantity, addedAt) VALUES (?, ?, ?, CURRENT_DATE)";
                PreparedStatement insertStmt = conn.prepareStatement(insertSql);
                insertStmt.setString(1, String.valueOf(cusId));
                insertStmt.setString(2, String.valueOf(itemId));
                insertStmt.setInt(3, itemQty);
                insertStmt.executeUpdate();
            }

            return "Success";

        } catch (Exception e) {
            e.printStackTrace();
            return "Error occurred";
        }
    }

    public String updateItemToCart(int cusId, int itemId, int newQty) {
        try (Connection conn = DBConnectionUtil.getConnection()) {
            Item item = inventory.getItemById(itemId);
            if (item == null) return "Item not found";
            if (newQty > item.getItemStocks()) return "Insufficient stock";

            String sql = "UPDATE cart SET quantity = ?, addedAt = CURRENT_DATE WHERE cusId = ? AND itemId = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, newQty);
            stmt.setInt(2, cusId);
            stmt.setInt(3, itemId);
            int rows = stmt.executeUpdate();
            
            String message = null;
            if(rows > 0) {
            	message = "Updated quantity to " + newQty;
            }else {
            	message = "Item not found in cart";
            }
            return  message;

        } catch (Exception e) {
            e.printStackTrace();
            return "Error";
        }
    }
    
//edited here
    public List<Cart> getAllCartItems(int cusId) {
        List<Cart> cartList = new ArrayList<>();

        try (Connection conn = DBConnectionUtil.getConnection()) {
            String sql = "SELECT * FROM cart WHERE cusId = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, cusId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Cart c = new Cart(
                    rs.getInt("cusId"),
                    rs.getInt("itemId"),
                    rs.getInt("quantity"),
                    rs.getDate("addedAt")
                );
                cartList.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return cartList;
    }
    
//    public double getTotal(int itemId, int cusId) {
//    	double total = 0;
//    	double price = 0;
//    	InventoryService inventory = new InventoryService();
//    	Item item = inventory.get
//    }
    
    public int getCartCount(int cusId) {
        int totalQty = 0;

        try (Connection conn = DBConnectionUtil.getConnection()) {
            String sql = "SELECT SUM(quantity) FROM cart WHERE cusId = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, cusId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                totalQty = rs.getInt(1);
                System.out.println("totalQty" + totalQty);// SUM result
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return totalQty;
    }

    public String removeItemFromCart(int cusId, int itemId) {
        try (Connection conn = DBConnectionUtil.getConnection()) {
            String sql = "DELETE FROM cart WHERE cusId = ? AND itemId = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, cusId);
            stmt.setInt(2, itemId);
            int rows = stmt.executeUpdate();

            return rows > 0 ? "Removed" : "Item not found";

        } catch (Exception e) {
            e.printStackTrace();
            return "Error";
        }
    }
    
    public String clearCart(int cusId) {
        try (Connection conn = DBConnectionUtil.getConnection()) {
            String sql = "DELETE FROM cart WHERE cusId = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, cusId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0 ? "Success" : "No items found";
        } catch (Exception e) {
            e.printStackTrace();
            return "Error";
        }
    }

	

	
}
