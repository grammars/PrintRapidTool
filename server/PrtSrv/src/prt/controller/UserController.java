package prt.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javakit.framework.ErrorCodeSupport;
import prt.service.UserService;
import prt.utils.SrvUtil;
import xfree.fb.view.XMV;

@Controller
@RequestMapping("/user/")
public class UserController
{
	@Autowired
	UserService userService;
	
	/** 更新用户环境变量 */
	@RequestMapping("updateEnv.json")
	public ModelAndView updateEnv(@RequestParam(value="env")String env, 
			@RequestParam(value="username")String username, @RequestParam(value="password")String password,
			HttpServletRequest request)
	{
		// http://localhost/user/updateEnv.json?
		SrvUtil.dumpRequest(request, "user/updateEnv.json-----------");
		ErrorCodeSupport result = userService.updateEnv(env, username, password);
		XMV xmv = new XMV();
		xmv.ec(result);
		return xmv.exe();
	}
	
	/** 更新用户配置 */
	@RequestMapping("updateConfig.json")
	public ModelAndView updateConfig(@RequestParam(value="config")String config, 
			@RequestParam(value="username")String username, @RequestParam(value="password")String password,
			HttpServletRequest request)
	{
		// http://localhost/user/updateConfig.json?
		SrvUtil.dumpRequest(request, "user/updateConfig.json-----------");
		ErrorCodeSupport result = userService.updateConfig(config, username, password);
		XMV xmv = new XMV();
		xmv.ec(result);
		return xmv.exe();
	}
}
