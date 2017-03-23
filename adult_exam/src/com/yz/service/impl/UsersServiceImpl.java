package com.yz.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yz.dao.UsersDAO;
import com.yz.service.UsersService;
import com.yz.util.MD5Util;
import com.yz.util.Result;
@Service
public class UsersServiceImpl implements UsersService {

	@Resource
	UsersDAO usersDAO;

	@Override
	public Result login(JSONObject jsonObj) {
		Result result = new Result();
		try {
			jsonObj.put("password", MD5Util.encrypt(jsonObj.getString("password")));
			if(jsonObj.getIntValue("type") == 0 && jsonObj.getString("username").contains("@")) {
				jsonObj.put("email", jsonObj.getString("username"));
				jsonObj.remove("username");
			}
			List<JSONObject> usersList = usersDAO.selectList(jsonObj);
			if(usersList == null || usersList.isEmpty()) {
				result.setMsg("用户名或密码错误");
				result.setCode("0002");
				return result;
			} 
			if(usersList.get(0).getInteger("status") == 0) {
				result.setMsg("该用户已被禁用");
				result.setCode("0003");
				return result;
			}
			result.setData(usersList.get(0));
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
			result.setMsg("系统内部错误");
		}
		return result;
	}

	@Override
	public Result register(JSONObject jsonObj) {
		Result result = new Result();
		try {
			jsonObj.put("password", MD5Util.encrypt(jsonObj.getString("password")));
			jsonObj.put("type", 0);
			result.setData(usersDAO.insert(jsonObj));
			result.setMsg("注册成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
			result.setMsg("系统内部错误");
		}
		return result;
	}

	@Override
	public Result update(JSONObject jsonObj) {
		Result result = new Result();
		try {
			if(jsonObj.get("username") != null && !"0".equals(jsonObj.getString("type"))) {
				String username = jsonObj.getString("username");
				JSONObject user = usersDAO.selectOne(jsonObj.get("id"));
				if(!username.equals(user.getString("username"))){
					JSONObject param = new JSONObject();
					param.put("id", jsonObj.get("id"));
					param.put("plus", 1);
					param.put("username", username);
					if(!usersDAO.selectList(param).isEmpty()) {
						result.setCode("0001");
						result.setMsg("该用户名已存在");
						return result;
					}
				}
			}
			usersDAO.update(jsonObj);
			result.setData(usersDAO.selectList(jsonObj).get(0));
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
			result.setMsg("系统内部错误");
		}
		return result;
	}

	@Override
	public Result validate(JSONObject jsonObj) {
		Result result = new Result();
		try {
			jsonObj.put("type", 0);
			if(usersDAO.selectList(jsonObj).isEmpty())
				result.setCode("0000");
			else result.setCode("0001");//用户存在
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
			result.setMsg("系统内部错误");
		}
		return result;
	}

	@Override
	public Result getInfo(JSONObject jsonObj) {
		Result result = new Result();
		try {
			result.setData(usersDAO.selectList(jsonObj).get(0));
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
			result.setMsg("系统内部错误");
		}
		return result;
	}

	@Override
	public Result updatePass(JSONObject jsonObj) {
		Result result = new Result();
		try {
			if(MD5Util.encrypt(jsonObj.getString("origPass")).equals(usersDAO.selectList(jsonObj).get(0).getString("password"))) {
				jsonObj.put("password", MD5Util.encrypt(jsonObj.getString("newPass")));
				usersDAO.update(jsonObj);
			} else {
				result.setCode("0004");
				result.setMsg("原始密码错误");
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
			List<JSONObject> list = usersDAO.selectList(jsonObj);
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
	public Result insertManager(JSONObject jsonObj) {
		Result result = new Result();
		try {
			JSONObject param = new JSONObject();
			param.put("username", jsonObj.get("username"));
			param.put("type", 1);
			if(!usersDAO.selectList(param).isEmpty()) {
				result.setCode("0001");
				result.setMsg("该用户名已存在");
				return result;
			}
			jsonObj.put("password", MD5Util.encrypt("123456"));
			jsonObj.put("type", 1);
			result.setData(usersDAO.insert(jsonObj));
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
			usersDAO.delete(jsonObj.get("id"));
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
			result.setMsg("系统内部错误");
		}
		return result;
	}

}
