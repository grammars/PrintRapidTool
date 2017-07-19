package prt.events
{
	import flash.events.Event;
	
	import prt.vo.PrtTpl;
	
	public class TplEvent extends Event
	{
		public static const LIST:String = "TplEvent.LIST";
		
		public var list:Vector.<PrtTpl>;
		
		public function TplEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}