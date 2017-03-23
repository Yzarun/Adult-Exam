package com.yz.service;

import com.alibaba.fastjson.JSONObject;
import com.yz.util.Result;


public interface UsersService {
	
	public Result login(JSONObject jsonObj);
	
	public Result register(JSONObject jsonObj);
	
	public Result insertManager(JSONObject jsonObj);
	
	public Result update(JSONObject jsonObj);
	
	public Result validate(JSONObject jsonObj);
	
	public Result getInfo(JSONObject jsonObj);
	
	public Result updatePass(JSONObject jsonObj);
	
	public Result queryPage(JSONObject jsonObj);
	
	public Result delete(JSONObject jsonObj);
}
