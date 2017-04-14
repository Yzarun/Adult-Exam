package com.yz.dao;

import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.yz.dao.common.CommonDAO;
import com.yz.dao.common.MyBatisDao;

@MyBatisDao
public interface ResultsDAO extends CommonDAO {

	public List<JSONObject> selectResults(JSONObject jsonObj);
}
