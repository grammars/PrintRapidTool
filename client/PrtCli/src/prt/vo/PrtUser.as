package prt.vo
{
	import com.adobe.serialization.json.JSON;
	import com.anstu.jcommon.utils.StringUtils;
	
	import prt.vo.user.PrtEnvItem;
	import prt.vo.user.PrtUserConfig;

	public class PrtUser
	{
		public var id:int;
		public var username:String;
		public var password:String;
		public var nickname:String;
		public var domain:String;
		public var env:String;
		public var config:String;
		
		public var envItems:Vector.<PrtEnvItem>;
		public var cfg:PrtUserConfig;
		
		public function PrtUser()
		{
		}
		
		public function parseObj(obj:Object):void
		{
			this.id = obj.id;
			this.username = obj.username;
			this.password = obj.password;
			this.nickname = obj.nickname;
			this.domain = obj.domain;
			this.env = obj.env;
			this.config = obj.config;
			
			envItems = new Vector.<PrtEnvItem>();
			if(!StringUtils.isEmpty(this.env))
			{
				var envStr:String = this.env as String;
				var arr:Array = envStr.split("卍");
				for(var i:int = 0; i < arr.length; i++)
				{
					var pairArr:Array = (arr[i] as String).split("╋");
					var ei:PrtEnvItem = new PrtEnvItem();
					ei.key = pairArr[0];
					ei.value = pairArr[1];
					envItems.push(ei);
				}
			}
			
			cfg = new PrtUserConfig();
			if(StringUtils.isEmpty(this.config))
			{
				//
			}
			else
			{
				var configJsonObj:Object = com.adobe.serialization.json.JSON.decode(this.config);
				cfg.X = configJsonObj.X;
			}
		}
		
		public function encode():void
		{
			env = "";
			for(var i:int = 0; i < envItems.length; i++)
			{
				var ei:PrtEnvItem = envItems[i];
				if(i != 0)
				{
					env += "卍";
				}
				env += ei.key + "╋" + ei.value;
			}
			
			config = com.adobe.serialization.json.JSON.encode(cfg);
		}
		
		public function toString():String
		{
			return "[PrtUser]id:"+id+",username:"+username+",password:"+password+",nickname:"+nickname+",domain:"+domain+",env:"+env;
		}
	}
}