package xfree.fb.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import xfree.fb.utils.AppCtxUtil;

public class AppCtxListener implements ServletContextListener
{

	@Override
	public void contextDestroyed(ServletContextEvent sce)
	{
		System.out.println("AppCtxListener:contextDestroyed(sce)");
	}

	@Override
	public void contextInitialized(ServletContextEvent sce)
	{
		System.out.println("AppCtxListener:contextInitialized(sce)");
		ServletContext application = sce.getServletContext();
		application.setAttribute("PATH", application.getContextPath());//网站根目录
		application.setAttribute("STATIC", application.getContextPath()+"/static");//静态文件
		application.setAttribute("PAGE", application.getContextPath()+"/page");//页面文件
		AppCtxUtil.PATH = application.getContextPath();
	}

}
