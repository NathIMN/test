package service;

import java.util.ArrayList;

import model.Item;
import model.Make;

public interface InventoryInterface {
	public ArrayList<Make> getAllMakes();
	public ArrayList<Item> getAllItems();
	public Item getItemById(int itemId);
	public void createItem(Item item, ArrayList<Integer> comp);
	public void updateItem(Item item);
	public void deleteItem(int itemId);
}
