package prt.component
{
	import prt.Conf;

	public class MyRect extends MyComponent
	{	
		protected var _thickness:Number = 0.25;
		public function set thickness(value:Number):void
		{
			this._thickness = value;
			invalidate();
		}
		public function get thickness():Number
		{
			return this._thickness;
		}
		
		public function MyRect()
		{
			super();
			this.type = Conf.COMPONENT_RECT;
			this.componentColor = 0xff2332;
			this.mmw = 21;
			this.mmh = 7;
			invalidate();
		}
		
		override public function paint():void
		{
			super.paint();
		}
		
		override protected function drawBound():void
		{
			this.graphics.clear();
			this.graphics.lineStyle(Conf.mm2px(thickness), 0x0);
			this.graphics.beginFill(0x0, 0);
			this.graphics.drawRect(Conf.mm2px(thickness/2), Conf.mm2px(thickness/2), Conf.mm2px(mmw-thickness), Conf.mm2px(mmh-thickness));
			this.graphics.endFill();
		}
		
		override public function encode(obj:Object):void
		{
			super.encode(obj);
			obj.thickness = this.thickness;
		}
		
		override public function decode(obj:Object):void
		{
			super.decode(obj);
			this.thickness = obj.thickness;
		}
	}
}