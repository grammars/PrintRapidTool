package xfree.fb.db;

public class DbPage
{
	private int page = 0;
	private int rows = 0;

	public int getPage()
	{
		return page;
	}

	public void setPage(int page)
	{
		this.page = page;
	}

	public int getRows()
	{
		return rows;
	}

	public void setRows(int rows)
	{
		this.rows = rows;
	}

	/** 输出MySql的limit片段 */
	public String toLimitSql()
	{
		int begInd = (page - 1) * rows;
		if (begInd < 0)
		{
			begInd = 0;
		}
		// int endInd = begInd + rows;
		return " LIMIT " + begInd + "," + rows + " ";
	}

	public boolean available()
	{
		if(rows <= 0) return false;
		if(page <= 0) return false;
		return true;
	}
}
