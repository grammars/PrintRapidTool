package prt;

import java.io.InputStream;

import com.google.gson.Gson;

import javakit.file.FileLoader;

public class PrtSrvConfig
{
	public String msid;
	public String sysLoginSecret;
	public String centralHost;
	public String centralServlet;
	public String centralSrvSysLoginSecret;
	public String version;
	
	/** 加载PrtSrvConfig服务器配置 */
	public void load()
	{
		InputStream ips = X.getServletContext().getResourceAsStream("/WEB-INF/PrtSrvConfig.json");
		FileLoader fl = new FileLoader();
		String json = fl.loadText(ips, "UTF-8");
		Config conf = new Gson().fromJson(json, Config.class);
		this.msid = conf.msid;
		this.sysLoginSecret = conf.sysLoginSecret;
		this.centralHost = conf.centralHost;
		this.centralServlet = conf.centralServlet;
		this.centralSrvSysLoginSecret = conf.centralSrvSysLoginSecret;
		this.version = conf.version;
	}
	
	@Override
	public String toString()
	{
		return String.format("PrtSrvConfig{msid=%s, sysLoginSecret=%s, centralHost=%s, centralServlet=%s, centralSrvSysLoginSecret=%s, version=%s}", 
				msid, sysLoginSecret, centralHost, centralServlet, centralSrvSysLoginSecret, version);
	}
	
	@SuppressWarnings("unused")
	private static class Config
	{
		private String msid;
		private String sysLoginSecret;
		private String centralHost;
		private String centralServlet;
		private String centralSrvSysLoginSecret;

		private String version;
		
		public String getMsid()
		{
			return msid;
		}

		public void setMsid(String msid)
		{
			this.msid = msid;
		}
		
		public String getSysLoginSecret()
		{
			return sysLoginSecret;
		}

		public void setSysLoginSecret(String sysLoginSecret)
		{
			this.sysLoginSecret = sysLoginSecret;
		}
		
		public String getCentralHost()
		{
			return centralHost;
		}

		public void setCentralHost(String centralHost)
		{
			this.centralHost = centralHost;
		}
		
		public String getCentralServlet()
		{
			return centralServlet;
		}

		public void setCentralServlet(String centralServlet)
		{
			this.centralServlet = centralServlet;
		}
		
		public String getCentralSrvSysLoginSecret()
		{
			return centralSrvSysLoginSecret;
		}

		public void setCentralSrvSysLoginSecret(String centralSrvSysLoginSecret)
		{
			this.centralSrvSysLoginSecret = centralSrvSysLoginSecret;
		}

		public String getVersion()
		{
			return version;
		}

		public void setVersion(String version)
		{
			this.version = version;
		}
	}
}
