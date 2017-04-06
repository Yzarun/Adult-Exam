package com.yz.entity;

import java.io.Serializable;
import java.util.Date;

public class Users extends CommonEntity implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Long id;
	
	private String username;

	private String email;
	
	private String password;
	
	private String name;
	
	/**
	 * 0：女  1：男
	 */
	private Integer gender;
	
	private Date birthdate;
	
	/**
	 * 0：用户  1：管理员
	 */
	private Integer type;
	
	/**
	 * 0：禁用  1：启用
	 */
	private Integer status;
	
	private String image;
	
	private Date createTime;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getGender() {
		return gender;
	}

	public void setGender(Integer gender) {
		this.gender = gender;
	}

	public Date getBirthdate() {
		return birthdate;
	}

	public void setBirthdate(Date birthdate) {
		this.birthdate = birthdate;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
	
}
