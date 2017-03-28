package com.yz.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONObject;
import com.yz.dao.UsersDAO;
import com.yz.service.PublicService;
import com.yz.util.MD5Util;
import com.yz.util.Result;
import com.yz.util.SendMail;
import com.yz.util.StringUtil;
import com.yz.util.UploadFile;
@Service
public class PublicServiceImpl implements PublicService {

	@Resource
	UsersDAO usersDAO;
	
	@Override
	public Result sendEmail(JSONObject jsonObj) {
		Result result = new Result();
		try {
			String title = new String();
			String content = new String();
			JSONObject data = new JSONObject();
			int type = jsonObj.getIntValue("type");
			String address = jsonObj.getString("address");
			if(type == 0) { //注册验证
				String randomCode = StringUtil.randomCode(6);
				data.put("code", randomCode);
				data.put("address", address);
				result.setData(data);
				title = "【成人自考网站系统】注册验证";
				content = "欢迎加 \"成人自考网站\"，注册验证码：<b>" + randomCode + "</b><p>如非本人操作，请忽略此邮件。";
			}
			if(type == 1) {//密码重置
				String randomCode = StringUtil.randomCode(6);
				title = "【成人自考网站系统】密码重置";
				JSONObject params = new JSONObject();
				params.put("email", address);
				params.put("type", 0);
				Map<String, Object> user = usersDAO.selectList(params).get(0);
				content = user.get("username") + " 您好！<br>&emsp;&emsp;您的 \"成人自考网站\"登录密码已被重置，新密码为：<b>" + randomCode + "</b><p>如非本人操作，请忽略此邮件。";
				params.put("id", user.get("id"));
				params.put("password", MD5Util.encrypt(randomCode));
				usersDAO.update(params);
			}
			SendMail.send(title, content, address);
			result.setMsg("邮件发送成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.setMsg("邮件发送失败");
			result.setSuccess(false);
		}
		return result;
	}

	@Override
	public Result uploadImg(JSONObject jsonObj, MultipartFile file) {
		Result result = new Result();
		try {
			String origName = file.getOriginalFilename();
			String suffix = origName.substring(origName.lastIndexOf(".") + 1);
			String suffixList = "jpg,png,jpeg,bmp,gif";
			if(suffixList.contains(suffix.toLowerCase()))
				UploadFile.upload(jsonObj.getString("path"), file);
			else {
				result.setCode("0005");
				result.setMsg("上传文件格式不支持（支持jpg、png、jpeg、bmp、gif格式）");
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.setMsg("上传图片失败");
			result.setSuccess(false);
		}
		return result;
	}

}
