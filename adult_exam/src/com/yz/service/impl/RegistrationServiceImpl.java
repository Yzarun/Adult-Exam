package com.yz.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yz.dao.RegistrationDAO;
import com.yz.service.RegistrationService;
import com.yz.util.Result;
@Service
public class RegistrationServiceImpl implements RegistrationService {

	@Resource
	RegistrationDAO registrationDAO;

	@Override
	public Result update(JSONObject jsonObj) {
		Result result = new Result();
		try {
			registrationDAO.update(jsonObj);
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
			result.setMsg("系统内部错误");
		}
		return result;
	}

	@Override
	public Result queryPage(JSONObject jsonObj) {
		Result result = new Result();
		try {
			PageHelper.startPage(jsonObj.getIntValue("page"), jsonObj.getIntValue("rows"),
					jsonObj.getString("sidx") + " " + jsonObj.getString("sord"));
			List<JSONObject> list = registrationDAO.selectList(jsonObj);
			PageInfo<JSONObject> page = new PageInfo<>(list);
			result.setData(page);
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
			result.setMsg("系统内部错误");
		}
		return result;
	}

	@Override
	public Result insert(JSONObject jsonObj) {
		Result result = new Result();
		try {
			if(!registrationDAO.selectList(jsonObj).isEmpty()) {
				result.setCode("0006");
				result.setMsg("报名失败，该考试已报名");
			} else {
				jsonObj.put("examNum", System.currentTimeMillis());
				registrationDAO.insert(jsonObj);
				result.setData(jsonObj.get("id"));
				result.setMsg("报名申请成功！平台尽快为您处理，处理结果会发送至您的邮箱，请注意查收！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
			result.setMsg("系统内部错误");
		}
		return result;
	}

	@Override
	public Result delete(JSONObject jsonObj) {
		Result result = new Result();
		try {
			registrationDAO.delete(jsonObj.get("id"));
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
			result.setMsg("系统内部错误");
		}
		return result;
	}

}
