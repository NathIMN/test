package model;

public class SupplierModel extends User{
	
	private int supplierID;
	private String name;
	private String companyName;
	
	public SupplierModel() {
		super();
	}

	public SupplierModel(String email, String password, int supplierID, String name, String companyName) {
		super(email, password);
		this.supplierID = supplierID;
		this.name = name;
		this.companyName = companyName;
	}

	public int getSupplierID() {
		return supplierID;
	}

	public void setSupplierID(int supplierID) {
		this.supplierID = supplierID;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	
}
