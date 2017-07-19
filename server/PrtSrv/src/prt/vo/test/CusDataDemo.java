package prt.vo.test;

import xfree.fb.view.XMV;

public class CusDataDemo
{
	public void writeTo(XMV xmv)
	{
		xmv.put("errorcode", 0);
		xmv.put("errormsg", "获取客户信息成功");
		xmv.put("name", "无锡李总");
		xmv.put("code", "wx-lee");
		xmv.put("phone", "13665188666");
		xmv.put("fax", "0510-8888666");
		xmv.put("address", "无锡市南长区阳光城市花园2号");
	}
}
