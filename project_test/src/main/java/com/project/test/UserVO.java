package com.project.test;

import org.springframework.stereotype.Component;

@Component("userVO")
public class UserVO {
	int userNum;
	String id, password, email, name, telephone;
	
	
	public UserVO() {
	}
	public UserVO(int userno, String id, String password, String email, String name, String telephone) {
		this.userNum = userno;
		this.id = id;
		this.password = password;
		this.email = email;
		this.name = name;
		this.telephone = telephone;
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
	@Override
	public String toString() {
		return "UserVO [userno=" + userNum + ", id=" + id + ", password=" + password + ", email=" + email + ", name="
				+ name + ", telephone=" + telephone + "]";
	}
	
	
}