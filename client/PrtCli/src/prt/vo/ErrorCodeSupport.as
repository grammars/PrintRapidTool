package prt.vo
{
	public class ErrorCodeSupport
	{
		public var errorcode:int;
		public var errormsg:String;
		
		/** 成功。 */
		public static const EC_SUCC:int = 0;
		/** 失败！ */
		public static const EC_FAIL:int = -1;
		
		public function ErrorCodeSupport()
		{
		}
		
		public function isSucc():Boolean
		{
			return errorcode == EC_SUCC;
		}
		
		public function isFail():Boolean
		{
			return errorcode != EC_SUCC;
		}
		
		public function parseObj(jsonObj:Object):void
		{
			this.errorcode = jsonObj.errorcode;
			this.errormsg = jsonObj.errormsg;
		}
	}
}