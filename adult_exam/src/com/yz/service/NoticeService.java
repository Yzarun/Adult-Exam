package com.yz.service;

import com.alibaba.fastjson.JSONObject;
import com.yz.util.Result;


public interface NoticeService {
	
	public Result insert(JSONObject jsonObj);
	
	public Result update(JSONObject jsonObj);
	
	public Result queryPage(JSONObject jsonObj);
	
	public Result delete(JSONObject jsonObj);
	
	public Result getList(JSONObject jsonObj);
}
