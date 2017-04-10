package com.yz.service.impl;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yz.dao.ExamDAO;
import com.yz.service.ExamService;
import com.yz.util.Result;
@Service
public class ExamServiceImpl implements ExamService {

	@Resource
	ExamDAO examDAO;

	@Override
	public Result update(JSONObject jsonObj) {
		Result result = new Result();
		try {
			examDAO.update(jsonObj);
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
			List<JSONObject> list = examDAO.selectList(jsonObj);
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
			examDAO.insert(jsonObj);
			result.setData(jsonObj.get("id"));
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
			examDAO.delete(jsonObj.get("id"));
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
			result.setMsg("系统内部错误");
		}
		return result;
	}

	@Override
	public Result getList(JSONObject jsonObj) {
		Result result = new Result();
		try {
			jsonObj.put("examTime", new Date());
			jsonObj.put("searchOper", "gt");
			result.setData(examDAO.selectList(jsonObj));
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
			result.setMsg("系统内部错误");
		}
		return result;
	}

}
