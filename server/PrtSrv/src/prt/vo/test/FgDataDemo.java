package prt.vo.test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import xfree.fb.view.XMV;

public class FgDataDemo
{
	private String fgid;
	/** 错误码 */
	private int errorcode;
	/** 错误信息 */
	private String errormsg;
	/** 数据 */
	private List<Map<String, Object>> rows;
	
	public int getErrorcode()
	{
		return errorcode;
	}

	public void setErrorcode(int errorcode)
	{
		this.errorcode = errorcode;
	}

	public String getErrormsg()
	{
		return errormsg;
	}

	public void setErrormsg(String errormsg)
	{
		this.errormsg = errormsg;
	}

	public List<Map<String, Object>> getRows()
	{
		return rows;
	}

	public void setRows(List<Map<String, Object>> rows)
	{
		this.rows = rows;
	}

	
	public FgDataDemo(String fgid)
	{
		this.fgid = fgid;
		this.errorcode = 0;
		this.errormsg = "请求数据成功";
		Map<String, Object> row = null;
		rows = new ArrayList<>();
		
		String img0 = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1489943521748&di=5cbb013e547adf4a6f44ad70e53b6c8a&imgtype=0&src=http%3A%2F%2Fwww.2ok.com.cn%2Fproductpic%2Fgyjdhm%2Fpic_201510141747364636.jpg";
		String img1 = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1489943513234&di=db7659557fb5e15e6839cd42606da8c8&imgtype=0&src=http%3A%2F%2Fwww.yw020.com%2Ffile%2Fupload%2F201511%2F06%2F15-09-31-13-1250.png";
		String img2 = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1489943507491&di=fd88d14e46811c8572bfc993f91bed4f&imgtype=0&src=http%3A%2F%2Fimg.jdzj.com%2FUserDocument%2F2015a%2Fjmlongfb%2FPicture%2F2015420173318.jpg";
		
		row = createRow("20170319-10", "F9中空门", "欧式A1", "太空铝", "银白色", 19, 1, 1200.13f, 3624.50f, 3.08f, 2400, 2080, 56, ""+img0, "清明之前必须好");
		rows.add(row);
		row = createRow("20170320-11", "A3衣柜门", "美式C8", "橡胶木", "乳白色", 20, 2, 3070.00f, 6140.00f, 2.00f, 2200, 2120, 44, ""+img1, "隔壁老王介绍的");
		rows.add(row);
		row = createRow("20170321-27", "X6艳照门", "中式K5", "樱桃木", "朱红色", 22, 1, 1200.13f, 3624.50f, 3.08f, 1800, 2400, 86, ""+img2, "纱网要坚固");
		rows.add(row);
	}
	
	private Map<String, Object> createRow(String orderId, String name, String style, String material, String color,
			Integer diaojiao, Integer quantity, 
			Float price, Float totalPrice, Float area, 
			Integer width, Integer height, Integer thickness, String img, String description)
	{
		Map<String, Object> row = new HashMap<String, Object>();
		row.put("orderId", orderId);
		row.put("name", name);
		row.put("style", style);
		row.put("material", material);
		row.put("color", color);
		row.put("diaojiao", diaojiao);
		row.put("quantity", quantity);
		row.put("price", price);
		row.put("totalPrice", totalPrice);
		row.put("area", area);
		row.put("width", width);
		row.put("height", height);
		row.put("thickness", thickness);
		row.put("img", img);
		row.put("description", description);
		return row;
	}
	
	public void writeTo(XMV xmv)
	{
		xmv.put("errorcode", errorcode);
		xmv.put("errormsg", errormsg);
		xmv.put("fgid", fgid);
		xmv.put("rows", rows);
	}
}
