package com.yz.service;

import com.alibaba.fastjson.JSONObject;
import com.yz.util.Result;


public interface ExamService {
	
	public Result insert(JSONObject jsonObj);
	
	public Result update(JSONObject jsonObj);
	
	public Result queryPage(JSONObject jsonObj);
	
	public Result delete(JSONObject jsonObj);
}
