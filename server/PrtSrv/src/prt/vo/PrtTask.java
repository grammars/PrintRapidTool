package prt.vo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

public class PrtTask extends PrtContext
{
	private int id;
	
	private String prt_segment;
	
	private List<Map<String, String[]>> reqList;
	
	public int getId()
	{
		return id;
	}

	public void setId(int id)
	{
		this.id = id;
	}
	
	public String getPrt_segment()
	{
		return prt_segment;
	}

	public void setPrt_segment(String prt_segment)
	{
		this.prt_segment = prt_segment;
	}
	
	private Map<String, String[]> params = new HashMap<>();
	
	public void putParam(String key, String[] value)
	{
		params.put(key, value);
	}

	public void digest()
	{
		reqList = new ArrayList<Map<String,String[]>>();
		if(StringUtils.isBlank(prt_segment))
		{
			reqList.add(params);
		}
		else
		{
			List<String> segments = new ArrayList<>();
			for (Map.Entry<String, String[]> entry : params.entrySet())
			{
				if(StringUtils.equals(entry.getKey(), prt_segment))
				{
					for(String seg : entry.getValue())
					{
						segments.add(seg);
					}
					break;
				}
			}
			for(String seg : segments)
			{
				Map<String, String[]> single = new HashMap<>();
				single.put(prt_segment, new String[]{seg});
				for (Map.Entry<String, String[]> entry : params.entrySet())
				{
					if(!StringUtils.equals(entry.getKey(), prt_segment))
					{
						single.put(entry.getKey(), entry.getValue());
					}
				}
				reqList.add(single);
			}
		}
		dumpReqList();
	}
	
	private void dumpReqList()
	{
		for(Map<String, String[]> single : reqList)
		{
			System.out.println("--------------------------------");
			for (Map.Entry<String, String[]> entry : single.entrySet())
			{
				System.out.print(entry.getKey()+":");
				for(String v : entry.getValue())
				{
					System.out.print(v + ",");
				}
				System.out.println();
			}
		}
	}

	public List<Map<String, String[]>> getReqList()
	{
		return reqList;
	}

	public void setReqList(List<Map<String, String[]>> reqList)
	{
		this.reqList = reqList;
	}

	
}
