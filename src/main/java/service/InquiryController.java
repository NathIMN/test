package service;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.InquiryModel;
import util.DBConnectionUtil;

public class InquiryController {

    // Insert data
    public static boolean insertdata(int cusId, String vehicleMake, String vehicleModel, int yearOfManufacture,
                                     String partName, Timestamp inquiryDate, String description, int quantityRequired,
                                     String urgencyLevel, String inquiryType, String status,
                                     String response, Integer supportAgentId) {

        boolean isSuccess = false;
        String sql = "INSERT INTO sparepartinquiry (cusId, vehicleMake, vehicleModel, yearOfManufacture, partName, inquiryDate, description, quantityRequired, urgencyLevel, inquiryType, status, response, supporterId) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnectionUtil.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, cusId);
            pstmt.setString(2, vehicleMake);
            pstmt.setString(3, vehicleModel);
            pstmt.setInt(4, yearOfManufacture);
            pstmt.setString(5, partName);
            pstmt.setTimestamp(6, inquiryDate);
            pstmt.setString(7, description);
            pstmt.setInt(8, quantityRequired);
            pstmt.setString(9, urgencyLevel);
            pstmt.setString(10, inquiryType);
            pstmt.setString(11, status);
            pstmt.setString(12, response);
            if (supportAgentId != null) {
                pstmt.setInt(13, supportAgentId);
            } else {
                pstmt.setNull(13, Types.INTEGER);
            }

            isSuccess = pstmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return isSuccess;
    }

    // Get inquiry by ID
    public static List<InquiryModel> getById(String id) {
        List<InquiryModel> inquiries = new ArrayList<>();
        String sql = "SELECT * FROM sparepartinquiry WHERE inquiryId = ?";

        try (Connection con = DBConnectionUtil.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, Integer.parseInt(id));
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                InquiryModel iq = extractInquiryFromResultSet(rs);
                inquiries.add(iq);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return inquiries;
    }

