package prt;

import javax.servlet.ServletContext;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import prt.event.EventManager;

public class X
{
	@SuppressWarnings("unused")
	private static Log log = LogFactory.getLog(X.class);
	
	/** 事件管理 */
	public static EventManager event = new EventManager();
	
	/** 主服务器配置 */
	public static PrtSrvConfig conf = new PrtSrvConfig();
	
	
	private static ServletContext _servletContext;
	public static ServletContext getServletContext() { return _servletContext; }
	
	//被serp.local.sys.AppCtxListener:contextInitialized(sce)调用
	public static void initialize(ServletContext servletContext)
	{
		_servletContext = servletContext;
		conf.load();
		System.out.println(conf);
	}
}
