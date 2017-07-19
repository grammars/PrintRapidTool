package prt.service.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javakit.framework.ErrorCodeSupport;
import prt.service.Result;
import prt.service.TplService;
import prt.service.UserService;
import prt.vo.PrtContext;
import prt.vo.PrtTpl;
import prt.vo.PrtUser;
import xfree.fb.db.DbResult;
import xfree.fb.db.DbTool;

@Service
public class TplServiceImpl implements TplService
{
	@Autowired
	UserService userService;
	
	@Override
	public Result<List<PrtTpl>> list(PrtContext context, boolean check)
	{
		String domain = context.getPrt_domain();
		String username = context.getPrt_username();
		String password = context.getPrt_password();
		String folder = context.getPrt_folder();
		Result<List<PrtTpl>> result = new Result<>();
		if(check)
		{
			Result<PrtUser> userResult = userService.get(username, password);
			if(!userResult.isSucc())
			{
				result.fail(userResult.getErrormsg());
				return result;
			}
			PrtUser user = userResult.getData();
			if(!StringUtils.equals(user.getDomain(), domain))
			{
				result.fail("不允许查询其他应用域的模版数据");
				return result;
			}
		}
		
		String conditionSql = null;
		String[] cols = null;
		Object[] vals = null;
		if(StringUtils.isBlank(folder))
		{
			conditionSql = "prt_domain=:prt_domain AND prt_username=:prt_username";
			cols = new String[]{"prt_domain", "prt_username"};
			vals = new Object[]{domain, username};
		}
		else
		{
			conditionSql = "prt_domain=:prt_domain AND prt_username=:prt_username AND prt_folder=:prt_folder";
			cols = new String[]{"prt_domain", "prt_username", "prt_folder"};
			vals = new Object[]{domain, username, folder};
		}
		
		DbResult<PrtTpl> dr = DbTool.me().querySome(PrtTpl.class, conditionSql, cols, vals,null);
		
		result.succ();
		result.setData(dr.getRows());
		return result;
	}

	@Override
	public ErrorCodeSupport save(PrtContext context, PrtTpl tpl)
	{
		//
		//记得加上鉴权，现在暂时没有判断身份
		//
		ErrorCodeSupport ec = new ErrorCodeSupport();
		
		DbResult<PrtTpl> dr = DbTool.me().querySome(PrtTpl.class, 
				"tpl_name=:tpl_name AND prt_domain=:prt_domain AND prt_username=:prt_username AND prt_folder=:prt_folder", 
				new String[]{"tpl_name","prt_domain", "prt_username", "prt_folder"}, 
				new Object[]{tpl.getTpl_name(), tpl.getPrt_domain(), tpl.getPrt_username(), tpl.getPrt_folder()}, null);
		if(dr.getRows().size() > 0)
		{
			PrtTpl old = dr.getRows().get(0);
			tpl.setId(old.getId());
			
			boolean r = DbTool.me().update(tpl);
			if(r) ec.succ("更新模版成功！"); else ec.fail("更新模版失败！");
			return ec;
		}
		
		tpl = DbTool.me().create(tpl);
		if(tpl != null)
		{
			ec.succ("新建模版成功！");
		}
		else
		{
			ec.fail("数据库保存失败！");
		}
		return ec;
	}
	
	@Override
	public ErrorCodeSupport delete(PrtContext context, Integer tplId)
	{
		ErrorCodeSupport ec = new ErrorCodeSupport();
		PrtTpl tpl = DbTool.me().read(PrtTpl.class, tplId);
		if(tpl == null)
		{
			ec.fail("你试图删除的模版不存在");
			return ec;
		}
		
		Result<PrtUser> userResult = userService.get(context.getPrt_username(), context.getPrt_password());
		if(!userResult.isSucc())
		{
			ec.fail(userResult.getErrormsg());
			return ec;
		}
		PrtUser user = userResult.getData();
		if(!StringUtils.equals(user.getDomain(), tpl.getPrt_domain()))
		{
			ec.fail("不允许操作其他应用域的模版数据");
			return ec;
		}
		
		boolean result = DbTool.me().deleteById(PrtTpl.class, tplId);
		if(result)
		{
			ec.succ("模版【" + tpl.getTpl_name() + "】已成功删除！");
		}
		else
		{
			ec.fail("数据库删除模版失败！");
		}
		return ec;
	}
}
