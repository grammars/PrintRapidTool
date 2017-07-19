package prt.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthInterceptor extends HandlerInterceptorAdapter
{
	private Log log = LogFactory.getLog(AuthInterceptor.class);

	public static final String DEFAULT_CONTENT_TYPE = "application/json";
	public static final String HTML_CONTENT_TYPE = "text/html";
	public static final String DEFAULT_CHAR_ENCODING = "UTF-8";

	public AuthInterceptor()
	{
		log.debug("AuthInterceptor被实例化");
	}

	@SuppressWarnings("unused")
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception
	{
		//log.debug("AuthInterceptor.preHandle");
		String uri = request.getRequestURI();
		if(uri.contains("/public/"))
		{
			return true;
		}
		if (false)
		{
			log.warn("尚未完成登陆，没有权限使用接口");
			if (uri.endsWith(".json"))
			{
				response.setCharacterEncoding(DEFAULT_CHAR_ENCODING);
				response.setContentType(HTML_CONTENT_TYPE);
				PrintWriter out = response.getWriter();
				out.print("{\"errorcode\":-1,\"errormsg\":\"没有权限访问api!\"}");
			}
			else
			{
				request.getRequestDispatcher("/page/refuse.jsp").forward(request, response);
			}
			return false;
		}
		else
		{
			return true;
		}
	}

	/**
	 * 在业务处理器处理请求执行完成后,生成视图之前执行的动作 可在modelAndView中加入数据，比如当前时间
	 */
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception
	{
		//log.debug("AuthInterceptor.postHandle");
	}

	/**
	 * 在DispatcherServlet完全处理完请求后被调用,可用于清理资源等
	 * 
	 * 当有拦截器抛出异常时,会从当前拦截器往回执行所有的拦截器的afterCompletion()
	 */
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception
	{
		//log.debug("AuthInterceptor.afterCompletion");
	}


}
