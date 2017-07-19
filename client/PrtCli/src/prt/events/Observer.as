package prt.events
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	[Event(name="InitDataEvent.INIT", type="prt.events.InitDataEvent")]
	[Event(name="TplEvent.LIST", type="prt.events.TplEvent")]
	[Event(name="DsEvent.LOADED", type="prt.events.DsEvent")]
	[Event(name="DebugEvent.DEBUG_MODE", type="prt.events.DebugEvent")]
	[Event(name="DebugEvent.COMPONENT_SELECT", type="prt.events.DebugEvent")]
	
	public class Observer extends EventDispatcher
	{
		public function Observer(target:IEventDispatcher=null)
		{
			super(target);
		}
	}
}