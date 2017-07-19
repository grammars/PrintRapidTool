package prt.component
{
	import com.adobe.serialization.json.JSON;
	import com.anstu.jcommon.utils.StringUtils;
	
	import flash.display.Sprite;
	
	import prt.Conf;
	import prt.Ctx;
	import prt.component.rt.MyRichTableItem;

	public class MyRichTable extends MyLayout
	{
		public var itemJson:String;
		
		public function MyRichTable()
		{
			super();
			this.type = Conf.COMPONENT_RICH_TABLE;
			this.componentColor = 0x21ff12;
			this.mmw = 120;
			this.mmh = 60;
			this.mouseChildren = false;
			invalidate();
		}
		
		override public function paint():void
		{
			trace("MyRichTable::paint");
			super.paint();
			//Ctx.ui.paperEdit.setup(Ctx.editingTpl, null);
		}
		
		
		override public function handleDs(jsonObj:Object):void
		{
			
			trace("MyRichTable::handleDs");
			this.removeComponents();
			if(!StringUtils.isEmpty(itemJson))
			{
				trace("!StringUtils.isEmpty(itemJson) rows.length=" + jsonObj.rows.length);
				var i:int = 0;
				var posX:Number = 0;
				var posY:Number = 0;
				for(i = 0; i < jsonObj.rows.length; i++)
				{
					trace("row "+i);
					var row:Object = jsonObj.rows[i];
					var item:MyRichTableItem = Ctx.builder.decode(itemJson, false) as MyRichTableItem;
					trace("item="+item);
					this.addComponent(item, false);
					item.handleDs(row);
				}
			}
			paint();
			noticeLayoutRepaint();
		}
		
		override public function encode(obj:Object):void
		{
			super.encode(obj);
			obj.itemJson = this.itemJson;
		}
		
		override public function decode(obj:Object):void
		{
			super.decode(obj);
			this.lmode = MyLayout.LMODE_REL;
			this.wrap = true;
			this.itemJson = obj.itemJson;
		}
	}
}