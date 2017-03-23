package com.yz.entity;

import java.io.Serializable;
import java.util.Date;

public class Results extends CommonEntity implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Long id;
	/**
	 * 考试内容
	 */
	private String course;
	
	private Double score;
	
	private Long registrationId;
	
	private Date createTime;
	
	private Long manager;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getCourse() {
		return course;
	}

	public void setCourse(String course) {
		this.course = course;
	}

	public Double getScore() {
		return score;
	}

	public void setScore(Double score) {
		this.score = score;
	}

	public Long getRegistrationId() {
		return registrationId;
	}

	public void setRegistrationId(Long registrationId) {
		this.registrationId = registrationId;
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
	
}
