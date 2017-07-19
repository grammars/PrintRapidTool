package prt.events
{
	import flash.events.Event;
	
	public class DsEvent extends Event
	{
		public static const LOADED:String = "DsEvent.LOADED";
		
		public var ancestor:int;
		public var dsName:String;
		public var jsonObj:Object;
		
		public function DsEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}