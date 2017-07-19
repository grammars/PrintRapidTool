package prt.ui
{	
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.build.doc.UIPack;
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.controls.JPushButton;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import prt.Ctx;
	
	public class ViewWnd
	{
		/** ui包 */
		protected var uiPack:UIPack;
		/** 根面板 */
		public var pane:JComponent;
		/** 所属layer层 */
		public var layer:Sprite;
		
		public function ViewWnd()
		{
			layer = Ctx.ui;
			init();
			putDefaultPos();
			Ctx.stage.addEventListener(Event.RESIZE, putDefaultPos);
		}
		
		/** 初始化控件 */
		protected function init():void
		{
			uiPack = JFactory.create("docName");
			pane = uiPack.getCtrl("paneTag");
		}
		
		/** 显示 */
		public function show():void
		{
			if(pane) { layer.addChild(pane); }
		}
		
		/** 隐藏 */
		public function hide():void
		{
			if(pane && pane.parent) { pane.parent.removeChild(pane); }
		}
		
		/** 显示/隐藏 */
		public function showOrHide():void
		{
			if(pane && pane.parent) { hide(); }
			else { show(); }
		}
		
		/** 放到默认位置 */
		public function putDefaultPos(event:Event=null):void
		{
		}
		
		/** 摆放位置到舞台中央 */
		public function putCentre():void
		{
			if(pane)
			{
				pane.x = (Ctx.stage.stageWidth - pane.width) / 2;
				pane.y = (Ctx.stage.stageHeight - pane.height) / 2;
			}
		}
		
		/** 摆放到当前层的最前面 */
		public function putTop():void
		{
			if(pane) { this.layer.addChild(pane); }
		}
		
		/** 是否支持窗体拖拽 */
		public function canDrag(value:Boolean):void
		{
			if(value==true)
			{
				if(pane)
				{
					pane.addEventListener(MouseEvent.MOUSE_DOWN, __wndDragBeg);
					pane.addEventListener(MouseEvent.MOUSE_UP, __wndDragEnd);
				}
			}
			else
			{
				if(pane)
				{
					pane.removeEventListener(MouseEvent.MOUSE_DOWN, __wndDragBeg);
					pane.removeEventListener(MouseEvent.MOUSE_UP, __wndDragEnd);
				}
			}
		}
		
		/** 窗体开始拖拽 */
		protected function __wndDragBeg(e:MouseEvent):void
		{
			if(pane)
			{
				if(e.target is JPushButton)
				{
					return;
				}
				pane.startDrag();
			}
		}
		
		/** 窗体结束拖拽 */
		protected function __wndDragEnd(e:MouseEvent):void
		{
			if(pane) { pane.stopDrag(); }
		}
		
		/** 窗体点击到最前面 */
		public function canBringTop(value:Boolean):void
		{
			if(value==true)
			{
				if(pane) { pane.addEventListener(MouseEvent.MOUSE_DOWN, __bringTop); }
			}
			else
			{
				if(pane) { pane.removeEventListener(MouseEvent.MOUSE_DOWN, __bringTop); }
			}
		}
		
		/** 带到当前层最前面 */
		protected function __bringTop(e:MouseEvent):void
		{
			putTop();
		}
		
		public function set x(value:Number):void { pane.x = value; }
		public function get x():Number { return pane.x; }
		
		public function set y(value:Number):void { pane.y = value; }
		public function get y():Number { return pane.y; }
		
		public function set width(value:Number):void { pane.width = value; }
		public function get width():Number { return pane.width; }
		
		public function set height(value:Number):void { pane.height = value; }
		public function get height():Number { return pane.height; }
		
		public function addTo(parent:DisplayObjectContainer):void
		{
			parent.addChild(pane);
		}
	}
}