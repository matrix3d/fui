package fui 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	/**
	 * ...
	 * @author lizhi
	 */
	public class Button extends EventDispatcher 
	{
		private var txt:TextField;
		public var mc:MovieClip;
		public var state:int;
		protected var isPressed:Boolean = false;
		protected var isOver:Boolean = false;
		private var _useData:Object;
		public function Button(mc:MovieClip) 
		{
			this.mc = mc;
			mc.BUTTON = this;
			init();
		}
		
		//初始化
		private function init():void {
			if (mc) {
				mc.stop();
				mc.buttonMode = true;
				txt = mc.txt_txt;
				if (txt) {
					txt.mouseEnabled = txt.mouseWheelEnabled = false;
					txt.autoSize = TextFieldAutoSize.CENTER;
					txt.wordWrap = false;
					txt.multiline = false;
				}
				addMouseEffect();
				setState(0);
			}
		}
		
		/**
		 * 设置按钮文字
		 */
		public function set text(value:String):void {
			if (txt) txt.text = value;
		}
		
		public function get text():String {
			if (txt) txt.text;
			return "";
		}
		
		public function get useData():Object 
		{
			return _useData;
		}
		
		public function set useData(value:Object):void 
		{
			_useData = value;
			mc.useData = value;
		}
		
		public function addMouseEffect():void {
			mc.addEventListener(MouseEvent.ROLL_OUT, btnOut);
			mc.addEventListener(MouseEvent.MOUSE_OVER, btnOver);
		}
		public function removeMouseEffect():void {
			mc.removeEventListener(MouseEvent.ROLL_OUT, btnOut);
			mc.removeEventListener(MouseEvent.MOUSE_OVER, btnOver);
			
			mc.removeEventListener(MouseEvent.MOUSE_DOWN, btnDown);
			if(mc.stage)
			mc.stage.removeEventListener(MouseEvent.MOUSE_UP, btnUp);
		}
		private function btnOver(e:MouseEvent):void {
			isOver = true;
			updateButtonEffect();
			mc.addEventListener(MouseEvent.MOUSE_DOWN, btnDown);
			mc.stage.addEventListener(MouseEvent.MOUSE_UP, btnUp);
		}
		private function btnOut(e:MouseEvent):void {
			isOver = false;
			updateButtonEffect();
			mc.removeEventListener(MouseEvent.MOUSE_DOWN, btnDown);
		}
		private function btnDown(e:MouseEvent):void {
			isPressed = true;
			updateButtonEffect();
		}
		private function btnUp(e:MouseEvent):void {
			isPressed = false;
			updateButtonEffect();
		}
		
		public function setEnabled(isEnabled:Boolean):void {
			mc.mouseEnabled = isEnabled;
			mc.mouseChildren = isEnabled;
			updateButtonEffect();
		}
		protected function updateButtonEffect():void {
			if (!mc.mouseEnabled) {
				setState(4);
			}else if (isOver&&isPressed) {
				setState(2);
			}else if (isOver&&!isPressed) {
				setState(1);
			}else {
				setState(0);
			}
		}
		
		/**
		 * 
		 * @param	state	0正常 1鼠标经过 2鼠标按下 4灰色状态
		 */
		public function setState(state:int):void {
			this.state = state;
			mc.gotoAndStop(state + 1);
		}
	}

}