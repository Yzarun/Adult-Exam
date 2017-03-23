package com.yz.entity;

import java.io.Serializable;
import java.util.Date;

public class Exam extends CommonEntity implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Long id;
	
	private Date examTime;
	/**
	 * 考试内容
	 */
	private String cont;
	
	private Long majorId;
	
	private Date createTime;
	
	private Long manager;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Date getExamTime() {
		return examTime;
	}

	public void setExamTime(Date examTime) {
		this.examTime = examTime;
	}

	public Long getMajorId() {
		return majorId;
	}

	public void setMajorId(Long majorId) {
		this.majorId = majorId;
	}

	public Long getManager() {
		return manager;
	}

	public void setManager(Long manager) {
		this.manager = manager;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getCont() {
		return cont;
	}

	public void setCont(String cont) {
		this.cont = cont;
	}
	
}
