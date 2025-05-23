package model;

import java.sql.Date;
import java.time.LocalDate;
import java.time.Period;
//edited this whole class.
public class Cart {

	public int cusId;

	public int itemId;

	public int quantity;
	
	private Date addedAt;
	
	public Cart() {
		// TODO Auto-generated constructor stub
	}

	public Cart(int cusId, int itemId, int quantity, Date addedAt) {
		super();
		this.cusId = cusId;
		this.itemId = itemId;
		this.quantity = quantity;
		this.addedAt = addedAt;
	}
	
	public String calcDatediff() {
		LocalDate addedDate = addedAt.toLocalDate();
	    LocalDate currentDate = LocalDate.now();
		
		System.out.println("Current Date: " + currentDate);
		System.out.println("addedDate Date: " + addedDate);
		
		Period period = Period.between(addedDate, currentDate);
        int daysDiff = Math.abs(period.getDays());
        
        System.out.println("Difference in days: " + daysDiff);
        System.out.println("period Date: " + period);
        
        String message = null;
        
        if(daysDiff == 0) {
        	message = "Today";
        }
        else if(daysDiff == 1) {
        	message = "1 day ago";
        }
        else if(daysDiff > 1) {
        	message = daysDiff + " days ago";
        }
		return message;
	}
	
	

	public int getCusId() {
		return cusId;
	}

	public void setCusId(int cusId) {
		this.cusId = cusId;
	}

	public int getItemId() {
		return itemId;
	}

	public void setItemId(int itemId) {
		this.itemId = itemId;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public Date getAddedAt() {
		return addedAt;
	}

	public void setAddedAt(Date addedAt) {
		this.addedAt = addedAt;
	}
	
	
	
	
	
	

}
