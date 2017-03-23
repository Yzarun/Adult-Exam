package com.yz.util;

import java.io.File;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.multipart.MultipartFile;

public class UploadFile {
	private static Log log = LogFactory.getLog(UploadFile.class);
	
	public static String upload(String path, MultipartFile file) {
		
		String origName = file.getOriginalFilename();
		log.info("上传文件：" + origName);
		String newName = System.currentTimeMillis() + origName.substring(origName.lastIndexOf("."));
		File saveFile = new File(path, newName);
		if(!saveFile.exists()) saveFile.mkdirs();
		try {
			file.transferTo(saveFile);
		} catch (Exception e) {
			log.error("上传文件出错……");
			e.printStackTrace();
		}
		return path + newName;
	}
}
