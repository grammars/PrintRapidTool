package xfree.fb.utils;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/** 基于请求的上下文 */
public class ReqCtxUtil 
{
	@SuppressWarnings("unused")
	private static Log log = LogFactory.getLog(ReqCtxUtil.class);
	
	private static ThreadLocal<ServletRequest> tl_req = new ThreadLocal<>();
	private static ThreadLocal<ServletResponse> tl_resp = new ThreadLocal<>();
	
	public static void install(ServletRequest req, ServletResponse resp)
	{
		//log.debug("ReqCtxUtil.install @ " + Thread.currentThread());
		tl_req.set(req);
		tl_resp.set(resp);
	}
	
	public static void uninstall()
	{
		//log.debug("ReqCtxUtil.uninstall @ " + Thread.currentThread());
		tl_req.set(null);
		tl_resp.set(null);
	}
	
	//
	public static HttpServletRequest httpReq()
	{
		return (HttpServletRequest)tl_req.get();
	}
	//
	public static HttpServletResponse httpResp()
	{
		return (HttpServletResponse)tl_resp.get();
	}
	
	/** 写入session值 */
	public static void setSessionVal(String key, Object val)
	{
		HttpSession sess = httpReq().getSession(true);
		//log.debug("写入session值  sessionid="+sess.getId() + " key="+key+" / val="+val);
		if( val == null )
		{
			sess.removeAttribute(key);
		}
		else
		{
			sess.setAttribute(key, val);
		}
	}
	/** 读出session值 */
	public static Object getSessionVal(String key)
	{
		HttpSession sess = httpReq().getSession(false);
		//log.debug("读出session值  sessionid="+(sess!=null?sess.getId():"null") + " key="+key);
		if(sess != null) { return sess.getAttribute(key); }
		return null;
	}
	
	/** 释放session */
	public static void dispose()
	{
		HttpSession sess = httpReq().getSession();
		if(sess != null)
		{
			sess.invalidate();
		}
	}
}