    // Get all inquiries
    public static List<InquiryModel> getAllInquiry() {
        List<InquiryModel> inquiries = new ArrayList<>();
        String sql = "SELECT * FROM sparepartinquiry";

        try (Connection con = DBConnectionUtil.getConnection();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                InquiryModel iq = extractInquiryFromResultSet(rs);
                inquiries.add(iq);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return inquiries;
    }

    // Old full update method (not used in role-based access anymore)
    public static boolean updatedata(int inquiryId, int cusId, String vehicleMake, String vehicleModel,
                                     int yearOfManufacture, String partName, Timestamp inquiryDate, String description,
                                     int quantityRequired, String urgencyLevel, String inquiryType, String status,
                                     String response, Integer supportAgentId) {

        boolean isSuccess = false;
        String sql = "UPDATE sparepartinquiry SET cusId=?, vehicleMake=?, vehicleModel=?, yearOfManufacture=?, partName=?, inquiryDate=?, description=?, quantityRequired=?, urgencyLevel=?, inquiryType=?, status=?, response=?, supporterId=? WHERE inquiryId=?";

        try (Connection con = DBConnectionUtil.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, cusId);
            pstmt.setString(2, vehicleMake);
            pstmt.setString(3, vehicleModel);
            pstmt.setInt(4, yearOfManufacture);
            pstmt.setString(5, partName);
            pstmt.setTimestamp(6, inquiryDate);
            pstmt.setString(7, description);
            pstmt.setInt(8, quantityRequired);
            pstmt.setString(9, urgencyLevel);
            pstmt.setString(10, inquiryType);
            pstmt.setString(11, status);
            pstmt.setString(12, response);
            if (supportAgentId != null) {
                pstmt.setInt(13, supportAgentId);
            } else {
                pstmt.setNull(13, Types.INTEGER);
            }
            pstmt.setInt(14, inquiryId);

            isSuccess = pstmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return isSuccess;
    }

    // Delete inquiry
    public static boolean deletedata(String id) {
        boolean isSuccess = false;
        String sql = "DELETE FROM sparepartinquiry WHERE inquiryId = ?";

        try (Connection con = DBConnectionUtil.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, Integer.parseInt(id));
            isSuccess = pstmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return isSuccess;
    }

    // Extract data from ResultSet to model
    private static InquiryModel extractInquiryFromResultSet(ResultSet rs) throws SQLException {
        int inquiryId = rs.getInt("inquiryId");
        int cusId = rs.getInt("cusId");
        String vehicleMake = rs.getString("vehicleMake");
        String vehicleModel = rs.getString("vehicleModel");
        int yearOfManufacture = rs.getInt("yearOfManufacture");
        String partName = rs.getString("partName");
        Timestamp inquiryDate = rs.getTimestamp("inquiryDate");
        String description = rs.getString("description");
        int quantityRequired = rs.getInt("quantityRequired");
        String urgencyLevel = rs.getString("urgencyLevel");
        String inquiryType = rs.getString("inquiryType");
        String status = rs.getString("status");
        String response = rs.getString("response");
        Integer supportAgentId = rs.getInt("supporterId");

        return new InquiryModel(inquiryId, cusId, vehicleMake, vehicleModel, yearOfManufacture,
                partName, inquiryDate, description, quantityRequired, urgencyLevel,
                inquiryType, status, response, supportAgentId);
    }

    public static List<InquiryModel> getInquiriesByCustomerId(Integer cusId) {
        List<InquiryModel> inquiries = new ArrayList<>();
        String sql = "SELECT * FROM sparepartinquiry WHERE cusId = ?";

        try (Connection con = DBConnectionUtil.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, cusId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                InquiryModel iq = extractInquiryFromResultSet(rs);
                inquiries.add(iq);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return inquiries;
    }

    // Update by Customer
    public static boolean updateCustomerInquiry(int inquiryId, int cusId, String vehicleMake, String vehicleModel,
                                                int yearOfManufacture, String partName, Timestamp inquiryDate, String description,
                                                int quantityRequired, String urgencyLevel, String inquiryType) {

        boolean isSuccess = false;
        String sql = "UPDATE sparepartinquiry SET cusId=?, vehicleMake=?, vehicleModel=?, yearOfManufacture=?, partName=?, inquiryDate=?, description=?, quantityRequired=?, urgencyLevel=?, inquiryType=? WHERE inquiryId=?";

        try (Connection con = DBConnectionUtil.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, cusId);
            pstmt.setString(2, vehicleMake);
            pstmt.setString(3, vehicleModel);
            pstmt.setInt(4, yearOfManufacture);
            pstmt.setString(5, partName);
            pstmt.setTimestamp(6, inquiryDate);
            pstmt.setString(7, description);
            pstmt.setInt(8, quantityRequired);
            pstmt.setString(9, urgencyLevel);
            pstmt.setString(10, inquiryType);
            pstmt.setInt(11, inquiryId);

            isSuccess = pstmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return isSuccess;
    }

    //  Update by Supporter
    public static boolean updateSupporterResponse(int inquiryId, String status, String response) {
        boolean isSuccess = false;
        String sql = "UPDATE sparepartinquiry SET status=?, response=? WHERE inquiryId=?";

        try (Connection con = DBConnectionUtil.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setString(1, status);
            pstmt.setString(2, response);
            pstmt.setInt(3, inquiryId);

            isSuccess = pstmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return isSuccess;
    }

	public static boolean updateStatusAndResponse(int inquiryId, String status, String response) {
		
		boolean isSuccess = false;

        try {
            Connection conn = DBConnectionUtil.getConnection();
            String sql = "UPDATE sparepartinquiry SET status = ?, response = ? WHERE inquiryId = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, status);
            stmt.setString(2, response);
            stmt.setInt(3, inquiryId);

            int rows = stmt.executeUpdate();
            isSuccess = (rows > 0);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return isSuccess;
    }
		
}
