package com.yz.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yz.dao.AboutUsDAO;
import com.yz.service.AboutUsService;
import com.yz.util.Result;
@Service
public class AboutUsServiceImpl implements AboutUsService {

	@Resource
	AboutUsDAO aboutUsDAO;


	@Override
	public Result update(JSONObject jsonObj) {
		Result result = new Result();
		try {
			aboutUsDAO.update(jsonObj);
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
			List<JSONObject> list = aboutUsDAO.selectList(jsonObj);
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
			result.setData(aboutUsDAO.insert(jsonObj));
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
			aboutUsDAO.delete(jsonObj.get("id"));
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
			result.setMsg("系统内部错误");
		}
		return result;
	}

	@Override
	public Result saveAbout(JSONObject jsonObj) {
		Result result = new Result();
		try {
			JSONObject param = new JSONObject();
			param.put("type", 1);
			List<JSONObject> list = aboutUsDAO.selectList(param);
			if(list.isEmpty())
				aboutUsDAO.insert(jsonObj);
			else {
				jsonObj.put("id", list.get(0).get("id"));
				aboutUsDAO.update(jsonObj);
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
			result.setMsg("系统内部错误");
		}
		return result;
	}

}
