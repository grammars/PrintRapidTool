package prt.component
{
	import prt.Conf;

	public class MyLayout extends MyComponent
	{
		public var components:Vector.<MyComponent> = new Vector.<MyComponent>();
		
		public static const LMODE_ABS:String = "abs";//绝对布局模式
		public static const LMODE_REL:String = "rel";//相对布局模式
		public static function get LMODE_NAMES():Array { return ["绝对布局", "相对布局"]; }
		public static function lmodeFromIndex(i:int):String
		{
			if(0 == i) return LMODE_ABS;
			if(1 == i) return LMODE_REL;
			return null;
		}
		public static function indexFromLmode(value:String):int
		{
			if(LMODE_ABS == value) return 0;
			if(LMODE_REL == value) return 1;
			return 0;
		}
		
		private var _lmode:String;
		public function set lmode(value:String):void
		{
			this._lmode = value;
			invalidate();
		}
		public function get lmode():String { return this._lmode; }
		
		public static const LDIR_V:String = "v";//垂直方向
		public static const LDIR_H:String = "h";//水平方向
		public static function get LDIR_NAMES():Array { return ["垂直方向", "水平方向"]; }
		public static function ldirFromIndex(i:int):String
		{
			if(0 == i) return LDIR_V;
			if(1 == i) return LDIR_H;
			return null;
		}
		public static function indexFromLdir(value:String):int
		{
			if(LDIR_V == value) return 0;
			if(LDIR_H == value) return 1;
			return 0;
		}
		
		private var _ldir:String;
		public function set ldir(value:String):void
		{
			this._ldir = value;
			invalidate();
		}
		public function get ldir():String { return this._ldir; }
		
		private var _wrap:Boolean;
		public function set wrap(value:Boolean):void
		{
			this._wrap = value;
			invalidate();
		}
		public function get wrap():Boolean { return this._wrap; }
		
		public function MyLayout()
		{
			super();
			this.type = Conf.COMPONENT_LAYOUT;
			this._isLayout = true;
			this.componentColor = 0x2b2b2b;
			this.mmw = 120;
			this.mmh = 64;
			invalidate();
		}
		
		public function addComponent(c:MyComponent, needPaint:Boolean=true):void
		{
			c.layout = this;
			components.push(c);
			this.addChild(c);
			if(needPaint) { paint(); }
		}
		
		override public function paint():void
		{
			var c:MyComponent;
			var i:int;
			if(lmode == LMODE_ABS)
			{
				
			}
			else if(lmode == LMODE_REL)
			{
				var posX:Number = 0;
				var posY:Number = 0;
				for(i = 0; i < components.length; i++)
				{
					c = components[i];
					if(ldir == LDIR_V)
					{
						c.mmy = posY;
						posY += c.mmh;
					}
					else
					{
						c.mmx = posX;
						posX += c.mmw;
					}
				}
			}
			
			if(wrap)
			{
				var mmwNew:Number = 1;
				var mmhNew:Number = 1;
				
				for(i = 0; i < components.length; i++)
				{
					c = components[i];
					var cw:Number = c.mmx + c.mmw;
					var ch:Number = c.mmy + c.mmh;
					if(cw > mmwNew) { mmwNew = cw; }
					if(ch > mmhNew) { mmhNew = ch; }
				}
				this._mmw = mmwNew;
				this._mmh = mmhNew;
			}
			super.paint();
		}
		
		public function removeComponent(c:MyComponent):void
		{
			for(var i:int = 0; i < components.length; i++)
			{
				if(c == components[i])
				{
					components.splice(i, 1);
					break;
				}
			}
			if(c.parent) { c.parent.removeChild(c); }
			paint();
		}
		
		public function removeComponents():void
		{
			for(var i:int = 0; i < components.length; i++)
			{
				if(components[i].parent) { components[i].parent.removeChild(components[i]); }
			}
			components.length = 0;
		}
		
		public function getComponentIndex(c:MyComponent):int
		{
			for(var i:int = 0; i < components.length; i++)
			{
				if(c == components[i])
				{
					return i;
				}
			}
			return -1;
		}
		
		public function bringComponentForward(c:MyComponent):void
		{
			trace("components.length="+components.length);
			if(components.length <= 1) { return; }
			var curIndex:int = getComponentIndex(c);
			trace("curIndex="+curIndex+", components.length="+components.length);
			if(curIndex >= components.length-1) { return; }
			var chNum:int = components.length;
			trace("chNum="+chNum);
			if(curIndex < chNum-1)
			{
				c.parent.setChildIndex(c, curIndex+1);
				trace("实际显示顺序改了");
			}
			
			for(var i:int = 0; i < components.length; i++)
			{
				if( (components[i] == c) && (i+1 < components.length) )
				{
					trace("components changed");
					components.splice(i, 1);
					components.splice(i+1, 0, c);
					break;
				}
			}
		}
		
		public function bringComponentBackward(c:MyComponent):void
		{
			if(components.length <= 1) { return; }
			var curIndex:int = getComponentIndex(c);
			if(curIndex <= 0) { return; }
			var chNum:int = components.length;
			if(curIndex > 0)
			{
				c.parent.setChildIndex(c, curIndex-1);
			}
			
			for(var i:int = 0; i < components.length; i++)
			{
				if( (components[i] == c) && (i-1 >= 0) )
				{
					components.splice(i, 1);
					components.splice(i-1, 0, c);
					break;
				}
			}
		}
		
		public function childSizeChanged():void
		{
			paint();
			noticeLayoutRepaint();
		}
		
		override public function encode(obj:Object):void
		{
			super.encode(obj);
			obj.lmode = this.lmode;
			obj.ldir = this.ldir;
			obj.wrap = this.wrap;
		}
		
		override public function decode(obj:Object):void
		{
			super.decode(obj);
			this.lmode = obj.lmode;
			this.ldir = obj.ldir;
			this.wrap = obj.wrap;
		}
	}
}