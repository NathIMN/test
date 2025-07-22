package model;

//class to store Make details
public class Make {
	private int makeId;
	private String makeName;
	public Make() {}
	public Make(int makeId, String makeName) {
		super();
		this.makeId = makeId;
		this.makeName = makeName;
	}
	public int getMakeId() {
		return makeId;
	}
	public void setMakeId(int makeId) {
		this.makeId = makeId;
	}
	public String getMakeName() {
		return makeName;
	}
	public void setMakeName(String makeName) {
		this.makeName = makeName;
	}
}
