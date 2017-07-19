package prt.ui
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import prt.Ctx;

	public class Masker
	{
		private static var _sp:Sprite;
		private static function get sp():Sprite
		{
			if(_sp == null)
			{
				_sp = new Sprite();
				repaint();
				Ctx.stage.addEventListener(Event.RESIZE, __resize);
			}
			return _sp;
		}
		
		private static function __resize(e:Event):void
		{
			repaint();
		}
		
		private static function repaint():void
		{
			_sp.graphics.clear();
			_sp.graphics.beginFill(0x0, 0.9);
			_sp.graphics.drawRect(0, 0, Ctx.stage.stageWidth, Ctx.stage.stageHeight);
			_sp.graphics.endFill();
		}
		
		public function Masker()
		{
		}
		
		public static function show():void
		{
			Ctx.stage.addChild(sp);
		}
		
		public static function hide():void
		{
			if(sp.parent) { sp.parent.removeChild(sp); }
		}
		
		public static function addChild(dis:DisplayObject):void
		{
			sp.addChild(dis);
		}
	}
}