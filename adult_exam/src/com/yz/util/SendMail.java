package com.yz.util;

import java.io.InputStream;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message.RecipientType;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class SendMail {
	private static Log log = LogFactory.getLog(SendMail.class);
	public static void send(String title, String content, String toAddresses) throws Exception {
		final Properties properties = new Properties();
		InputStream in = SendMail.class.getResourceAsStream("/config.properties");
		properties.load(in);
		in.close();
		//构建授权信息，SMTP进行身份验证
		Authenticator authenticator = new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(properties.getProperty("mail.user"), 
						properties.getProperty("mail.password"));
			}
		};
		//使用环境属性和授权信息，创建邮件会话
		Session session = Session.getInstance(properties, authenticator);
		//创建邮件消息
		MimeMessage message = new MimeMessage(session);
		//设置发件人
		message.setFrom(new InternetAddress(properties.getProperty("mail.user")));
		//设置收件人的邮箱
		if(toAddresses.contains(",")) {
			String[] tos = toAddresses.split(",");
			InternetAddress[] addresses = new InternetAddress[tos.length];
			for(int i = 0; i < tos.length; i++)
				addresses[i] = new InternetAddress(tos[i]);
			message.setRecipients(RecipientType.TO, addresses);
		} else message.setRecipients(RecipientType.TO, toAddresses);;
		//设置邮件标题
		message.setSubject(title);
		//设置邮件的内容体
		message.setContent(content, "text/html;charset=UTF-8");
		//发送邮件
		Transport.send(message);
		log.info("TO：" + toAddresses + " 邮件发送成功");
	}
}
