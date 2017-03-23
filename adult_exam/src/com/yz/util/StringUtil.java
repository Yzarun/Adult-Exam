package com.yz.util;

import java.util.Random;

public class StringUtil {

	public static synchronized String randomCode(int length){
		String str="ABCDEFGHJKLMNPQRST1234567890";
		StringBuffer sb = new StringBuffer();
		for(int i = 0; i < length ; i++)
			sb.append(str.charAt(new Random().nextInt(str.length())) + "");
		return sb.toString();
	}
}
