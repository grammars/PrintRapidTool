package
{
	import com.anstu.jcommon.framework.WebAppStartup;
	import com.anstu.jui.components.JTextFormat;
	
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.system.Security;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	
	import prt.Ctx;
	import prt.ui.Res;
	
	public class PrtCli extends Sprite
	{
		public function PrtCli()
		{
			//Security.loadPolicyFile(Res.RES_ROOT+"crossdomain.xml");
			new WebAppStartup(this, __initialized);
		}
		
		private function __initialized():void
		{
			JTextFormat.forceFont = "微软雅黑";
			Ctx.initialize(this);
			
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, __keyDown);
		}
		
		private function __keyDown(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.X)
			{
				Ctx.ui.consoleFrame.showOrHide();
			}
		}
		
	}
}