package com.yz.dao;

import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.yz.dao.common.CommonDAO;
import com.yz.dao.common.MyBatisDao;

@MyBatisDao
public interface RegistrationDAO extends CommonDAO {
	List<JSONObject> queryRegInfo(JSONObject jsonObj);
}
