package prt.component
{
	import com.anstu.jcommon.utils.StringUtils;
	import com.anstu.jui.controls.JLabel;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import prt.Conf;
	import prt.Ctx;
	import prt.events.DebugEvent;
	import prt.events.DsEvent;
	import prt.events.EditEvent;
	
	public class MyComponent extends Sprite
	{
		public var ancestor:int = 0;
		
		public var editable:Boolean = true;
		private var selected:Boolean = false;
		
		public var type:String;
		
		public var layout:MyLayout;
		
		protected var _isLayout:Boolean = false;
		public function get isLayout():Boolean
		{
			return _isLayout;
		}
		
		/** 释放改变事件 */
		protected function dispatchChangedEvent():void
		{
			var event:EditEvent = new EditEvent(EditEvent.CHANGED);
			this.dispatchEvent(event);
		}
		/** 释放移除事件 */
		protected function dispatchRemovedEvent():void
		{
			var event:EditEvent = new EditEvent(EditEvent.REMOVED);
			this.dispatchEvent(event);
		}
		
		protected var _mmw:Number = 64;
		public function set mmw(value:Number):void
		{
			this._mmw = value;
			invalidate();
		}
		public function get mmw():Number
		{
			return this._mmw;
		}
		
		protected var _mmh:Number = 32;
		public function set mmh(value:Number):void
		{
			this._mmh = value;
			invalidate();
		}
		public function get mmh():Number
		{
			return this._mmh;
		}
		
		protected var _mmx:Number = 0;
		public function set mmx(value:Number):void
		{
			if(value != _mmx)
			{
				//trace(this.type+",mmx="+_mmx + ", value="+value);
				_mmx = value;
				this.x = Conf.mm2px(_mmx);
				noticeLayoutRepaint();
				dispatchChangedEvent();
			}
		}
		public function get mmx():Number
		{
			return _mmx;
		}
		
		protected var _mmy:Number = 0;
		public function set mmy(value:Number):void
		{
			if(value != _mmy)
			{
				_mmy = value;
				this.y = Conf.mm2px(_mmy);
				noticeLayoutRepaint();
				dispatchChangedEvent();
			}
		}
		public function get mmy():Number
		{
			return _mmy;
		}
		
		protected var _borderWidth:Number = 0.25;
		public function set borderWidth(value:Number):void
		{
			this._borderWidth = value;
			invalidate();
		}
		public function get borderWidth():Number
		{
			return this._borderWidth;
		}
		
		protected var _borderColor:uint;
		public function set borderColor(value:uint):void
		{
			this._borderColor = value;
			invalidate();
		}
		public function get borderColor():uint
		{
			return this._borderColor;
		}
		
		protected var componentColor:uint = 0x0;
		private var typeLabel:JLabel;
		
		public var requestParam:Object;
		
		/** 该组件所使用的数据源 */
		public var dsName:String;
		
		public function MyComponent()
		{
			super();
			this.addEventListener(MouseEvent.CLICK, __click);
			this.addEventListener(MouseEvent.MOUSE_DOWN, __dragBeg);
			this.addEventListener(MouseEvent.MOUSE_UP, __dragEnd);
			
			Ctx.observer.addEventListener(DsEvent.LOADED, dsLoadedHandler);
			Ctx.observer.addEventListener(DebugEvent.DEBUG_MODE, debugModeHandler);
			Ctx.observer.addEventListener(DebugEvent.COMPONENT_SELECT, componentSelectHandler);
		}
		
		/** 使失效，申请重绘  */
		protected function invalidate():void
		{
			addEventListener(Event.ENTER_FRAME, onInvalidate);
		}
		
		private function dsLoadedHandler(e:DsEvent):void
		{
			if(this.ancestor == e.ancestor && this.dsName == e.dsName)
			{
				handleDs(e.jsonObj);
			}
		}
		
		private function debugModeHandler(e:DebugEvent):void
		{
			showTypeLabel();
			drawBound();
		}
		
		private function componentSelectHandler(e:DebugEvent):void
		{
			if(!this.editable) { return; }
			if(this == e.component)
			{
				this.selected = true;				
				drawBound();
			}
			else
			{
				this.selected = false;	
				drawBound();
			}
		}
		
		public function handleDs(jsonObj:Object):void
		{
			//override
		}
		
		/** 重绘帧事件 */
		protected function onInvalidate(event:Event):void
		{
			paint();
		}
		
		protected function showTypeLabel():void
		{
			if(typeLabel && typeLabel.parent) { typeLabel.parent.removeChild(typeLabel); }
			if(!DebugEvent.isDebug) { return; }
			typeLabel = new JLabel(Ctx.builder.getComponentName(this.type));
			typeLabel.bmpMode = true;
			typeLabel.mouseEnabled = typeLabel.mouseChildren = false;
			typeLabel.textFormat.color = this.componentColor;
			typeLabel.textFormat.size = 12;
			typeLabel.width = 32;
			typeLabel.height = 12;
			//typeLabel.useStroke = true;
			//typeLabel.x = 0;
			//typeLabel.y = -typeLabel.height;
			this.addChild(typeLabel);
		}
		
		private function __click(e:MouseEvent):void
		{
			if(editable)
			{
				if(this.type != Conf.COMPONENT_PAPER)
				{
					Ctx.editor.setCurrentComponent(this);
				}
				e.stopPropagation();
			}
		}
		
		/** 开始拖拽 */
		protected function __dragBeg(e:MouseEvent):void
		{
			if(editable && Ctx.editor.dragable)
			{
				this.startDrag();
				e.stopPropagation();
			}
		}
		
		/** 结束拖拽 */
		protected function __dragEnd(e:MouseEvent):void
		{
			if(editable && Ctx.editor.dragable) this.stopDrag();
			this.mmx = Conf.px2mm(this.x);
			this.mmy = Conf.px2mm(this.y);
		}
		
		public function paint():void
		{
			removeEventListener(Event.ENTER_FRAME, onInvalidate);
			drawBound();
			if(layout) { layout.childSizeChanged(); }
			dispatchChangedEvent();
		}
		
		protected function drawBound():void
		{
			this.graphics.clear();
			var a:Number = 0;
			if(DebugEvent.isDebug) { a = 0.3; }
			
			var lineThickness:Number = Conf.mm2px(borderWidth);
			var lineColor:uint = borderColor;
			if(editable)
			{
			//编辑模式
				if(selected)
				{
					lineColor = 0xff0000;
				}
				else
				{
					lineColor = borderColor;
				}
				if(DebugEvent.isDebug)
				{
					if(lineThickness <= 0) { lineThickness = 1; }
				}
			}
			else
			{
			//渲染模式
			}
			
			if(lineThickness > 0)
			{
				this.graphics.lineStyle(lineThickness, lineColor);
			}
			
			this.graphics.beginFill(componentColor, a);
			var rect_w:Number = Conf.mm2px(mmw)-lineThickness;
			var rect_h:Number = Conf.mm2px(mmh)-lineThickness;
			if(rect_w <= 0) { rect_w = 3; }
			if(rect_h <= 0) { rect_h = 3; }
			this.graphics.drawRect(lineThickness/2, lineThickness/2, rect_w, rect_h);
			this.graphics.endFill();
		}
		
		public function encode(obj:Object):void
		{
			obj.type = this.type;
			obj.isLayout = this.isLayout;
			obj.mmw = this.mmw;
			obj.mmh = this.mmh;
			obj.mmx = this.mmx;
			obj.mmy = this.mmy;
			obj.dsName = this.dsName;
			obj.borderWidth = this.borderWidth;
			obj.borderColor = this.borderColor;
		}
		
		public function decode(obj:Object):void
		{
			this.type = obj.type;
			this._isLayout = obj.isLayout;
			this.mmw = obj.mmw;
			this.mmh = obj.mmh;
			this.mmx = obj.mmx;
			this.mmy = obj.mmy;
			this.dsName = obj.dsName;
			this.borderWidth = obj.borderWidth ? obj.borderWidth : 0;
			this.borderColor = obj.borderColor;
		}
		
		public function removeMe():void
		{
			if(layout != null)
			{
				layout.removeComponent(this);
				layout = null;	
			}
			dispatchRemovedEvent();
		}
		
		/** 上浮 */
		public function bringForward():void
		{
			if(layout != null)
			{
				layout.bringComponentForward(this);
			}
		}
		
		/** 下沉 */
		public function bringBackward():void
		{
			if(layout != null)
			{
				layout.bringComponentBackward(this);
			}
		}
		
		/** 通知布局重绘  */
		public function noticeLayoutRepaint():void
		{
			if(layout) { layout.childSizeChanged(); }
		}
	}
}