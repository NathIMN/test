package model;

public class Agent extends User{
	private int supporterId;
	private String supporterName;
	
	public Agent() {
		super();
	}
	
	public Agent(String email, String password, int supporterId, String supporterName) {
		super(email, password);
		this.supporterId = supporterId;
		this.supporterName = supporterName;
	}
	
	public int getSupporterId() {
		return supporterId;
	}

	public void setSupporterId(int supporterId) {
		this.supporterId = supporterId;
	}

	public String getSupporterName() {
		return supporterName;
	}

	public void setSupporterName(String supporterName) {
		this.supporterName = supporterName;
	}
}
