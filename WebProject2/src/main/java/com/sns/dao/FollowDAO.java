package com.sns.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLIntegrityConstraintViolationException;

public class FollowDAO {

	int loginID =1;
	
	
	public int follow(int otherUser) throws Exception {
		int result =0;
		Connection conn = DBConnection.getConnection();
		try {
			
			String sql = "insert into follow (following, follower) values (?,?)";
			PreparedStatement pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, otherUser);
			pstmt.setInt(2, loginID);
			result =pstmt.executeUpdate();

			pstmt.close();
		
			//이미 해당데이터가 follow 테이블에 있다면
		} catch (SQLIntegrityConstraintViolationException e) {

			String sql = "delete from follow where following =? and follower= ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, otherUser);
			pstmt.setInt(2, loginID);
			result =pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	

}
