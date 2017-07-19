package prt.vo;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="tpl")
public class PrtTpl
{
	@Id
	@Column(name="id", unique=true)
	private Integer id;
	
	@Column(name="tpl_name", length=32)
	private String tpl_name;

	@Column(name="prt_domain", length=16)
	private String prt_domain;
	
	@Column(name="prt_username", length=32)
	private String prt_username;
	
	@Column(name="prt_folder", length=32)
	private String prt_folder;

	@Column(name="paper_type", length=32)
	private String paper_type;
	
	@Column(name="paper_mmWidth")
	private Integer paper_mmWidth;
	
	@Column(name="paper_mmHeight")
	private Integer paper_mmHeight;
	
	@Column(name="paper_landscape")
	private Boolean paper_landscape;
	
	@Column(name="componentsJson")
	private String componentsJson;
	
	@Column(name="dsJson")
	private String dsJson;

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}
	
	public String getTpl_name()
	{
		return tpl_name;
	}

	public void setTpl_name(String tpl_name)
	{
		this.tpl_name = tpl_name;
	}

	public String getPrt_domain()
	{
		return prt_domain;
	}

	public void setPrt_domain(String prt_domain)
	{
		this.prt_domain = prt_domain;
	}

	public String getPrt_username()
	{
		return prt_username;
	}

	public void setPrt_username(String prt_username)
	{
		this.prt_username = prt_username;
	}
	
	public String getPrt_folder()
	{
		return prt_folder;
	}

	public void setPrt_folder(String prt_folder)
	{
		this.prt_folder = prt_folder;
	}

	public String getPaper_type()
	{
		return paper_type;
	}

	public void setPaper_type(String paper_type)
	{
		this.paper_type = paper_type;
	}

	public Integer getPaper_mmWidth()
	{
		return paper_mmWidth;
	}

	public void setPaper_mmWidth(Integer paper_mmWidth)
	{
		this.paper_mmWidth = paper_mmWidth;
	}

	public Integer getPaper_mmHeight()
	{
		return paper_mmHeight;
	}

	public void setPaper_mmHeight(Integer paper_mmHeight)
	{
		this.paper_mmHeight = paper_mmHeight;
	}

	public Boolean getPaper_landscape()
	{
		return paper_landscape;
	}

	public void setPaper_landscape(Boolean paper_landscape)
	{
		this.paper_landscape = paper_landscape;
	}

	public String getComponentsJson()
	{
		return componentsJson;
	}

	public void setComponentsJson(String componentsJson)
	{
		this.componentsJson = componentsJson;
	}
	
	public String getDsJson()
	{
		return dsJson;
	}

	public void setDsJson(String dsJson)
	{
		this.dsJson = dsJson;
	}
}
