package xfree.fb.utils;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationObjectSupport;

public class AppCtxUtil extends WebApplicationObjectSupport
{
	private static ApplicationContext ctx = null;
	
	/** 网站根目录AppCtxUtil.PATH=/my911 */
	public static String PATH;
	
	@Override
	protected void initApplicationContext(ApplicationContext context)throws BeansException
	{
		super.initApplicationContext(context);
		AppCtxUtil.ctx = context;
	}
	
	public static ApplicationContext context() { return ctx; }
	
	public static Object getBean(String id)
	{
		return context().getBean(id);
	}
}