package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import model.Agent;
import model.User;
import util.DBConnectionUtil;

public class AgentCtrl extends UserCtrl {

	private static boolean isSuccess;
	private static Connection conn = null;
	private static Statement stmt = null;
	private static ResultSet rs = null;
	
	public AgentCtrl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public User loginValidate(String un, String pw) {
		// TODO Auto-generated method stub
		Agent agent = null;
		System.out.println("im here");
	    try (Connection conn = DBConnectionUtil.getConnection()) {

	        String sql = "SELECT * FROM supporter WHERE email = ? AND password = ?";
	        PreparedStatement stmt = conn.prepareStatement(sql);
	        stmt.setString(1, un);
	        stmt.setString(2, pw);


	        ResultSet rs = stmt.executeQuery();
	        System.out.println("im there" + rs);
	        if (rs.next()) {
	        	agent = new Agent();
	            agent.setSupporterId(rs.getInt("supporterId"));
	            agent.setSupporterName(rs.getString("supporterName"));
	            agent.setEmail(rs.getString("email"));
	            agent.setPassword(rs.getString("password"));
	            System.out.println(agent);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return agent;
	}

}
