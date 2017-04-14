package com.yz.util;

import java.util.Date;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializeConfig;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.alibaba.fastjson.serializer.SimpleDateFormatSerializer;

/**
 * 返回结果类
 * @author Administrator
 *
 */
public class Result {
	
	static {
		new SerializeConfig().put(Date.class, new SimpleDateFormatSerializer("yyyy-MM-dd HH:mm:ss"));  
	}
	
	/**
	 * 成功状态，默认成功
	 */
	private Boolean success = true;
	
	/**
	 * 返回状态码
	 * success:false 9999
	 * 0000  执行成功
	 * 0001 用户/用户名已存在
	 * 0002 用户名或密码错误
	 * 0003 用户禁用
	 * 0004 原始密码错误
	 * 0005 上传文件格式不支持（支持jpg、png、jpeg、bmp、gif格式）
	 * 0006 报名失败，该考试已报名
	 */
	private String code = "0000";
	
	/**
	 * 提醒消息
	 */
	private String msg;
	
	/**
	 * 返回数据
	 */
	private Object data;

	public String toJSONString() {
		return JSON.toJSONString(this,SerializerFeature.WriteDateUseDateFormat);
	}
	
	public JSON toJSON() {
		return (JSON) JSON.parse(this.toJSONString());
	}
	
	public JSONObject toJSONObject() {
		return JSON.parseObject(this.toJSONString());
	}
	
	public String dataToJSONString() {
		return JSON.toJSONString(this.data,SerializerFeature.WriteDateUseDateFormat);
	}
	
	public JSON dataToJSON() {
		return (JSON) JSON.parse(this.dataToJSONString());
	}
	
	public JSONObject dataToJSONObject() {
		return JSON.parseObject(this.dataToJSONString());
	}
	
	public Boolean getSuccess() {
		return success;
	}

	public void setSuccess(Boolean success) {
		this.success = success;
	}

	public String getCode() {
		if(!success) 
			code = "9999";
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}

	@Override
	public String toString() {
		return "Result [success=" + success + ", code=" + code + ", msg=" + msg
				+ ", data=" + data + "]";
	}
}
