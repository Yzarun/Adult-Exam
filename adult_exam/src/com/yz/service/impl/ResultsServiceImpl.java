package com.yz.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mysql.jdbc.StringUtils;
import com.yz.controller.HandlerController;
import com.yz.dao.ExamDAO;
import com.yz.dao.ResultsDAO;
import com.yz.service.ResultsService;
import com.yz.util.Result;
import com.yz.util.StringUtil;
import com.yz.util.Utilities;
@Service
public class ResultsServiceImpl implements ResultsService {
	private static Log log = LogFactory.getLog(ResultsServiceImpl.class);
	@Resource
	ResultsDAO resultsDAO;
	@Resource
	ExamDAO examDAO;

	@Override
	public Result update(JSONObject jsonObj) {
		Result result = new Result();
		try {
			resultsDAO.update(jsonObj);
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
			resultsDAO.insert(jsonObj);
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
			resultsDAO.delete(jsonObj.get("id"));
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
			result.setMsg("系统内部错误");
		}
		return result;
	}

	@Override
	public Result getResults(JSONObject jsonObj) {
		Result result = new Result();
		try {
			result.setData(resultsDAO.selectResults(jsonObj));
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
			result.setMsg("系统内部错误");
		}
		return result;
	}

	@Override
	public Result operaResults(JSONObject jsonObj) {
		Result result = new Result();
		try {
			log.info("operaResults参数：" + jsonObj);
			Long registrationId = jsonObj.getLong("registrationId");
			String deleteIds = jsonObj.getString("deleteIds");
			String editData = jsonObj.getString("editData");
			if(!StringUtils.isNullOrEmpty(deleteIds)) {
				resultsDAO.delete(deleteIds);
			}
			for(String s1 : editData.split("-")) {
				String[] arry = s1.split(",");
				JSONObject param = new JSONObject();
				param.put("registrationId", registrationId);
				param.put("course", arry[1]);
				param.put("score", arry[2]);
				if("0".equals(arry[0])) {
					resultsDAO.insert(param);
				} else {
					param.put("id", arry[0]);
					resultsDAO.update(param);
				}
			}
			result.setMsg("操作成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
			result.setMsg("系统内部错误");
		}
		return result;
	}

	@Override
	public Result getResultsByReg(Long regId) {
		Result result = new Result();
		try {
			result.setData(resultsDAO.selectResultsByReg(regId));
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
			result.setMsg("系统内部错误");
		}
		return result;
	}

}
