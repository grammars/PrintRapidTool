package prt.controller;

import org.springframework.stereotype.Component;

import xfree.fb.utils.ReqCtxUtil;

@Component
public class SessionMan
{
	private static final String KEY_CID = "cid";
	/** 设置【当前公司id】 */
	public void cid(String value)
	{
		ReqCtxUtil.setSessionVal(KEY_CID, value);
	}
	/** 获取【当前公司id】 */
	public String cid()
	{
		return (String)ReqCtxUtil.getSessionVal(KEY_CID);
	}
}
