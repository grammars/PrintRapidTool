package prt.component
{
	import com.adobe.serialization.json.JSON;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.URLVariables;
	
	import prt.Conf;
	import prt.Ctx;
	import prt.events.DsEvent;
	import prt.manager.ApiLoader;
	import prt.manager.DsLoader;
	import prt.ui.DsPanel;
	import prt.vo.PrtTpl;
	import prt.vo.tpl.PrtDsItem;
	
	public class MyPaper extends MyLayout
	{	
		private static var ancestor_rec:int = 0;
		
		private var data:PrtTpl;
		
		public function MyPaper()
		{
			super();
			this.ancestor = ++ancestor_rec;
			this.type = Conf.COMPONENT_PAPER;
			this.componentColor = 0xffffff;
			invalidate();
		}
		
		override public function paint():void
		{
			super.paint();
		}
		
		public function setup(data:PrtTpl, requestParam:Object):void
		{
			this.data = data;
			this.requestParam = requestParam;
			this.mmw = this.data.paper_mmWidth;
			this.mmh = this.data.paper_mmHeight;
			
			setChildrenAncestor(this, this.ancestor);
			
			var params:URLVariables = new URLVariables();
			for (var k:String in this.requestParam)
			{
				params[k] = this.requestParam[k];
			}
			for(var i:int = 0; i < this.data.dsItems.length; i++)
			{
				var ds:PrtDsItem = this.data.dsItems[i];
				new DsLoader(this.ancestor, ds.name, Conf.env(ds.api), params, dsLoadedHandler).load();
			}
		}
		
		private function setChildrenAncestor(c:MyComponent, a:int):void
		{
			c.ancestor = a;
			if(c is MyLayout)
			{
				var l:MyLayout = c as MyLayout;
				for(var i:int = 0; i < l.components.length; i++)
				{
					setChildrenAncestor(l.components[i], a);
				}
			}
		}
		
		private function dsLoadedHandler(ancestor:int, dsName:String, jsonObj:Object):void
		{
			var debugStr:String = "======="+ancestor+"====="+dsName+"==============";
			trace(debugStr);
			debugStr = "";
			for (var k:String in jsonObj)
			{
				debugStr += k + ":" + jsonObj[k] + ", ";
			}
			trace(debugStr);
			
			var event:DsEvent = new DsEvent(DsEvent.LOADED);
			event.ancestor = ancestor;
			event.dsName = dsName;
			event.jsonObj = jsonObj;
			Ctx.observer.dispatchEvent(event);
		}
		
		override protected function __dragBeg(e:MouseEvent):void { }
		
		override protected function __dragEnd(e:MouseEvent):void { }
		
		private function __ADD__(c:MyComponent):void
		{
			if(Ctx.editor.currentComponent != null && Ctx.editor.currentComponent is MyLayout)
			{
				(Ctx.editor.currentComponent as MyLayout).addComponent(c);
			}
			else if(Ctx.editor.currentComponent != null && Ctx.editor.currentComponent.layout != null)
			{
				Ctx.editor.currentComponent.layout.addComponent(c);
			}
			else
			{
				this.addComponent(c);
			}
		}
		
		public function addLayout():void
		{
			var c:MyLayout = new MyLayout();
			__ADD__(c);
		}
		
		public function addLabel():void
		{
			var c:MyLabel = new MyLabel();
			__ADD__(c);
		}
		
		public function addRect():void
		{
			var c:MyRect = new MyRect();
			__ADD__(c);
		}
		
		public function addTable():void
		{
			var c:MyTable = new MyTable();
			__ADD__(c);
		}
		
		public function addImage():void
		{
			var c:MyImage = new MyImage();
			__ADD__(c);
		}
		
		public function addCode():void
		{
			var c:MyCode = new MyCode();
			__ADD__(c);
		}
		
		public function addRichTable():void
		{
			var c:MyRichTable = new MyRichTable();
			__ADD__(c);
		}
		
		override public function encode(obj:Object):void
		{
			super.encode(obj);
		}
		
		override public function decode(obj:Object):void
		{
			super.decode(obj);
		}
		
		
	}

}