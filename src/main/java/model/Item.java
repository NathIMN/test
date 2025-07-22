package model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashSet;

//class to store Item details
public class Item {
	private int itemId;
	private String itemName;
	private String itemBrand;
	private String itemCategory;
	private double itemPrice;
	private int itemStocks;
	private ArrayList<Year> yearList;
	//data structure to store vehicle years corresponding to their models and models corresponding to their makes
	private HashMap<String, ArrayList<HashMap<String, LinkedHashSet<Integer>>>> index;
	
	{index = new HashMap<>();}
	
	public Item() {}
	
	public Item(int itemId, String itemName, String itemBrand, String itemCategory, double itemPrice, int itemStocks) {
		super();
		this.itemId = itemId;
		this.itemName = itemName;
		this.itemBrand = itemBrand;
		this.itemCategory = itemCategory;
		this.itemPrice = itemPrice;
		this.itemStocks = itemStocks;
	}
	
	//this constructor creates the index using the information passed as a list of Year objects
	//Year is a child class of Model which is a child class of Make, 
	//a Year object contains information obtained by joining multiple tables in the database
	public Item(int itemId, String itemName, String itemBrand, String itemCategory, double itemPrice, int itemStocks,
			ArrayList<Year> yearList) {
		super();
		this.itemId = itemId;
		this.itemName = itemName;
		this.itemBrand = itemBrand;
		this.itemCategory = itemCategory;
		this.itemPrice = itemPrice;
		this.itemStocks = itemStocks;
		this.yearList = yearList;
		
		for(Year year : yearList) {
			String make = year.getMakeName();
			String model = year.getModelName();
			int yearNo = year.getYear();
			
			if(!index.containsKey(make)) {
				index.put(make, new ArrayList<HashMap<String, LinkedHashSet<Integer>>>());
			}
			
			ArrayList<HashMap<String, LinkedHashSet<Integer>>> modelList = index.get(make);
		    boolean x = false;
		    
		    for (HashMap<String, LinkedHashSet<Integer>> modelMap : modelList) {
		        if (modelMap.containsKey(model)) {
		            modelMap.get(model).add(yearNo);
		            x = true;
		            break;
		        }
		    }
		    
		    if (!x) {
		        LinkedHashSet<Integer> years = new LinkedHashSet<>();
		        years.add(yearNo);
		        HashMap<String, LinkedHashSet<Integer>> modelMap = new HashMap<>();
		        modelMap.put(model, years);
		        modelList.add(modelMap);
		    }
		}
	}
	
	public int getItemId() {
		return itemId;
	}
	public void setItemId(int itemId) {
		this.itemId = itemId;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public String getItemBrand() {
		return itemBrand;
	}
	public void setItemBrand(String itemBrand) {
		this.itemBrand = itemBrand;
	}
	public String getItemCategory() {
		return itemCategory;
	}
	public void setItemCategory(String itemCategory) {
		this.itemCategory = itemCategory;
	}
	public double getItemPrice() {
		return itemPrice;
	}
	public void setItemPrice(double itemPrice) {
		this.itemPrice = itemPrice;
	}
	public int getItemStocks() {
		return itemStocks;
	}
	public void setItemStocks(int itemStocks) {
		this.itemStocks = itemStocks;
	}
	public ArrayList<Year> getYearList() {
		return yearList;
	}
	
	//this setter creates the index too, using the ArrayList of Years passed
	public void setYearList(ArrayList<Year> yearList) {
		this.yearList = yearList;
		
		for(Year year : yearList) {
			String make = year.getMakeName();
			String model = year.getModelName();
			int yearNo = year.getYear();
			
			if(!index.containsKey(make)) {
				index.put(make, new ArrayList<HashMap<String, LinkedHashSet<Integer>>>());
			}
			
			ArrayList<HashMap<String, LinkedHashSet<Integer>>> modelList = index.get(make);
		    boolean x = false;
		    
		    for (HashMap<String, LinkedHashSet<Integer>> modelMap : modelList) {
		        if (modelMap.containsKey(model)) {
		            modelMap.get(model).add(yearNo);
		            x = true;
		            break;
		        }
		    }
		    
		    if (!x) {
		        LinkedHashSet<Integer> years = new LinkedHashSet<>();
		        years.add(yearNo);
		        HashMap<String, LinkedHashSet<Integer>> modelMap = new HashMap<>();
		        modelMap.put(model, years);
		        modelList.add(modelMap);
		    }
		}
	}
	public HashMap<String, ArrayList<HashMap<String, LinkedHashSet<Integer>>>> getIndex() {
		return index;
	}
}
