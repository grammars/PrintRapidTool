package prt.utils;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public class SrvUtil
{
	public static void dumpRequest(HttpServletRequest request, String description)
	{
		System.out.println(description);
		for (Map.Entry<String, String[]> entry : request.getParameterMap().entrySet())
		{
			System.out.print("Key = " + entry.getKey() + "  ");
			for(String v : entry.getValue())
			{
				System.out.print(v +",");
			}
			System.out.println();
		}
	}
}
