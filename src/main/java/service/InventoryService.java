package service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import model.Item;
import model.Make;
import model.Year;
import util.DBConnectionUtil;

//this class contains backend functions used for crud operations on the inventory
//function names are self explanatory
public class InventoryService implements InventoryInterface{
	private Connection conn = null;
	private Statement st = null;
	private ResultSet rs = null;
	
	public ArrayList<Make> getAllMakes() {
		ArrayList<Make> makeList = new ArrayList<>();
		
		try {
			conn = DBConnectionUtil.getConnection();
			System.out.println("connected to db");
			
			st = conn.createStatement();
			String sql = "select * from Make";
			rs = st.executeQuery(sql);
			
			while(rs.next()) {
				Make make = new Make(rs.getInt("makeId"), rs.getString("makeName"));
				makeList.add(make);
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				st.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			DBConnectionUtil.closeConnection(conn);
		}
		
		return makeList;
	}
	
	public ArrayList<Item> getAllItems() {
		ArrayList<Item> itemList = new ArrayList<>();
		
		try {
			conn = DBConnectionUtil.getConnection();
			System.out.println("connected to db");
			
			st = conn.createStatement();
			String sql = "select * from Item;";
			rs = st.executeQuery(sql);
			
			while(rs.next()) {
				int itemId = rs.getInt("itemId");
				ArrayList<Year> yearList = new ArrayList<>();
				Statement st2 = null;
				ResultSet rs2 = null;
				
				try {
					st2 = conn.createStatement();
					String sql2 = "call getItemInfo(" + itemId + ")";
					rs2 = st2.executeQuery(sql2);
					
					while(rs2.next()) {
						Year year = new Year(rs2.getInt("makeId"), rs2.getString("makeName"), rs2.getInt("modelId"), 
								rs2.getString("modelName"), rs2.getString("modelCategory"), rs2.getInt("yearId"), rs2.getInt("year"));
						yearList.add(year);
					}
					
					Item item = new Item(itemId, rs.getString("itemName"), rs.getString("itemBrand"), 
							rs.getString("itemCategory"), rs.getDouble("itemPrice"), rs.getInt("itemStocks"), yearList);
					
					itemList.add(item);
				}
				catch(SQLException e) {
					e.printStackTrace();
				}
				finally {
					try {
			            if (rs2 != null) rs2.close();
			            if (st2 != null) st2.close();
			        } catch (SQLException e) {
			            e.printStackTrace();
			        }
				}
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
	            if (rs != null) rs.close();
	            if (st != null) st.close();
	            DBConnectionUtil.closeConnection(conn);
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
		}
		
		return itemList;
	}
	
	public Item getItemById(int itemId) {
		Item item = new Item();
		
		try {
			conn = DBConnectionUtil.getConnection();
			System.out.println("connected to db");
			
			st = conn.createStatement();
			String sql = "select * from Item where itemId = " + itemId;
			rs = st.executeQuery(sql);
			
			ArrayList<Year> yearList = new ArrayList<>();
			Statement st2 = null;
			ResultSet rs2 = null;
			
			try {
				st2 = conn.createStatement();
				String sql2 = "call getItemInfo(" + itemId + ")";
				rs2 = st2.executeQuery(sql2);
				
				while(rs2.next()) {
					Year year = new Year(rs2.getInt("makeId"), rs2.getString("makeName"), rs2.getInt("modelId"), 
							rs2.getString("modelName"), rs2.getString("modelCategory"), rs2.getInt("yearId"), rs2.getInt("year"));
					yearList.add(year);
				}
				
				if(rs.next()) {
					item.setItemId(itemId);
					item.setItemName(rs.getString("itemName"));
					item.setItemBrand(rs.getString("itemBrand"));
					item.setItemCategory(rs.getString("itemCategory"));
					item.setItemPrice(rs.getDouble("itemPrice"));
					item.setItemStocks(rs.getInt("itemStocks"));
					item.setYearList(yearList);
				}
			}
			catch(SQLException e) {
				e.printStackTrace();
			}
			finally {
				try {
		            if (rs2 != null) rs2.close();
		            if (st2 != null) st2.close();
		        } catch (SQLException e) {
		            e.printStackTrace();
		        }
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				st.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			DBConnectionUtil.closeConnection(conn);
		}
		
		return item;
	}
	
	public void createItem(Item item, ArrayList<Integer> comp) {
		try {
			conn = DBConnectionUtil.getConnection();
			System.out.println("connected to db");
			
			st = conn.createStatement();
			String sql = String.format("insert into Item (itemId, itemName, itemBrand, itemCategory, itemPrice, itemStocks) values ('%d', '%s', '%s', '%s', %f, %d)"
					, item.getItemId(), item.getItemName(), item.getItemBrand(), item.getItemCategory(), item.getItemPrice(), item.getItemStocks());
			st.executeUpdate(sql);
			
			for(int i = 0; i < comp.size(); i++) {
				String sql2 = String.format("insert into Compatibility values (%d, %d)", item.getItemId(), comp.get(i));
				st.executeUpdate(sql2);
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				st.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			DBConnectionUtil.closeConnection(conn);
		}
	}
	
	public void updateItem(Item item) {
		try {
			conn = DBConnectionUtil.getConnection();
			System.out.println("connected to db");
			
			st = conn.createStatement();
			String sql = String.format("update Item set itemName = '%s', itemBrand = '%s', itemCategory = '%s', itemPrice = %f, itemStocks = %d where itemId = %d", 
					item.getItemName(), item.getItemBrand(), item.getItemCategory(), item.getItemPrice(), item.getItemStocks(), item.getItemId());
			st.executeUpdate(sql);
			System.out.println(item.getItemName());
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				st.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			DBConnectionUtil.closeConnection(conn);
		}
	}
	
	public void deleteItem(int itemId) {
		try {
			conn = DBConnectionUtil.getConnection();
			System.out.println("connected to db");
			
			st = conn.createStatement();
			String sql = "delete from Item where itemId = " + itemId;
			st.executeUpdate(sql);
			System.out.println("deleted item " + itemId);
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				st.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			DBConnectionUtil.closeConnection(conn);
		}
	}
	
	public ArrayList<Item> searchItems(String keyword, String make, String model, Integer year) {
	    ArrayList<Item> allItems = getAllItems();
	    ArrayList<Item> searchResults = new ArrayList<>();
	    
	    if (keyword == null || keyword.trim().isEmpty()) {
	        System.out.println("Search keyword is required");
	        return searchResults;
	    }
	    
	    keyword = keyword.toLowerCase();
	    
	    for (Item item : allItems) {
	        boolean matchesKeyword = item.getItemName().toLowerCase().contains(keyword) || 
	                                item.getItemBrand().toLowerCase().contains(keyword) || 
	                                item.getItemCategory().toLowerCase().contains(keyword);
	        
	        if (!matchesKeyword) {
	            continue;
	        }
	        
	        if (make == null && model == null && year == null) {
	            searchResults.add(item);
	            continue;
	        }
	        
	        boolean matchesVehicleSpecs = false;
	        
	        for (Year yearObj : item.getYearList()) {
	            boolean makeMatches = make == null || yearObj.getMakeName().equalsIgnoreCase(make);
	            boolean modelMatches = model == null || yearObj.getModelName().equalsIgnoreCase(model);
	            boolean yearMatches = year == null || yearObj.getYear() == year;
	            
	            if (makeMatches && modelMatches && yearMatches) {
	                matchesVehicleSpecs = true;
	                break;
	            }
	        }
	        
	        if (matchesVehicleSpecs) {
	            searchResults.add(item);
	        }
	    }
	    
	    return searchResults;
	}
	
	public ArrayList<Item> searchItems(String keyword, Integer makeId, Integer modelId, Integer yearId) {
	    ArrayList<Item> allItems = getAllItems();
	    ArrayList<Item> searchResults = new ArrayList<>();
	    
	    if (keyword == null || keyword.trim().isEmpty()) {
	        System.out.println("Search keyword is required");
	        return searchResults;
	    }
	    
	    keyword = keyword.toLowerCase();
	    
	    for (Item item : allItems) {
	        boolean matchesKeyword = item.getItemName().toLowerCase().contains(keyword) || 
	                                 item.getItemBrand().toLowerCase().contains(keyword) || 
	                                 item.getItemCategory().toLowerCase().contains(keyword);
	        
	        if (!matchesKeyword) {
	            continue;
	        }
	        
	        // If no filter is applied
	        if (makeId == null && modelId == null && yearId == null) {
	            searchResults.add(item);
	            continue;
	        }
	        
	        boolean matchesVehicleSpecs = false;
	        
	        for (Year yearObj : item.getYearList()) {
	        	boolean makeMatches = (makeId == null || yearObj.getMakeId() == makeId);
	        	boolean modelMatches = (modelId == null || yearObj.getModelId() == modelId);
	        	boolean yearMatches = (yearId == null || yearObj.getYearId() == yearId);
	            
	            if (makeMatches && modelMatches && yearMatches) {
	                matchesVehicleSpecs = true;
	                break;
	            }
	        }
	        
	        if (matchesVehicleSpecs) {
	            searchResults.add(item);
	        }
	    }
	    
	    return searchResults;
	}
}
