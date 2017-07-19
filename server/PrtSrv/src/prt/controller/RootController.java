package prt.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javakit.framework.ErrorCodeSupport;
import prt.service.TaskService;
import prt.service.Result;
import prt.service.ToolService;
import prt.service.TplService;
import prt.service.UserService;
import prt.utils.SrvUtil;
import prt.vo.PrtTask;
import prt.vo.PrtTpl;
import prt.vo.PrtUser;
import xfree.fb.view.XMV;

@Controller
@RequestMapping("/")
public class RootController
{
	@Autowired
	ToolService toolService;
	@Autowired
	TaskService taskService;
	@Autowired
	UserService userService;
	@Autowired
	TplService tplService;
	
	/** 欢迎页 */
	@RequestMapping("index.page")
	public ModelAndView index_page()
	{
		// http://localhost/
		XMV xmv = new XMV("page/index");
		return xmv.exe();
	}
	
	/** 启动一个打印任务 */
	@RequestMapping("task.page")
	public ModelAndView task_page(PrtTask task, HttpServletRequest request)
	{
		// http://localhost/task.page
		XMV xmv = new XMV("page/task");
		for (Map.Entry<String, String[]> entry : request.getParameterMap().entrySet())
		{
			System.out.println("Key = " + entry.getKey() + ", value = " + entry.getValue());
			task.putParam(entry.getKey(), entry.getValue());
		}
		task.digest();
		task = taskService.addTask(task);
		xmv.put("taskId", task.getId());
		return xmv.exe();
	}
	
	
	/** 初始化渲染数据 */
	@RequestMapping("initData.json")
	public ModelAndView renderInitData(@RequestParam(value="taskId")Integer taskId, HttpServletRequest request)
	{
		// http://localhost/initData.json?taskId=1
		SrvUtil.dumpRequest(request, "initData.json-----------");
		
		XMV xmv = new XMV();
		PrtTask task = taskService.getTask(taskId);
		if(task == null)
		{
			xmv.ec(ErrorCodeSupport.EC_FAIL, "未找到该任务,任务号："+taskId);
			return xmv.exe();
		}
		Result<PrtUser> userResult = userService.get(task.getPrt_username(), task.getPrt_password());
		Result<List<PrtTpl>> tplListResult = tplService.list(task, true);
		xmv.put("task", task);
		xmv.put("user", userResult.getData());
		xmv.put("tplList", tplListResult.getData());
		xmv.ec(userResult);
		return xmv.exe();
	}
	
	
//	/** 退出登录 */
//	@RequestMapping("logout.page")
//	public ModelAndView logout_page()
//	{
//		// http://localhost/logout.page
//		ReqCtxUtil.dispose();
//		return XMV.redirect("user/public/login.page").exeRaw();
//	}
}
