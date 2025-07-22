package model;

//class Model details, a model always belongs to a make
public class Model extends Make {
	private int modelId;
	private String modelName;
	private String modelCategory;
	public Model() {}
	public Model(int makeId, String makeName, int modelId, String modelName, String modelCategory) {
		super(makeId, makeName);
		this.modelId = modelId;
		this.modelName = modelName;
		this.modelCategory = modelCategory;
	}
	public int getModelId() {
		return modelId;
	}
	public void setModelId(int modelId) {
		this.modelId = modelId;
	}
	public String getModelName() {
		return modelName;
	}
	public void setModelName(String modelName) {
		this.modelName = modelName;
	}
	public String getModelCategory() {
		return modelCategory;
	}
	public void setModelCategory(String modelCategory) {
		this.modelCategory = modelCategory;
	}
}
