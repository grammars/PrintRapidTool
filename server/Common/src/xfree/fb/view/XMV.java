package xfree.fb.view;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import javakit.framework.ErrorCode;
import xfree.fb.utils.ReqCtxUtil;

public class XMV 
{
	private ModelAndView mv;
	
	public XMV()
	{
		mv = new ModelAndView();
	}
	
	public XMV(String viewName)
	{
		mv = new ModelAndView(viewName);
	}
	
	public XMV put(String attributeName, Object attributeValue)
	{
		mv.addObject(attributeName, attributeValue);
		return this;
	}
	
	public XMV ec(ErrorCode value)
	{
		mv.addObject("errorcode", value.getErrorcode());
		mv.addObject("errormsg", value.getErrormsg());
		return this;
	}
	
	public XMV ec(int errorcode, String errormsg)
	{
		mv.addObject("errorcode", errorcode);
		mv.addObject("errormsg", errormsg);
		return this;
	}
	
	public static XMV redirect(String value)
	{
		XMV xmv = new XMV("redirect:"+value);
		return xmv;
	}
	
	public ModelAndView exeRaw()
	{
		return mv;
	}
	
	public ModelAndView exe()
	{
		return exe(ReqCtxUtil.httpReq(), ReqCtxUtil.httpResp());
	}
	
	public ModelAndView exe(HttpServletRequest req, HttpServletResponse resp)
	{
		// HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		String uri = req.getRequestURI();
		if (uri.endsWith(".json"))
		{
			JsonView view = new JsonView();
			if(dateFormat != null && dateFormat.length() > 0)
			{
				view.setDateFormat(dateFormat);
			}
			return new ModelAndView(view, mv.getModelMap());
		}
		else if (uri.endsWith(".pdf"))
		{
			// return new ModelAndView(new ViewPDF(), mv.getModelMap());
		} 
		else if (uri.endsWith(".xlsx"))
		{
			// return new ModelAndView(new ViewExcel(), mv.getModelMap());
		}
		return mv;
	}
	
	public String getDateFormat()
	{
		return dateFormat;
	}

	public void setDateFormat(String dateFormat)
	{
		this.dateFormat = dateFormat;
	}

	private String dateFormat;
}
