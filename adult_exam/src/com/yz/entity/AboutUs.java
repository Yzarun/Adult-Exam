package com.yz.entity;

import java.io.Serializable;
import java.util.Date;

public class AboutUs extends CommonEntity implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Long id;
	
	private String title;
	
	private String cont;
	
	/**
	 * 0 学院特色 1学院简介
	 */
	private Integer type;
	
	private String image;
	
	private Date createTime;
	
	private Long manager;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Long getManager() {
		return manager;
	}

	public void setManager(Long manager) {
		this.manager = manager;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getCont() {
		return cont;
	}

	public void setCont(String cont) {
		this.cont = cont;
	}

}
