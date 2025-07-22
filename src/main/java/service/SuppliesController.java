package service;

import java.util.ArrayList;
import java.util.List;

import util.DBConnectionUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class SuppliesController {
    public List<String[]> getItemNames(int supId) {
        List<String[]> names = new ArrayList<>();
        

        String sql = "SELECT item.itemName, item.itemId " +
                     "FROM supplies " +
                     "JOIN item ON supplies.itemID = item.itemId " +
                     "WHERE supplies.supplierID = ?";

        try (
            Connection con = DBConnectionUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, supId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
            	String[] x = new String[2];
                x[0] = (rs.getString("itemId"));
                x[1] = (rs.getString("itemName"));
                names.add(x);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return names;
    }
}

