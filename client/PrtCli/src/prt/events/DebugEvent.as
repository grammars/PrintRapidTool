package prt.events
{
	import flash.events.Event;
	
	import prt.component.MyComponent;
	
	public class DebugEvent extends Event
	{
		public static const DEBUG_MODE:String = "DebugEvent.DEBUG_MODE";
		public static const COMPONENT_SELECT:String = "DebugEvent.COMPONENT_SELECT";
		
		public static var isDebug:Boolean = true;
		
		public var component:MyComponent = null;
		
		public function DebugEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}