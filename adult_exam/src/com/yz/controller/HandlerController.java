package com.yz.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.yz.service.AboutUsService;
import com.yz.service.ExamService;
import com.yz.service.MajorService;
import com.yz.service.NoticeService;
import com.yz.service.PublicService;
import com.yz.service.RegistrationService;
import com.yz.service.ResultsService;
import com.yz.service.UsersService;
import com.yz.util.Result;
import com.yz.util.Utilities;

@Controller
public class HandlerController {

	private static Log log = LogFactory.getLog(HandlerController.class);
	
	@Resource
	UsersService usersService;
	@Resource
	PublicService publicService;
	@Resource
	MajorService majorService;
	@Resource
	ExamService examService;
	@Resource
	AboutUsService aboutUsService;
	@Resource
	NoticeService noticeService;
	@Resource
	RegistrationService registrationService;
	@Resource
	ResultsService resultsService;
	
	@RequestMapping(value = "{model}/{method}")
	@ResponseBody
	public JSON execute(@PathVariable String model, @PathVariable String method, @RequestBody JSONObject jsonObj, HttpServletRequest request) {
		
		long start = System.currentTimeMillis();
		Result res = new Result();
		switch (model + "#" + method) {
			case "handler#login":
				res = usersService.login(jsonObj);
				if("0000".equals(res.getCode())) {
					JSONObject user = (JSONObject) res.getData();
					request.getSession().setAttribute(user.getInteger("type") == 0 ? "frontUser" : "backUser", user);
				}
				break;
			case "handler#register":
				res = usersService.register(jsonObj);
				break;
			case "handler#validateUsers":
				res = usersService.validate(jsonObj);
				break;
			case "handler#sendEmail":
				res = publicService.sendEmail(jsonObj);
				break;
			case "handler#getUserInfo":
				res = usersService.getInfo(jsonObj);
				break;
			case "back#updateUser":
				res = usersService.update(jsonObj);
				break;
			case "front#updateUser":
				res = usersService.update(jsonObj);
				if("0000".equals(res.getCode())) {
					JSONObject user = (JSONObject) res.getData();
					request.getSession().setAttribute("frontUser", user);
				}
				break;
			case "back#updatePass":
				res = usersService.updatePass(jsonObj);
				if("0000".equals(res.getCode())) request.getSession().removeAttribute("backUser");
				break;
			case "front#updatePass":
				res = usersService.updatePass(jsonObj);
				if("0000".equals(res.getCode())) request.getSession().removeAttribute("frontUser");
				break;
			case "back#saveAbout":
				jsonObj.put("manager", ((JSONObject) request.getSession().getAttribute("backUser")).get("id"));
				res = aboutUsService.saveAbout(jsonObj);
				break;
			case "back#getAboutCont":
				res = aboutUsService.getAbout1(jsonObj);
				break;
			case "handler#getExams":
				res = examService.getList(jsonObj);
				break;
			case "handler#getUsers":
				res = usersService.getInfo(jsonObj);
				break;
			case "front#regExam":
				res = registrationService.insert(jsonObj);
				break;
			case "front#getResults":
				res = resultsService.getResults(jsonObj);
				break;
		}
		long end = System.currentTimeMillis();
		JSON result = res.toJSON();
		log.info("\n\n执行方法：" + method + "（耗时：" + (end - start) + 
				"毫秒）\n【请求参数】" + jsonObj + "\n【执行结果】" + result + "\n");
		return result;
	}
	
	@RequestMapping(value = "logout")
	public String logout(int type, HttpServletRequest request) {
		if(type == 0)
			request.getSession().removeAttribute("frontUser");
		else if(type == 1)
			request.getSession().removeAttribute("backUser");
		return null;
	}
	
