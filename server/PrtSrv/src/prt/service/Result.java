package prt.service;

import javakit.framework.ErrorCodeSupport;

public class Result<T> extends ErrorCodeSupport
{
	private T data;

	public T getData()
	{
		return data;
	}

	public void setData(T data)
	{
		this.data = data;
	}
	
}
