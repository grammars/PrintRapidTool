package prt.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import prt.utils.SrvUtil;
import prt.vo.test.CusDataDemo;
import prt.vo.test.FgDataDemo;
import xfree.fb.view.XMV;

@Controller
@RequestMapping("/test/")
public class TestController
{
	/** 测试场景页 */
	@RequestMapping("app.page")
	public ModelAndView app_page()
	{
		// http://localhost/test/app.page
		XMV xmv = new XMV("page/test/app");
		return xmv.exe();
	}
	
	/** 客户信息接口 */
	@RequestMapping("cusData.json")
	public ModelAndView cusData(HttpServletRequest request)
	{
		// http://localhost/test/cusData.json?fg=fg0
		
		SrvUtil.dumpRequest(request, "cusData-----------");
		
		XMV xmv = new XMV();
		CusDataDemo demo = new CusDataDemo();
		demo.writeTo(xmv);
		return xmv.exe();
	}
	
	/** 组单内的全部子单信息 */
	@RequestMapping("fgData.json")
	public ModelAndView fgData(@RequestParam(value="fgid")String fgid, HttpServletRequest request)
	{
		// http://localhost/test/fgData.json?fgid=fg0
		
		SrvUtil.dumpRequest(request, "fgData-----------");
		
		XMV xmv = new XMV();
		FgDataDemo demo = new FgDataDemo(fgid);
		demo.writeTo(xmv);
		return xmv.exe();
	}
}
