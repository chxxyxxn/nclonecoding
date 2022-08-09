package com.sns.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.sns.dto.MessageDTO;

public class MessageDAO {
	
	//마지막 메세지 보기
	public ArrayList<MessageDTO> showLastMsg(int chatListID) throws Exception {
		
		ArrayList<MessageDTO> mList = new ArrayList<MessageDTO>();
		Connection conn = DBConnection.getConnection();
		String sql ="select *from DM  where dm_id in(select Max(dm_id) from dm group by chat_list_id) and chat_list_id=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, chatListID);
		ResultSet rs = pstmt.executeQuery();

		if(rs.next()) {
			int dmID = rs.getInt("dm_id");
			int chatListId =rs.getInt("chat_list_id");
			int fromUser= rs.getInt("from_user");
			int toUser = rs.getInt("to_user");
			String writeTime = rs.getString("write_time");
			String readTime = rs.getString("read_time");
			String content = rs.getString("content");
			String ImgFileName = rs.getString("img_file_name");
			
			MessageDTO mDto= new MessageDTO(dmID, chatListId,fromUser,toUser,writeTime,readTime,content, ImgFileName);
			mList.add(mDto);
		}
		return mList;
	}

	// 대화방 내용
	public ArrayList<MessageDTO> viewMsg(int chatListID) throws Exception{
		
		ArrayList<MessageDTO> mList = new ArrayList<MessageDTO>();
		Connection conn = DBConnection.getConnection();
		String sql ="select nickname, to_char(write_time,'mm.dd HH24:MI') as writetime, content "
				+ "from profile p, dm d " + "where d.from_user = p.profile_id " + "and chat_list_id =? "
				+ "union "
				+ "SELECT nickname, to_char(write_time,'mm.dd HH24:MI') as writetime, content " + "from DM, profile p "
				+ "where p.profile_id = dm.from_user " + "and chat_list_id =? " 
				+ "order by writetime";

		PreparedStatement pstmt = conn.prepareStatement(sql);

		pstmt.setInt(1, chatListID);
		pstmt.setInt(2, chatListID);
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {

			int dmID = rs.getInt("dm_id");
			int chatListId =rs.getInt("chat_list_id");
			int fromUser= rs.getInt("from_user");
			int toUser = rs.getInt("to_user");
			String writeTime = rs.getString("write_time");
			String readTime = rs.getString("read_time");
			String content = rs.getString("content");
			String ImgFileName = rs.getString("img_file_name");
			
			MessageDTO mDto= new MessageDTO(dmID, chatListId,fromUser,toUser,writeTime,readTime,content, ImgFileName);
			mList.add(mDto);
		}
		return mList;
	}
	
	//새로운 대화방 생성
	public int createChatList(int loginID, int userID) throws Exception {
		
		int result =0;
		Connection conn = DBConnection.getConnection();
		String sql = "insert into chat_list values (seq_chat_list.nextval,to_char(sysdate,'mm.dd HH24:MI'), ?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);

		pstmt.setString(1, loginID + "," + userID);
		result = pstmt.executeUpdate();
		return result;
		
	}
	
	
	// 대화 insert
	public int insertMsg(int chatList, int loginID, int userID, String content, String img) throws Exception {
		
		int result =0;
		Connection conn = DBConnection.getConnection();
		String sql = "insert into DM (DM_id, chat_list_id, from_user, to_user, write_time, read_time, content, img_file_name) values "
				+ "(seq_dm.nextval,?,?,?,sysdate, null, ? , ?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);

		pstmt.setInt(1, chatList);
		pstmt.setInt(2, loginID);
		pstmt.setInt(3, userID);
		pstmt.setString(4, content);
		pstmt.setString(5, img);

		result = pstmt.executeUpdate();
		return result;
		
	}
	
}
