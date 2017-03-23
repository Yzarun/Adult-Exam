package com.yz.dao.common;

import java.util.List;

import com.alibaba.fastjson.JSONObject;

public interface CommonDAO {

	public Long insert(JSONObject jsonObj);
	
	public void delete(Object obj);
	
	public void deleteByMulti(JSONObject jsonObj);
	
	public void update(JSONObject jsonObj);
	
	public List<JSONObject> selectList(JSONObject jsonObj);
	
	public JSONObject selectOne(Object Obj);
	
}
