package model;
//edied
public class Customer extends User{

	private int cusId;
	private String firstName;
	private String lastName;
	private String phoneNo;
	private int noOfOrders;
	public Customer() {
		super();
	}
	
	public Customer(int cusId, String firstName, String lastName, String phoneNo, String email, String password, int noOfOrders) {
		super(email, password);
		this.cusId = cusId;
		this.firstName = firstName;
		this.lastName = lastName;
		this.phoneNo = phoneNo;
		this.noOfOrders = noOfOrders;
	}
	public int getCusId() {
		return cusId;
	}

	public int getNoOfOrders() {
		return noOfOrders;
	}

	public void setNoOfOrders(int noOfOrders) {
		this.noOfOrders = noOfOrders;
	}

	public void setCusId(int cusId) {
		this.cusId = cusId;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	@Override
	public String toString() {
		return "Customer [cusId=" + cusId + ", firstName=" + firstName + ", lastName=" + lastName + ", email=" + email
				+ ", phoneNo=" + phoneNo + ", password=" + password + "]";
	}

}
