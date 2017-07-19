package prt.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javakit.framework.ErrorCodeSupport;
import prt.service.Result;
import prt.service.TplService;
import prt.utils.SrvUtil;
import prt.vo.PrtContext;
import prt.vo.PrtTpl;
import xfree.fb.view.XMV;

@Controller
@RequestMapping("/tpl/")
public class TplController
{
	@Autowired
	TplService tplService;
	
	@RequestMapping("list.json")
	public ModelAndView list(PrtContext context, HttpServletRequest request)
	{
		// http://localhost/tpl/list.json
		SrvUtil.dumpRequest(request, "tpl/list.json-----------");
		Result<List<PrtTpl>> tplListResult = tplService.list(context, true);
		XMV xmv = new XMV();
		xmv.put("list", tplListResult.getData());
		xmv.ec(tplListResult);
		return xmv.exe();
	}
	
	/** 保存模版 */
	@RequestMapping("save.json")
	public ModelAndView save(PrtContext context, PrtTpl tpl, HttpServletRequest request)
	{
		// http://localhost/tpl/save.json?
		SrvUtil.dumpRequest(request, "tpl/save-----------");
		
		ErrorCodeSupport result = tplService.save(context, tpl);
		
		XMV xmv = new XMV();
		xmv.ec(result);
		return xmv.exe();
	}
	
	/** 删除模版 */
	@RequestMapping("delete.json")
	public ModelAndView delete(PrtContext context, @RequestParam(value="tplId")Integer tplId, HttpServletRequest request)
	{
		// http://localhost/tpl/delete.json?
		SrvUtil.dumpRequest(request, "tpl/delete-----------");
		
		ErrorCodeSupport result = tplService.delete(context, tplId);
		
		XMV xmv = new XMV();
		xmv.ec(result);
		return xmv.exe();
	}
}
