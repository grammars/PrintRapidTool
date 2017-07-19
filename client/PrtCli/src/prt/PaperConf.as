package prt
{
	public class PaperConf
	{
		public var type:String;
		public var mmWidth:int;
		public var mmHeight:int;
		public var landscape:Boolean;
		
		public function PaperConf(type:String=null,mmWidth:int=0,mmHeight:int=0,landscape:Boolean=false)
		{
			this.type = type;
			this.mmWidth = mmWidth;
			this.mmHeight = mmHeight;
			this.landscape = landscape;
		}
	}
}