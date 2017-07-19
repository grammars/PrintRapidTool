package prt.service;

import javakit.framework.ErrorCodeSupport;
import prt.vo.PrtUser;

public interface UserService
{
	/** 通过用户名和密码获取用户信息 */
	Result<PrtUser> get(String username, String password);
	/** 更新用户环境变量 */
	ErrorCodeSupport updateEnv(String env, String username, String password);
	/** 更新用户配置 */
	ErrorCodeSupport updateConfig(String config, String username, String password);
}
