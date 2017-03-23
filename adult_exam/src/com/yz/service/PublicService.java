package com.yz.service;

import com.alibaba.fastjson.JSONObject;
import com.yz.util.Result;

public interface PublicService {

	public Result sendEmail(JSONObject jsonObj);
	
	public Result uploadImg(JSONObject jsonObj);
	
}
