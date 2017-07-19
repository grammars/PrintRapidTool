package prt.vo.tpl
{
	public class PrtDsItem
	{
		public var name:String;
		public var api:String;
		
		public function PrtDsItem()
		{
		}
		
		public function parseObj(jsonObj:Object):void
		{
			this.name = jsonObj.name;
			this.api = jsonObj.api;
		}
	}
}