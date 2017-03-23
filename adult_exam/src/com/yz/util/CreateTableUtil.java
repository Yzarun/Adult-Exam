package com.yz.util;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.mysql.jdbc.StringUtils;

public class CreateTableUtil {

	public static String getFieldName(String variable) {
		if(StringUtils.isNullOrEmpty(variable)) return variable;
		StringBuffer sb = new StringBuffer();
		for(char c : variable.toCharArray())
			sb.append(Character.isUpperCase(c) ? "_" + Character.toLowerCase(c) : c);
		return sb.toString();
	}
	
	public static String getColumn(Field field) {
		String fieldName = getFieldName(field.getName());
		Class<?> c = field.getType();
		String dataType = "varchar(255)";
		if(c.equals(int.class) || c.equals(Integer.class))
			dataType = "int(11)";
		else if(c.equals(long.class) || c.equals(Long.class))
			dataType = "bigint(20)";
		else if(c.equals(double.class) || c.equals(Double.class))
			dataType = "double";
		else if(c.equals(java.util.Date.class) || c.equals(java.sql.Date.class))
			dataType = "datetime";
		
		String column = "`" + fieldName + "` "+ dataType + " DEFAULT NULL,";
		if("id".equals(fieldName))
			column = column.replaceAll("DEFAULT NULL", "NOT NULL AUTO_INCREMENT");
		return column;
	}
	
	public static String getCreateTableSQL(String entityFullName) {
		Class<?> entity = null;
		try {
			entity = Class.forName(entityFullName);
		} catch (Exception e) {
			System.err.println("实体类\"" + entityFullName +"\"不存在！");
			e.printStackTrace();
		} catch (Error e) {
			System.err.println("实体类\"" + entityFullName +"\"不存在！");
			e.printStackTrace();
			return null;
		}
		List<Field> fieldList = new ArrayList<Field>(Arrays.asList(entity.getDeclaredFields()));
		
		String entityFieldName = getFieldName(entity.getSimpleName());
		String tableName = "`" + entityFieldName + "`";
		
		String sql = "CREATE TABLE IF NOT EXISTS " + tableName + " (";
		List<String> fieldNames = new ArrayList<String>();
		for(Field field : fieldList) {
			String fieldName = field.getName();
			sql += "serialVersionUID".equals(fieldName) || fieldNames.contains(fieldName) ? "" : getColumn(field);
			fieldNames.add(fieldName);
		}
		sql += "PRIMARY KEY (`id`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8;";
		return sql;
	}
	
	public static void main(String[] args) throws Exception {
		String sql = getCreateTableSQL("com.yz.entity.AboutUs");
		for(char c : sql.toCharArray()) {
			System.out.print(c);
			if(c == ',') 
				System.out.println();
		}
	}
	
}
