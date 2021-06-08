package com.project.test;

import org.springframework.stereotype.Component;

@Component("userVO")
public class UserVO {
	int userNum;
	String id, password, email, name, telephone, profileImage;
	
	public UserVO() {
	}
	public UserVO(int userNum, String id, String password, String email, String name, String telephone,
			String profileImage) {
		super();
		this.userNum = userNum;
		this.id = id;
		this.password = password;
		this.email = email;
		this.name = name;
		this.telephone = telephone;
		this.profileImage = profileImage;
	}
	
	public int getUserno() {
		return userNum;
	}
	public void setUserno(int userno) {
		this.userNum = userno;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getProfileImage() {
		return profileImage;
	}
	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}

	@Override
	public String toString() {
		return "UserVO [userNum=" + userNum + ", id=" + id + ", password=" + password + ", email=" + email + ", name="
				+ name + ", telephone=" + telephone + ", profileImage=" + profileImage + "]";
	}
	
}
