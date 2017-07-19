package prt.component.rt
{
	import flash.display.Sprite;
	
	import prt.Conf;
	import prt.component.MyLabel;
	import prt.component.MyLayout;
	
	public class MyRichTableItem extends MyLayout
	{
		public function MyRichTableItem()
		{
			super();
			this.editable = false;
			this.type = Conf.COMPONENT_RICH_TABLE_ITEM;
			this.lmode = MyLayout.LMODE_ABS;
			this.componentColor = 0xdedede;
			this.wrap = true;
			drawBound();
		}
		
		override public function paint():void
		{
			trace("MyRichTableItem::paint");
			super.paint();
		}
		
		override public function childSizeChanged():void
		{
			trace("MyRichTableItem::childSizeChanged");
			super.childSizeChanged();
		}
		
		override public function handleDs(row:Object):void
		{
			trace("MyRichTableItem::handleDs components.length="+components.length);
			for(var i:int = 0; i < components.length; i++)
			{
				components[i].handleDs(row);
			}
			paint();
		}
		
	}
}