package prt.manager
{
	import com.adobe.serialization.json.JSON;
	
	import prt.Ctx;
	import prt.vo.ErrorCodeSupport;
	import prt.vo.PrtTask;
	import prt.vo.PrtTpl;
	import prt.vo.PrtUser;

	public class InitData extends ErrorCodeSupport
	{
		public var user:PrtUser
		public var task:PrtTask;
		public var tplList:Vector.<PrtTpl>;
		
		public function InitData()
		{
		}
		
		override public function parseObj(jsonObj:Object):void
		{
			super.parseObj(jsonObj);
			
			if(jsonObj.user)
			{
				this.user = new PrtUser();
				this.user.parseObj(jsonObj.user);
			}
			
			if(jsonObj.task)
			{
				this.task = new PrtTask();
				this.task.parseObj(jsonObj.task);
			}
			
			if(jsonObj.tplList && jsonObj.tplList.length > 0)
			{
				this.tplList = Ctx.core.parseTplList(jsonObj.tplList);
			}
			else
			{
				this.tplList = new Vector.<PrtTpl>();
			}
		}
	}
}