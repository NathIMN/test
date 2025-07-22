package model;

import java.sql.Timestamp;

public class InquiryModel {
    private int inquiryId;
    private int cusId;
    private String vehicleMake;
    private String vehicleModel;
    private int yearOfManufacture;
    private String partName;
    private Timestamp inquiryDate;
    private String description;
    private int quantityRequired;
    private String urgencyLevel;
    private String inquiryType;
    private String status;
    private String response;
    private Integer supportAgentId;

    public InquiryModel(int inquiryId, int cusId, String vehicleMake, String vehicleModel, int yearOfManufacture,
                        String partName, Timestamp inquiryDate2, String description, int quantityRequired,
                        String urgencyLevel, String inquiryType, String status, String response, Integer supportAgentId) {
        this.inquiryId = inquiryId;
        this.cusId = cusId;
        this.vehicleMake = vehicleMake;
        this.vehicleModel = vehicleModel;
        this.yearOfManufacture = yearOfManufacture;
        this.partName = partName;
        this.inquiryDate = inquiryDate2;
        this.description = description;
        this.quantityRequired = quantityRequired;
        this.urgencyLevel = urgencyLevel;
        this.inquiryType = inquiryType;
        this.status = status;
        this.response = response;
        this.supportAgentId = supportAgentId;
    }

    // Getters and Setters

    public int getInquiryId() {
        return inquiryId;
    }

    public void setInquiryId(int inquiryId) {
        this.inquiryId = inquiryId;
    }

    public int getCusId() {
        return cusId;
    }

    public void setCusId(int cusId) {
        this.cusId = cusId;
    }

    public String getVehicleMake() {
        return vehicleMake;
    }

    public void setVehicleMake(String vehicleMake) {
        this.vehicleMake = vehicleMake;
    }

    public String getVehicleModel() {
        return vehicleModel;
    }

    public void setVehicleModel(String vehicleModel) {
        this.vehicleModel = vehicleModel;
    }

    public int getYearOfManufacture() {
        return yearOfManufacture;
    }

    public void setYearOfManufacture(int yearOfManufacture) {
        this.yearOfManufacture = yearOfManufacture;
    }

    public String getPartName() {
        return partName;
    }

    public void setPartName(String partName) {
        this.partName = partName;
    }

    public Timestamp getInquiryDate() {
        return inquiryDate;
    }

    public void setInquiryDate(Timestamp inquiryDate) {
        this.inquiryDate = inquiryDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getQuantityRequired() {
        return quantityRequired;
    }

    public void setQuantityRequired(int quantityRequired) {
        this.quantityRequired = quantityRequired;
    }

    public String getUrgencyLevel() {
        return urgencyLevel;
    }

    public void setUrgencyLevel(String urgencyLevel) {
        this.urgencyLevel = urgencyLevel;
    }

    public String getInquiryType() {
        return inquiryType;
    }

    public void setInquiryType(String inquiryType) {
        this.inquiryType = inquiryType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getResponse() {
        return response;
    }

    public void setResponse(String response) {
        this.response = response;
    }

    public Integer getSupportAgentId() {
        return supportAgentId;
    }

    public void setSupportAgentId(Integer supportAgentId) {
        this.supportAgentId = supportAgentId;
    }
}
