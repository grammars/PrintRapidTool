package prt.sys;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import prt.X;

public class AppCtxListener implements ServletContextListener
{

	@Override
	public void contextDestroyed(ServletContextEvent sce)
	{
		System.out.println("prt.sys.AppCtxListener:contextDestroyed(sce)");
	}

	@Override
	public void contextInitialized(ServletContextEvent sce)
	{
		System.out.println("prt.sys.AppCtxListener:contextInitialized(sce)");
		X.initialize(sce.getServletContext());
	}

}
