package prt.manager
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.printing.PrintJob;
	import flash.printing.PrintJobOptions;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.utils.setTimeout;
	
	import prt.Ctx;
	import prt.component.MyPaper;
	import prt.events.DebugEvent;
	import prt.ui.PaperRender;
	import prt.ui.Res;

	public class RenderManager
	{
		private var papers:Vector.<MyPaper> = new Vector.<MyPaper>();
		
		public function RenderManager()
		{
		}
		
		public function initialize():void
		{
			
		}
		
		/** 进入渲染模式 */
		public function enter():void
		{
			Ctx.ui.renderCanvas.show();
			Ctx.ui.tplPanel.show();
			
			var event:DebugEvent = new DebugEvent(DebugEvent.DEBUG_MODE);
			DebugEvent.isDebug = false;
			Ctx.observer.dispatchEvent(event);
		}
		
		/** 退出渲染模式 */
		public function exit():void
		{
			Ctx.ui.renderCanvas.hide();
			Ctx.ui.tplPanel.hide();
			Ctx.ui.addTplDialog.hide();
		}
		
		/** 开始渲染 */
		public function startRender():void
		{
			papers.length = 0;
			Ctx.ui.renderCanvas.removePaperRenderAll();
			var curX:int = 0;
			var curY:int = 0;
			for(var i:int = 0; i < Ctx.task.reqList.length; i++)
			{
				var requestParam:Object = Ctx.task.reqList[i];
				var pr:PaperRender = new PaperRender();
				pr.setup(Ctx.renderingTpl, requestParam);
				pr.x = curX;
				pr.y = curY;
				Ctx.ui.renderCanvas.addPaperRender(pr);
				curY += pr.height + 20;
				
				papers.push(pr.paper);
			}
			Ctx.ui.hideLoading();
		}
		
		/** 执行打印 */
		public function executePrint():void
		{
			if(papers.length == 0)
			{
				Ctx.ui.alertDialog.warn("警告", "请先选择模板进行渲染");
				return;
			}
			
			
			var opt:PrintJobOptions = new PrintJobOptions();
			opt.printAsBitmap = true;
			
			var p:PrintJob = new PrintJob();
			
			if(p.start())
			{
				try
				{
					var i:int = 0;
					var resetObj:Object;
					var resetArr:Array = [];
					for(i = 0; i < papers.length; i++)
					{
						resetObj = new Object();
						resetObj.scaleX = papers[i].scaleX;
						resetObj.scaleY = papers[i].scaleY;
						resetObj.rotation = papers[i].rotation;
						resetObj.parent = papers[i].parent;
						resetArr.push(resetObj);
						var jobSp:Sprite = papers[i];
						Ctx.stage.addChild(jobSp);
						if(Ctx.renderingTpl.paper_landscape)
						{
							jobSp.rotation = 90;
						}
						jobSp.width = p.pageWidth; //先让对象适应纸张的宽度;
						jobSp.scaleY = jobSp.scaleX; //按比例调节高度;
						p.addPage(jobSp,null,opt);
					}
					p.send();
					
					if(!Ctx.renderingTpl.paper_landscape)
					{
						for(i = 0; i < papers.length; i++)
						{
							resetObj = resetArr[i];
							papers[i].scaleX = resetObj.scaleX;
							papers[i].scaleY = resetObj.scaleY;
							resetObj.parent.addChild(papers[i]);
						}
					}
				}
				catch(e:Error){
					Ctx.console.log("打印出现异常："+e);
					
				}
			}
		}
		
	}
}