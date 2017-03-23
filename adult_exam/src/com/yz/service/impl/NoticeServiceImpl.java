package com.yz.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yz.dao.NoticeDAO;
import com.yz.service.NoticeService;
import com.yz.util.Result;
@Service
public class NoticeServiceImpl implements NoticeService {

	@Resource
	NoticeDAO noticeDAO;

	@Override
	public Result update(JSONObject jsonObj) {
		Result result = new Result();
		try {
			noticeDAO.update(jsonObj);
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
			List<JSONObject> list = noticeDAO.selectList(jsonObj);
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
			result.setData(noticeDAO.insert(jsonObj));
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
			noticeDAO.delete(jsonObj.get("id"));
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
			result.setMsg("系统内部错误");
		}
		return result;
	}

}
