package prt.events
{
	import flash.events.Event;
	
	import prt.manager.InitData;
	
	public class InitDataEvent extends Event
	{
		public static const INIT:String = "InitDataEvent.INIT";
		
		public var data:InitData;
		
		public function InitDataEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}