package fui 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	/**
	 * ...
	 * @author lizhi
	 */
	public class Stepper extends EventDispatcher
	{
		private var tf:TextField;
		public var mc:MovieClip;
		private var _num:int = 0;
		public var isRightChanged:Boolean;//是否是右按钮被点选
		private var lefts:Array=[];
		private var rights:Array=[];
		public var max:int = 10;
		public var min:int = 0;
		
		private var _inputAble:Boolean;
		public function Stepper(mc:MovieClip) 
		{
			this.mc = mc;
			tf = mc.txt_txt;
			if(tf)tf.addEventListener(Event.CHANGE, tf_textInput);
			bindBtn(new Button(mc.mc_left_mc), new Button(mc.mc_right_mc));
		}
		
		/**
		 * 绑定其它按钮 共同控制
		 * @param	left
		 * @param	right
		 */
		public function bindBtn(left:Button, right:Button):void {
			if (left) {
				lefts.push(left);
				left.mc.addEventListener(MouseEvent.CLICK, left_mc_click);
			}
			if (right) {
				rights.push(right);
				right.mc.addEventListener(MouseEvent.CLICK, right_mc_click);
			}
			
			update();
		}
		
		private function tf_textInput(e:Event):void 
		{
			if (tf.text.indexOf("/")!=-1) {
				num=int(tf.text.substr(0,tf.text.indexOf("/")))
			}else {
				num = int(tf.text);
			}
			
		}
		
		private function right_mc_click(e:MouseEvent):void 
		{
			isRightChanged = true;
			num++;
		}
		
		private function left_mc_click(e:MouseEvent):void 
		{
			isRightChanged = false;
			num--;
		}
		
		public function update():void {
			if (tf) {
				//if (inputAble) {
				//	tf.text = num + "";
				//}else {
					tf.text = num + "/"+max;
				//}
				
			}
			if (num <= min) {
				for each(var btn:Button in lefts) {
					btn.setEnabled(false);
				}
				
			}else {
				for each(btn in lefts) {
					btn.setEnabled(true);
				}
			}
			if (num >= max) {
				for each(btn in rights) {
					btn.setEnabled(false);
				}
			}else {
				for each(btn in rights) {
					btn.setEnabled(true);
				}
			}
		}
		
		public function get num():int 
		{
			return _num;
		}
		
		public function set num(value:int):void 
		{
			value = Math.max(min, Math.min(max, value));
			if(_num!=value){
				_num = value;
				dispatchEvent(new Event(Event.CHANGE));
			}
				update();
			
		}
		
		public function get inputAble():Boolean 
		{
			return _inputAble;
		}
		
		public function set inputAble(value:Boolean):void 
		{
			_inputAble = value;
			if(value){
			tf.type = TextFieldType.INPUT;
			tf.addEventListener(MouseEvent.CLICK, tf_click);
			}else {
				tf.type = TextFieldType.DYNAMIC;tf.removeEventListener(MouseEvent.CLICK, tf_click);
			}
			update();
		}
		
		private function tf_click(e:MouseEvent):void 
		{
			tf.setSelection(0, 1000);
		}
		
	}

}