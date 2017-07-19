package xfree.fb.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import xfree.fb.utils.ReqCtxUtil;

/** 一次请求的上下文Filter */
public class ReqCtxFilter implements Filter
{

	@Override
	public void destroy() 
	{
		
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException 
	{
		ReqCtxUtil.install(req, resp);
		chain.doFilter(req, resp);
		ReqCtxUtil.uninstall();
	}

	@Override
	public void init(FilterConfig cfg) throws ServletException
	{
		
	}

}
