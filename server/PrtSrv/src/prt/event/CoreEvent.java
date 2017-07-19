package prt.event;

import javakit.events.Event;

public class CoreEvent extends Event
{
	/** 管理员成功登陆 */
	public static final String ADMIN_LOGIN = "ADMIN_LOGIN";

	public CoreEvent(String type)
	{
		super(type);
	}

}
