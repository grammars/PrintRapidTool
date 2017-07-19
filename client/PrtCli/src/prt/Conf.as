package prt
{
	import com.anstu.jcommon.utils.StringUtils;
	import com.anstu.jui.define.JuiConst;

	public class Conf
	{
		public static const COMPONENT_PAPER:String = "MyPaper";
		public static const COMPONENT_LAYOUT:String = "MyLayout";
		public static const COMPONENT_LABEL:String = "MyLabel";
		public static const COMPONENT_TABLE:String = "MyTable";
		public static const COMPONENT_IMAGE:String = "MyImage";
		public static const COMPONENT_CODE:String = "MyCode";
		public static const COMPONENT_RECT:String = "MyRect";
		public static const COMPONENT_RICH_TABLE:String = "MyRichTable";
		public static const COMPONENT_RICH_TABLE_ITEM:String = "MyRichTableItem";
		
		public static const PAPER_A3_V:PaperConf = new PaperConf("A3纵向", 297, 420, false);
		public static const PAPER_A3_H:PaperConf = new PaperConf("A3横向", 420, 297, true);
		public static const PAPER_A4_V:PaperConf = new PaperConf("A4纵向", 210, 297, false);
		public static const PAPER_A4_H:PaperConf = new PaperConf("A4横向", 297, 210, true);
		public static const PAPER_CUSTOM:PaperConf = new PaperConf("自定义纸张", 128, 256, false);
		
		public static var X:Number = 2;
		
		public static function get paperTypes():Array
		{
			return [PAPER_A3_V.type, PAPER_A3_H.type, PAPER_A4_V.type, PAPER_A4_H.type, PAPER_CUSTOM.type];
		}
		
		public static function getPaper(type:String):PaperConf
		{
			if(type == PAPER_A3_V.type) return PAPER_A3_V;
			if(type == PAPER_A3_H.type) return PAPER_A3_H;
			if(type == PAPER_A4_V.type) return PAPER_A4_V;
			if(type == PAPER_A4_H.type) return PAPER_A4_H;
			return PAPER_CUSTOM;
		}
		
		public static const ORIENTATION_V:String = "纵向";
		public static const ORIENTATION_H:String = "横向";
		
		public static function get orientations():Array
		{
			return [ORIENTATION_V, ORIENTATION_H];
		}
		
		
		public static const ALIGN_LEFT:String = JuiConst.LEFT;//左对齐
		public static const ALIGN_CENTER:String = JuiConst.CENTER;//居中对齐
		public static const ALIGN_RIGHT:String = JuiConst.RIGHT;//右对齐
		public static function get ALIGN_NAMES():Array { return ["左对齐", "居中对齐", "右对齐"]; }
		public static function alignFromIndex(i:int):String
		{
			if(0 == i) return ALIGN_LEFT;
			if(1 == i) return ALIGN_CENTER;
			if(2 == i) return ALIGN_RIGHT;
			return null;
		}
		public static function indexFromAlign(value:String):int
		{
			if(ALIGN_LEFT == value) return 0;
			if(ALIGN_CENTER == value) return 1;
			if(ALIGN_RIGHT == value) return 2;
			return 0;
		}
		
		
		
		public function Conf()
		{
		}
		
		/** 比例缩放计算   mm ---> px */
		public static function mm2px(mmVal:Number):Number
		{
			return mmVal * X;
		}
		
		/** 比例缩放计算   px ---> mm */
		public static function px2mm(pxVal:Number):Number
		{
			return pxVal / X;
		}
		
		/** 经过环境变量替换 */
		public static function env(source:String):String
		{
			if(StringUtils.isEmpty(source)) { return source; }
			var changed:String = source;
			for(var i:int = 0; i < Ctx.user.envItems.length; i++)
			{
				var k:String = "${"+Ctx.user.envItems[i].key+"}";
				var v:String = Ctx.user.envItems[i].value;
				changed = StringUtils.replace(changed, k, v);
			}
			return changed;
		}
	}
}