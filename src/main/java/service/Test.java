package service;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import util.DBConnectionUtil;

public class Test {
	private static Connection conn = null;

	public static void main(String[] args) {
		conn = DBConnectionUtil.getConnection();
		System.out.println("connected to db");
		
		try {
			CallableStatement stmt = conn.prepareCall("{? = call getItemName(?)}");
			stmt.registerOutParameter(1, java.sql.Types.VARCHAR);
			stmt.setInt(2, 55);
			stmt.execute();
			String name = stmt.getString(1);
			System.out.println("item name: " + name);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
//		InventoryService inventoryService = new InventoryService();
//		
//		ArrayList<Item> results = new ArrayList<>();
//		
//		results = inventoryService.searchItems("b", 1, 1, 1);
//		
//		for(Item res : results) {
//			System.out.println(res.getItemName());
//		}
		
//		inventoryService.deleteItem(102);
		
//		Item item = inventoryService.getItemById(22);
//		
//		HashMap<String, ArrayList<HashMap<String, LinkedHashSet<Integer>>>> makeMap = item.getIndex();
//		
//		Set<Map.Entry<String, ArrayList<HashMap<String, LinkedHashSet<Integer>>>>> makeSet = makeMap.entrySet();
//		
//		for(Map.Entry<String, ArrayList<HashMap<String, LinkedHashSet<Integer>>>> makeEntry : makeSet) {
//			System.out.println(makeEntry.getKey());
//			
//			for(HashMap<String, LinkedHashSet<Integer>> modelMap : makeEntry.getValue()) {
//				Set<Map.Entry<String, LinkedHashSet<Integer>>> modelSet = modelMap.entrySet();
//				
//				for(Map.Entry<String, LinkedHashSet<Integer>> modelEntry : modelSet) {
//					System.out.print(modelEntry.getKey() + " - ");
//					
//					for(int year : modelEntry.getValue()) {
//						System.out.print(year + " ");
//					}
//					System.out.println();
//				}
//			}
//			System.out.println();
//		}
	}
}
