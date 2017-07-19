package prt.component
{
	import com.adobe.serialization.json.JSON;
	import com.anstu.jcommon.utils.StringUtils;
	import com.anstu.jui.controls.JLabel;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import prt.Conf;
	import prt.Ctx;
	import prt.vo.table.PrtTableCol;

	public class MyTable extends MyComponent
	{
		public var cols:Vector.<PrtTableCol> = new Vector.<PrtTableCol>();
		
		private var body:Sprite;
		
		public function MyTable()
		{
			super();
			this.type = Conf.COMPONENT_TABLE;
			this.componentColor = 0xdcce2;
			this.mmw = 80;
			this.mmh = 54;
			invalidate();
		}
		
		override public function paint():void
		{
			super.paint();
		}
		
		override public function handleDs(jsonObj:Object):void
		{
			if(body && body.parent) { body.parent.removeChild(body); }
			
			body = new Sprite();
			var i:int = 0;
			var posY:int = 0;
			
			var headerStr:String = "";
			for(i = 0; i < this.cols.length; i++)
			{
				headerStr += this.cols[i].getName() + " | ";
			}
			var header:JLabel = new JLabel(headerStr);
			header.y = posY;
			body.addChild(header);
			posY += header.height + 5;
			
			for(i = 0; i < jsonObj.rows.length; i++)
			{
				var row:Object = jsonObj.rows[i];
				var rowStr:String = "";
				
				for(var j:int = 0; j < this.cols.length; j++)
				{
					var colName:String = this.cols[j].key;
					rowStr += row[colName] + " | ";
				}
				
				var rowLabel:JLabel = new JLabel(rowStr);
				rowLabel.y = posY;
				body.addChild(rowLabel);
				posY += rowLabel.height + 5;
			}
			//Ctx.ui.tableAttrBox.debug(jsonStr);
			body.x = 10;
			body.y = 20;
			this.addChild(body);
		}
		
		override public function encode(obj:Object):void
		{
			super.encode(obj);
			obj.cols = [];
			for(var i:int = 0; i < this.cols.length; i++)
			{
				obj.cols.push(this.cols[i]);
			}
		}
		
		override public function decode(obj:Object):void
		{
			super.decode(obj);
			this.cols = new Vector.<PrtTableCol>();
			if(obj.cols && obj.cols.length > 0)
			{
				for(var i:int = 0; i < obj.cols.length; i++)
				{
					var col:PrtTableCol = new PrtTableCol();
					col.decode(obj.cols[i]);
					this.cols.push(col);
				}
			}
		}
	}
}