package com.yz.filter;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.filter.OncePerRequestFilter;

import com.yz.util.ParameterRequestWrapper;

public class SessionFilter extends OncePerRequestFilter {
	private static Log log = LogFactory.getLog(SessionFilter.class);
	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws ServletException, IOException {
		ParameterRequestWrapper requestWrapper = new ParameterRequestWrapper(request);
		String requestURL = request.getRequestURL().toString();
		if(requestURL.contains("front") || requestURL.contains("back")) {
			boolean doFilter = false;
			String toUrl = new String();
			if(requestURL.contains("front") && request.getSession().getAttribute("frontUser") == null) {
				doFilter = true;
				toUrl = "front_login.jsp";
			} else if(requestURL.contains("back") && request.getSession().getAttribute("backUser") == null) {
				doFilter = true;
				toUrl = "back_login.jsp";
			}
			if(doFilter) {
				 PrintWriter writer = response.getWriter();
				 boolean isAjax = request.getHeader("x-requested-with") != null && request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest");
				 log.info("\n请求[" + requestURL + "]被拦截" + (isAjax ? "（ajax请求）" : ""));
				 writer.write(isAjax ? "loseSession" : getPromptPages(toUrl));
			} else {
				if(requestURL.contains("back") && "add".equals(requestWrapper.getParameter("oper")))
					requestWrapper.addParameter("id", 0);
				chain.doFilter(requestWrapper, response);
			}
		} else chain.doFilter(requestWrapper, response);
	}

	private static String getPromptPages(String toUrl) {
		return "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">"
				+ "<html xmlns=\"http://www.w3.org/1999/xhtml\"><head><title>你还没有登录，请先登录</title>"
				+ "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"><script src=\"js/jquery/jquery-2.0.3.min.js\"></script>"
				+ "<script src=\"js/layer/layer.js\"></script><script>$(function() {layer.confirm(\"你还没有登录，请先登录\",{icon:2,title:\"提示\",closeBtn:0,btn:['确定']},"
				+ "function() {top.location.href=\"" + toUrl + "\";});});</script></head><h3>你还没有登录，请先登录</h3></html>";
	}
}
