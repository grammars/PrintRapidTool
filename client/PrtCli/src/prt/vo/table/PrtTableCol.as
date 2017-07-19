package prt.vo.table
{
	import com.anstu.jcommon.utils.StringUtils;

	public class PrtTableCol
	{
		public var key:String;
		public var name:String;
		
		public function getName():String
		{
			if(StringUtils.isEmpty(name)) { return key; }
			return name;
		}
		
		public function PrtTableCol()
		{
		}
		
		public function decode(obj:Object):void
		{
			this.key = obj.key;
			this.name = obj.name;
		}
	}
}