package com.sns.dto;

public class StartProfileDTO {
	int profileID;
	String nickname;
	String profileImg;
	String backImg;
	String stateMsg;
	int memberID;
	
	public StartProfileDTO() {}
	public StartProfileDTO(int profileID, String nickname, String profileImg, String backImg, String stateMsg,int memberID) {
		this.profileID = profileID;
		this.nickname = nickname;
		this.profileImg = profileImg;
		this.backImg = backImg;
		this.stateMsg = stateMsg;
		this.memberID = memberID;
	}
	public int getProfileID() {
		return profileID;
	}
	public void setProfileID(int profileID) {
		this.profileID = profileID;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getProfileImg() {
		return profileImg;
	}
	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}
	public String getBackImg() {
		return backImg;
	}
	public void setBackImg(String backImg) {
		this.backImg = backImg;
	}
	public String getStateMsg() {
		return stateMsg;
	}
	public void setStateMsg(String stateMsg) {
		this.stateMsg = stateMsg;
	}
	public int getMemberID() {
		return memberID;
	}
	public void setMemberID(int memberID) {
		this.memberID = memberID;
	}
	
	
}