	@RequestMapping(value = "/back/{method}/get")
	@ResponseBody
	public JSON getPages(@PathVariable String method, HttpServletRequest request) {
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("page", request.getParameter("page"));
		jsonObj.put("rows", request.getParameter("rows"));
		if(Boolean.parseBoolean(request.getParameter("_search"))) {
			jsonObj.put(request.getParameter("searchField"), request.getParameter("searchString"));
			jsonObj.put("searchOper", request.getParameter("searchOper"));
		}
		jsonObj.put("sidx", request.getParameter("sidx"));
		jsonObj.put("sord", request.getParameter("sord"));
		Result res = new Result();
		switch (method) {
		case "about":
			jsonObj.put("type", 0);
			res = aboutUsService.queryPage(jsonObj);
			break;
		case "notice":
			res = noticeService.queryPage(jsonObj);
			break;
		case "major":
			res = majorService.queryPage(jsonObj);
			break;
		case "examinee":
			res = registrationService.queryPage(jsonObj);
			break;
		case "exam":
			res = examService.queryPage(jsonObj);
			break;
		case "users0":
			jsonObj.put("type", 0);
			res = usersService.queryPage(jsonObj);
			break;
		case "users1":
			jsonObj.put("type", 1);
			jsonObj.put("plus", 0);
			res = usersService.queryPage(jsonObj);
			break;
		}
		if("0000".equals(res.getCode()))
			return res.dataToJSON();
		return null;
	}
	
	@RequestMapping(value = "/back/{method}/insertUpdateDelete")
	@ResponseBody
	public JSON insertUpdateDelete(@PathVariable String method, String oper, HttpServletRequest request) {
		Result res = new Result();
		JSONObject jsonObj = Utilities.getReqJSONObject(request);
		log.info("\n[insertUpdateDelete]请求参数：" + jsonObj);
		jsonObj.put("manager", ((JSONObject) request.getSession().getAttribute("backUser")).get("id"));
		if("add".equals(oper)) {
			if("major".equals(method)) {
				res = majorService.insert(jsonObj);
			} else if("users1".equals(method)) {
				res = usersService.insertManager(jsonObj);
			} else if("notice".equals(method)) {
				res = noticeService.insert(jsonObj);
			} else if("about".equals(method)) {
				jsonObj.put("type", 0);
				res = aboutUsService.insert(jsonObj);
			} else if("exam".equals(method)) {
				res = examService.insert(jsonObj);
			}
			
		} else if("edit".equals(oper)) {
			if("major".equals(method)) {
				res = majorService.update(jsonObj);
			} else if("users0".equals(method) || "users1".equals(method)) {
				res = usersService.update(jsonObj);
			} else if("notice".equals(method)) {
				res = noticeService.update(jsonObj);
			} else if("about".equals(method)) {
				res = aboutUsService.update(jsonObj);
			} else if("exam".equals(method)) {
				res = examService.update(jsonObj);
			} else if("examinee".equals(method)) {
				res = registrationService.update(jsonObj);
			}
			
			
		} else if("del".equals(oper)) {
			if("major".equals(method)) {
				res = majorService.delete(jsonObj);
			} else if("users1".equals(method)) {
				res = usersService.delete(jsonObj);
			} else if("notice".equals(method)) {
				res = noticeService.delete(jsonObj);
			} else if("about".equals(method)) {
				res = aboutUsService.delete(jsonObj);
			} else if("exam".equals(method)) {
				res = examService.delete(jsonObj);
			}
		}
		return res.toJSON();
	}
	
	@RequestMapping(value = "getMajors")
	@ResponseBody
	public JSON getMajors() {
		return majorService.getMajorName().dataToJSON();
	}
	
	@RequestMapping(value = "uploadFile")
	@ResponseBody
	public String uploadFile(MultipartFile image, HttpServletRequest request) {
		return publicService.uploadImg(image, request).toJSONString();
	}
	
	@RequestMapping(value = "getHomeData")
	@ResponseBody
	public JSON getHomeData() {
		JSONObject allData = new JSONObject();
		JSONObject param = new JSONObject();
		param.put("type", 1);
		allData.put("aboutIntro", aboutUsService.getAbout1(param).getData());
		param.put("type", 0);
		allData.put("aboutFeat", aboutUsService.getAbout0(param).getData());
		param.clear();
		allData.put("majors", majorService.getList(param).getData());
		allData.put("majorData", majorService.getMajorName().getData());
		allData.put("notices", noticeService.getList(param).getData());
		return allData;
	}
	
	
	
}