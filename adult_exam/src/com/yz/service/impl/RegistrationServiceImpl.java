package com.yz.service.impl;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mysql.jdbc.StringUtils;
import com.yz.dao.ExamDAO;
import com.yz.dao.RegistrationDAO;
import com.yz.dao.UsersDAO;
import com.yz.service.PublicService;
import com.yz.service.RegistrationService;
import com.yz.util.Result;
import com.yz.util.Utilities;
@Service
public class RegistrationServiceImpl implements RegistrationService {

	private SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日 HH:mm");
	@Resource
	RegistrationDAO registrationDAO;
	@Resource
	PublicService publicService;
	@Resource
	UsersDAO usersDAO;
	@Resource
	ExamDAO examDAO;
	
	
	@Override
	public Result update(JSONObject jsonObj) {
		Result result = new Result();
		try {
			JSONObject reg = registrationDAO.selectOne(jsonObj.getLong("id"));
			if(reg.getInteger("status") != 0) {
				result.setMsg("操作失败，该考生已审核");
				result.setSuccess(false);
			} else {
				registrationDAO.update(jsonObj);
				JSONObject sendParam = new JSONObject();
				sendParam.put("type", 2);
				sendParam.put("address", usersDAO.selectOne(reg.getLong("userId")).getString("email"));
				String examNum = reg.getString("examNum");
				String remark = jsonObj.getString("remark");
				JSONObject exam = examDAO.selectOne(reg.getLong("examId"));
				String examTime = sdf.format(exam.getDate("examTime"));
				String cont = exam.getString("cont");
				int status = jsonObj.getIntValue("status");
				if(status == 1) {
					String content =  "恭喜您！您报名的&nbsp;" + examTime + "“" + cont + "”的考试，审核通过。<p>考号：" + examNum;
					if(!StringUtils.isNullOrEmpty(remark)) {
						content += "<p>备注信息：" + remark;
					}
					content += "<p>好好准备吧~【成人自考网站】祝您考试愉快！";
					sendParam.put("content", content);
				} else {
					String content =  "很抱歉！您报名的&nbsp;" + examTime + "“" + cont + "”的考试，审核没有通过。<p>";
					if(!StringUtils.isNullOrEmpty(remark)) {
						content += "失败原因：" + remark;
					}
					sendParam.put("content", content);
				}
				publicService.sendEmail(sendParam);
				result.setMsg("操作成功");
			}
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

	@Override
	public Result getInfoPage(JSONObject jsonObj) {
		Result result = new Result();
		try {
			JSONObject data = new JSONObject();
			int pageNum = jsonObj.get("pageNum") == null ? 1 : jsonObj.getIntValue("pageNum");
			int rows = jsonObj.get("rows") == null ? 10 : jsonObj.getIntValue("rows");
			PageHelper.startPage(pageNum, rows);
			List<JSONObject> list = registrationDAO.queryRegInfo(jsonObj);
			PageInfo<JSONObject> page = new PageInfo<>(list);
			data.put("page", page);
			data.put("params", jsonObj);
			result.setData(data);
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
			result.setMsg("系统内部错误");
		}
		return result;
	}

}
