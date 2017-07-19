package prt.service.impl;

import org.springframework.stereotype.Service;

import javakit.framework.ErrorCodeSupport;
import prt.service.Result;
import prt.service.UserService;
import prt.vo.PrtUser;
import xfree.fb.db.DbResult;
import xfree.fb.db.DbTool;

@Service
public class UserServiceImpl implements UserService
{
	@Override
	public Result<PrtUser> get(String username, String password)
	{
		Result<PrtUser> result = new Result<>();
		DbResult<PrtUser> dr = DbTool.me().querySome(PrtUser.class,
				"username=:username AND password=:password",
				new String[]{"username", "password"}, 
				new Object[]{username, password}, null);
		if(dr.getRows().size() > 0)
		{
			result.succ();
			result.setData(dr.getRows().get(0));
			return result;
		}
		result.fail("用户名或密码错误");
		return result;
	}
	
	@Override
	public ErrorCodeSupport updateEnv(String env, String username, String password)
	{
		ErrorCodeSupport ec = new ErrorCodeSupport();
		Result<PrtUser> userResult = get(username, password);
		if(!userResult.isSucc())
		{
			ec.fail(userResult.getErrormsg());
			return ec;
		}
		PrtUser user = userResult.getData();
		user.setEnv(env);
		boolean r = DbTool.me().update(user);
		if(r)
		{
			ec.succ("环境变量更新成功！");
		}
		else
		{
			ec.fail("数据库更新用户数据失败！");
		}
		return ec;
	}
	
	@Override
	public ErrorCodeSupport updateConfig(String config, String username, String password)
	{
		ErrorCodeSupport ec = new ErrorCodeSupport();
		Result<PrtUser> userResult = get(username, password);
		if(!userResult.isSucc())
		{
			ec.fail(userResult.getErrormsg());
			return ec;
		}
		PrtUser user = userResult.getData();
		user.setConfig(config);
		boolean r = DbTool.me().update(user);
		if(r)
		{
			ec.succ("用户配置更新成功！");
		}
		else
		{
			ec.fail("数据库更新用户配置数据失败！");
		}
		return ec;
	}
}
