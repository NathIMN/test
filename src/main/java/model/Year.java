package model;

//class to store vehicle Year details, a year always belongs to a model
public class Year extends Model {
	private int yearId;
	private int year;
	public Year() {}
	public Year(int makeId, String makeName, int modelId, String modelName, String modelCategory, int yearId, int year) {
		super(makeId, makeName, modelId, modelName, modelCategory);
		this.yearId = yearId;
		this.year = year;
	}
	public int getYearId() {
		return yearId;
	}
	public void setYearId(int yearId) {
		this.yearId = yearId;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	};
}
