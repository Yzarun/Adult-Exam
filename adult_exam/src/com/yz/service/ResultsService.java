package com.yz.service;

import com.alibaba.fastjson.JSONObject;
import com.yz.util.Result;


public interface ResultsService {
	
	public Result insert(JSONObject jsonObj);
	
	public Result update(JSONObject jsonObj);
	
	public Result delete(JSONObject jsonObj);
	
	public Result getResults(JSONObject jsonObj);
	
	public Result operaResults(JSONObject jsonObj);
	
	public Result getResultsByReg(Long regId);
}
