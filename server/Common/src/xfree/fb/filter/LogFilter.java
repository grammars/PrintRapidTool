package xfree.fb.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class LogFilter implements Filter
{
	private ThreadLocal<Long> startTime = new ThreadLocal<>();
	private ThreadLocal<Long> costTime = new ThreadLocal<>();
	
	Log log = LogFactory.getLog(this.getClass());

	@Override
	public void destroy()
	{
		log.debug("LogFilter:destroy()");
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException
	{
		startTime.set( System.currentTimeMillis() ); 
		//log.debug("LogFilter:doFilter()" + Thread.currentThread().getName());
		chain.doFilter(req, resp);
		costTime.set( System.currentTimeMillis() - startTime.get() );
		//log.debug("cost time => " + costTime.get() + "  " + Thread.currentThread().getName());
		//System.out.println( "catalina.home=" + System.getProperty("catalina.home") );
	}

	@Override
	public void init(FilterConfig config) throws ServletException
	{
		log.debug("LogFilter:init()");
	}

}

