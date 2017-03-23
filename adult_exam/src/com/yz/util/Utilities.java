package com.yz.util;

import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.yz.entity.Users;

public class Utilities {
	
	public static List<JSONObject> listMapToJSON(List<Map<String, Object>> list) {
		if(list == null || list.isEmpty()) return null;
		List<JSONObject> jsonList = new ArrayList<>();
		for(Map<String, Object> map : list) 
			jsonList.add(new JSONObject(map));
		return jsonList;
	}
	
	public static JSONObject getReqJSONObject(HttpServletRequest request) {
		JSONObject params = new JSONObject();
		Enumeration<String> enumeration = request.getParameterNames();  
		while(enumeration.hasMoreElements()) {  
			String paraName = (String) enumeration.nextElement(); 
			params.put(paraName, request.getParameter(paraName));
		} 
		return params;
	}
	
	public static <T> T getEntity(HttpServletRequest request, Class<T> clazz) throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		JSONObject params = new JSONObject();
		Enumeration<String> enumeration = request.getParameterNames();  
		while(enumeration.hasMoreElements()) {  
			String paraName = (String) enumeration.nextElement(); 
			List<String> nameList = getFieldNameList(clazz);
			if(nameList.contains(paraName)) {
				//clazz.getDeclaredField(paraName).getType().equals(Date.class)
				if("birthdate".equals(paraName))
					params.put(paraName, sdf.parse(request.getParameter(paraName)));
				else params.put(paraName, request.getParameter(paraName));
			}
		} 
		return JSON.parseObject(params.toJSONString(), clazz);
	}
	
	public static <T> JSONObject getEntityToJSON(HttpServletRequest request, Class<T> clazz) throws Exception {
		return JSON.parseObject(JSON.toJSONString(getEntity(request, clazz)));
	}
	
	private static List<String> getFieldNameList(Class<?> clazz) {
		List<String> list = new ArrayList<>();
		Field[] fieldArr = clazz.getDeclaredFields();
		for(int i = 0; i < fieldArr.length; i++)
			list.add(fieldArr[i].getName());
		return list;
	}
	
	public static void main(String[] args) {
		try {
			System.out.println(getFieldNameList(Users.class));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
