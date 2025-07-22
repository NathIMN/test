package model;

import java.sql.Date;

public class RestockRequestModel {
	
	private int requestID;
	private int itemID;
	private String itemName;
	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	private int supplierID;
	private int quantity;
	private Date requestDate;
	private String status;
	
	public RestockRequestModel() {}
	
	public RestockRequestModel(int requestID, int itemID, int supplierID, int quantity, Date requestDate,
			String status) {
		super();
		this.requestID = requestID;
		this.itemID = itemID;
		this.supplierID = supplierID;
		this.quantity = quantity;
		this.requestDate = requestDate;
		this.status = status;
		
		
	}

	public int getRequestID() {
		return requestID;
	}

	public void setRequestID(int requestID) {
		this.requestID = requestID;
	}

	public int getItemID() {
		return itemID;
	}

	public void setItemID(int itemID) {
		this.itemID = itemID;
	}

	public int getSupplierID() {
		return supplierID;
	}

	public void setSupplierID(int supplierID) {
		this.supplierID = supplierID;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public Date getRequestDate() {
		return requestDate;
	}

	public void setRequestDate(Date requestDate) {
		this.requestDate = requestDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	
}
