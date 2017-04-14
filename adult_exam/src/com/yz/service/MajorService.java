package com.yz.service;

import com.alibaba.fastjson.JSONObject;
import com.yz.util.Result;


public interface MajorService {
	
	public Result queryPage(JSONObject jsonObj);
	
	public Result insert(JSONObject jsonObj);
	
	public Result update(JSONObject jsonObj);
	
	public Result delete(Object obj);
	
	public Result getMajorName();
	
	public Result getList(JSONObject jsonObj);
}
