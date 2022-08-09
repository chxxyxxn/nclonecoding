package com.sns.dto;

public class ProfileDTO {
	
	String nickname;
	String profileImg;
	String backImg;
	String stateMsg;
	
	public ProfileDTO() {}
	public ProfileDTO( String nickname, String profileImg, String backImg, String stateMsg) {
	
		this.nickname = nickname;
		this.profileImg = profileImg;
		this.backImg = backImg;
		this.stateMsg = stateMsg;
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
	
	
	
}
