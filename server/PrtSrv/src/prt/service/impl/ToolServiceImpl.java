package prt.service.impl;

import org.springframework.stereotype.Service;

import prt.service.ToolService;

@Service
public class ToolServiceImpl implements ToolService
{

	@Override
	public String test()
	{
		return "测试服务";
	}

}
