package prt.manager
{
	import prt.Ctx;

	public class ConsoleManager
	{
		public function ConsoleManager()
		{
		}
		
		private var totolContent:String;
		
		public function log(content:String, clear:Boolean=false):void
		{
			trace(content);
			if(clear)
			{
				totolContent = content + "\r\n";
			}
			else
			{
				totolContent += content + "\r\n";
			}
			Ctx.ui.consoleFrame.write(totolContent);
		}
	}
}