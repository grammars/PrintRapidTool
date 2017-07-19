package prt.vo;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="user")
public class PrtUser
{
	@Id
	@Column(name="id", unique=true)
	private Integer id;
	
	@Column(name="username", length=32)
	private String username;
	
	@Column(name="password", length=32)
	private String password;
	
	@Column(name="nickname", length=32)
	private String nickname;
	
	@Column(name="domain", length=16)
	private String domain;

	@Column(name="env")
	private String env;
	
	@Column(name="config")
	private String config;

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public String getUsername()
	{
		return username;
	}

	public void setUsername(String username)
	{
		this.username = username;
	}

	public String getPassword()
	{
		return password;
	}

	public void setPassword(String password)
	{
		this.password = password;
	}

	public String getNickname()
	{
		return nickname;
	}

	public void setNickname(String nickname)
	{
		this.nickname = nickname;
	}
	
	public String getDomain()
	{
		return domain;
	}

	public void setDomain(String domain)
	{
		this.domain = domain;
	}

	public String getEnv()
	{
		return env;
	}

	public void setEnv(String env)
	{
		this.env = env;
	}
	
	public String getConfig()
	{
		return config;
	}

	public void setConfig(String config)
	{
		this.config = config;
	}
	
}
