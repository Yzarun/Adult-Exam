package com.yz.service;

import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONObject;
import com.yz.util.Result;

public interface PublicService {

	public Result sendEmail(JSONObject jsonObj);
	
	public Result uploadImg(JSONObject jsonObj, MultipartFile file);
	
}
