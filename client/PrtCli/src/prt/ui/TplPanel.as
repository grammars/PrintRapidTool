package prt.ui
{
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.JPushButton;
	import com.anstu.jui.controls.JScrollPanel;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import prt.Ctx;
	import prt.events.InitDataEvent;
	import prt.events.TplEvent;
	import prt.manager.InitData;
	import prt.vo.PrtTpl;

	public class TplPanel extends ViewWnd
	{
		private var closeBtn:JPushButton;
		private var addBtn:JPushButton;
		private var listCtn:JScrollPanel;
		private var printBtn:JPushButton;
		
		/** 打印模版面板 */
		public function TplPanel()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("TplPanel");
			pane = uiPack.getCtrl("root");
			
			closeBtn = uiPack.getPushButton("closeBtn");
			addBtn = uiPack.getPushButton("addBtn");
			listCtn = uiPack.getScrollPanel("listCtn");
			listCtn.autoHideScrollBar = true;
			printBtn = uiPack.getPushButton("printBtn");
			
			canDrag(true);
			canBringTop(true);
			
			closeBtn.addEventListener(MouseEvent.CLICK, __closeBtn);
			addBtn.addEventListener(MouseEvent.CLICK, __addBtn);
			printBtn.addEventListener(MouseEvent.CLICK, __printBtn);
			
			Ctx.observer.addEventListener(InitDataEvent.INIT, initDataHandler);
			Ctx.observer.addEventListener(TplEvent.LIST, tplListHandler);
		}
		
		/** 放到默认位置 */
		override public function putDefaultPos(event:Event=null):void
		{
			if(pane)
			{
				pane.x = 0;
				pane.y = (Ctx.stage.stageHeight - pane.height) / 2;
			}
		}
		
		private function initDataHandler(e:InitDataEvent):void
		{
			setup(e.data.tplList);
		}
		
		private function tplListHandler(e:TplEvent):void
		{
			setup(e.list);
		}
		
		private function __closeBtn(e:MouseEvent):void { hide(); }
		
		private function __addBtn(e:MouseEvent):void
		{
			Ctx.ui.addTplDialog.show();
		}
		
		private function __printBtn(e:MouseEvent):void
		{
			Ctx.render.executePrint();
		}
		
		private function setup(tplList:Vector.<PrtTpl>):void
		{
			listCtn.clearContent();
			for(var i:int = 0; i < tplList.length; i++)
			{
				var card:TplCard = new TplCard();
				card.setup(tplList[i]);
				card.x = 10;
				card.y = (card.height+10) * i + 10;
				card.addTo(listCtn);
			}
		}
	}
}