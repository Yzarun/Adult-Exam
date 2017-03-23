package com.yz.entity;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

public class CommonEntity {
	
	public JSONObject toJSONObject() {
		return JSON.parseObject(JSON.toJSONString(this));
	}
	
}
