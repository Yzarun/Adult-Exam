package com.yz.service;

import com.alibaba.fastjson.JSONObject;
import com.yz.util.Result;


public interface AboutUsService {
	
	public Result insert(JSONObject jsonObj);
	
	public Result update(JSONObject jsonObj);
	
	public Result queryPage(JSONObject jsonObj);
	
	public Result delete(JSONObject jsonObj);
	
	public Result saveAbout(JSONObject jsonObj);
	
	public Result getAbout1(JSONObject jsonObj);
	
	public Result getAbout0(JSONObject jsonObj);
}
