package fui 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author lizhi
	 */
	public class Progress 
	{
		public var mc:MovieClip;
		public var tf:TextField;
		public var up:DisplayObject;
		
		private var _value:Number;
		public var upwidth:Number;
		private var uprect:Rectangle;
		private var _useScale:Boolean;
		
		public function Progress(mc:MovieClip,blod:Boolean=true,useScale:Boolean=true) 
		{
			this.mc = mc;
			tf = mc.text_txt;
			if (blod&&tf) {
				blodTf(tf);
			}
			up = mc.up_mc;
			upwidth = up.width;
			uprect = new Rectangle(0, 0, upwidth, up.height);
			this.useScale = useScale;
			value = 0;
		}
		
		public function blodTf(tf:TextField):void {
			
				var tfm:TextFormat = new TextFormat;
				tfm.bold = true;
				tf.defaultTextFormat = tfm;
				tf.setTextFormat(tfm);
		}
		
		public function get value():Number 
		{
			return _value;
		}
		
		public function set value(value:Number):void 
		{
			_value = value;
			if (useScale) {
				up.scaleX = value>1?1:value;
			}else{
			uprect.width = upwidth * value;
			up.scrollRect = uprect;
			}
		}
		
		public function get text():String 
		{
			if (tf) return tf.text;
			return "";
		}
		
		public function set text(value:String):void 
		{
			if (tf) tf.text = value;
		}
		
		public function get useScale():Boolean 
		{
			return _useScale;
		}
		
		public function set useScale(value:Boolean):void 
		{
			if (!value) up.scaleX = 1;
			_useScale = value;
		}
		
	}

}