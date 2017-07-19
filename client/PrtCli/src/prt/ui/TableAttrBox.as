package prt.ui
{	
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.JInputText;
	import com.anstu.jui.controls.JPanel;
	import com.anstu.jui.controls.JPushButton;
	import com.anstu.jui.controls.JScrollPanel;
	import com.anstu.jui.controls.JTextArea;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	
	import prt.Ctx;
	import prt.component.MyTable;
	import prt.vo.table.PrtTableCol;
	
	public class TableAttrBox extends ViewWnd
	{
		private var target:MyTable;
		
		private var dsNameInput:JInputText;
		private var applyBtn:JPushButton;
		private var colSetScroll:JScrollPanel;
		private var colSetBtn:JPushButton;
		private var colSetPanel:JPanel;
		private var colKeyInput:JInputText;
		private var colNameInput:JInputText;
		private var addColBtn:JPushButton;
		private var cancelAddColBtn:JPushButton;
		private var closeBtn:JPushButton;
		
		private var colPosY:int = 0;
		
		public function TableAttrBox()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("TableAttrBox");
			pane = uiPack.getCtrl("root");
			
			dsNameInput = uiPack.getInputText("dsNameInput");
			applyBtn = uiPack.getPushButton("applyBtn");
			colSetScroll = uiPack.getScrollPanel("colSetScroll");
			colSetBtn = uiPack.getPushButton("colSetBtn");
			colSetPanel = uiPack.getPanel("colSetPanel");
			colKeyInput = uiPack.getInputText("colKeyInput");
			colNameInput = uiPack.getInputText("colNameInput");
			addColBtn = uiPack.getPushButton("addColBtn");
			cancelAddColBtn = uiPack.getPushButton("cancelAddColBtn");
			closeBtn = uiPack.getPushButton("closeBtn");
			
			canBringTop(true);
			canDrag(true);
			
			colSetPanel.visible = false;
			colSetBtn.addEventListener(MouseEvent.CLICK, __colSetBtn);
			addColBtn.addEventListener(MouseEvent.CLICK, __addColBtn);
			cancelAddColBtn.addEventListener(MouseEvent.CLICK, __cancelAddColBtn);
			applyBtn.addEventListener(MouseEvent.CLICK, __applyBtn);
			closeBtn.addEventListener(MouseEvent.CLICK, __closeBtn);
		}
		
		/** 放到默认位置 */
		override public function putDefaultPos(event:Event=null):void
		{
			if(pane)
			{
				pane.x = 0;
				pane.y = (Ctx.stage.stageHeight - pane.height);
			}
		}
		
		private function __applyBtn(e:MouseEvent):void
		{
			this.target.dsName = dsNameInput.text;
			if(Ctx.task.reqList.length > 0)
			{
				this.target.requestParam = Ctx.task.reqList[0];
			}
			else
			{
				this.target.requestParam = new Object();
			}
			
			this.target.paint();
		}
		
		private function __closeBtn(e:MouseEvent):void
		{
			this.hide();
		}
		
		private function __colSetBtn(e:MouseEvent):void
		{
			colSetPanel.visible = true;
		}
		
		private function __addColBtn(e:MouseEvent):void
		{
			var data:PrtTableCol = new PrtTableCol();
			data.key = colKeyInput.text;
			data.name = colNameInput.text;
			this.target.cols.push(data);
			addColLine(data);
			colSetPanel.visible = false;
		}
		
		private function __cancelAddColBtn(e:MouseEvent):void
		{
			colSetPanel.visible = false;
		}
		
		private function addColLine(data:PrtTableCol):void
		{
			var cl:TableColLine = new TableColLine(this);
			cl.setup(data);
			cl.pane.x = 0;
			cl.pane.y = colPosY;
			colSetScroll.addChild(cl.pane);
			colPosY += cl.pane.height;
		}
		
		public function removeCol(cl:TableColLine):void
		{
			for(var i:int = 0; i < this.target.cols.length; i++)
			{
				if(this.target.cols[i] == cl.data)
				{
					this.target.cols.splice(i, 1);
					break;
				}
			}
			presentCols();
		}
		
		public function moveCol(cl:TableColLine, forward:Boolean):void
		{
			if(this.target.cols.length <= 1) { return; }
			var tarInd:int = 0;
			for(var i:int = 0; i < this.target.cols.length; i++)
			{
				if(this.target.cols[i] == cl.data)
				{
					this.target.cols.splice(i, 1);
					tarInd = i;
					break;
				}
			}
			var insertInd:int = forward ? tarInd-1 : tarInd+1;
			this.target.cols.splice(insertInd, 0, cl.data);
			presentCols();
		}
		
		public function enter(c:MyTable):void
		{
			this.target = c;
			dsNameInput.text = this.target.dsName;
			presentCols();
			show();
		}
		
		private function presentCols():void
		{
			colPosY = 0;
			colSetScroll.clearContent();
			for(var i:int = 0; i < this.target.cols.length; i++)
			{
				addColLine(this.target.cols[i]);
			}
		}
		
	}
}