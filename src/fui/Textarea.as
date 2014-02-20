package fui 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	/**
	 * ...
	 * @author lizhi
	 */
	public class Textarea 
	{
		public var mc:MovieClip;
		public var textField:TextField;
		private var slider:Slider;
		public function Textarea(mc:MovieClip) 
		{
			this.mc = mc;
			
			textField = mc.text_txt;
			slider = new Slider(mc.tarea_slider_mc);
			slider.scaleY = mc.scaleY;
			slider.mc.x = slider.mc.x * mc.scaleX;
			textField.width *= mc.scaleX;
			textField.height *= mc.scaleY;
			textField.condenseWhite=true;
			mc.scaleX = mc.scaleY = 1;
			textField.background = true;
			textField.backgroundColor = 0xffffff;
			slider.addEventListener(Event.CHANGE, slider_change);
			textField.addEventListener(Event.SCROLL, textField_scroll);
		}
		
		private function textField_scroll(e:Event):void 
		{
			slider.removeEventListener(Event.CHANGE, slider_change);
			slider.value = (textField.scrollV - 1) / (textField.maxScrollV - 1);
			slider.addEventListener(Event.CHANGE, slider_change);
		}
		
		private function slider_change(e:Event):void 
		{
			textField.removeEventListener(Event.SCROLL, textField_scroll);
			textField.scrollV = (textField.maxScrollV - 1) * slider.value + 1;
			textField.addEventListener(Event.SCROLL, textField_scroll);
		}
		
		private function updateSilder():void {
			var h:Number = slider.bglength*slider.scaleY*textField.height  / textField.textHeight;
			if (h > slider.bglength*slider.scaleY) h = slider.bglength*slider.scaleY;
			if (h < 20) h = 20;
			slider.sliderbtn.mc.height = h; 
			slider.setValueNoSendEvent(slider.value);
		}
		
		public function set text(value:String):void {
			if (textField) {
				textField.text = value;
				updateSilder();
			}
		}
		
		public function get text():String {
			if (textField) return textField.text;
			return "";
		}
		
		public function set htmltext(value:String):void {
			if (textField) {
				textField.htmlText = value;
				updateSilder();
			}
		}
		
		public function get htmltext():String {
			if (textField) return textField.htmlText;
			return "";
		}
		
		
	}

}