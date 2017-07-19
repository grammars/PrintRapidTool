package prt.vo
{
	import flash.utils.Dictionary;
	
	import prt.Ctx;

	public class PrtTask extends PrtContext
	{
		public var id:int;
		
		public var prt_segment:String;
		
		//List<Map<String, String[]>> reqList;
		public var reqList:Array;
		
		public function PrtTask()
		{
		}
		
		override public function parseObj(obj:Object):void
		{
			super.parseObj(obj);
			this.id = obj.id;
			this.prt_segment = obj.prt_segment;
			this.reqList = obj.reqList;
		}
		
	}
}