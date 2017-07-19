package prt.service;

import java.util.List;

import javakit.framework.ErrorCodeSupport;
import prt.vo.PrtContext;
import prt.vo.PrtTpl;

public interface TplService
{
	Result<List<PrtTpl>> list(PrtContext context, boolean check);

	ErrorCodeSupport save(PrtContext context, PrtTpl tpl);
	
	ErrorCodeSupport delete(PrtContext context, Integer tplId);
}
