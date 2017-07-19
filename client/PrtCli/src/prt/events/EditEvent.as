package prt.events
{
	import flash.events.Event;
	
	public class EditEvent extends Event
	{
		/** 控件属性改变了 */
		public static const CHANGED:String = "EditEvent.CHANGED";
		/** 控件被移除了 */
		public static const REMOVED:String = "EditEvent.REMOVED";
		
		public function EditEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}