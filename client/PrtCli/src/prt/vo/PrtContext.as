package prt.vo
{
	import flash.net.URLVariables;

	public class PrtContext
	{
		public var prt_domain:String;
		
		public var prt_username:String;
		
		public var prt_password:String;
		
		public var prt_folder:String;
		
		public function PrtContext()
		{
		}
		
		public function parseObj(obj:Object):void
		{
			this.prt_domain = obj.prt_domain;
			this.prt_username = obj.prt_username;
			this.prt_password = obj.prt_password;
			this.prt_folder = obj.prt_folder;
		}
		
		/** 为向服务器提交上下文信息而写入URLVariables */
		public function writeURLVariables(params:URLVariables):void
		{
			params.prt_domain = this.prt_domain;
			params.prt_username = this.prt_username;
			params.prt_password = this.prt_password;
			params.prt_folder = this.prt_folder;
		}
	}
}