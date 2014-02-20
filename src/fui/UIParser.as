package fui 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.describeType;
	import flash.utils.getAliasName;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * 根据资源生成ui win_ btn_ slider_ ta_ title_
	 * @author lizhi
	 */
	public class UIParser 
	{
		public var mc:MovieClip;
		private static var  regs:Array;
		public var components:Array = [];
		public function UIParser(mc:MovieClip) 
		{
			this.mc = mc;
			if(regs==null){
				regs = [];
				regs.push([/^btn_/i,Button]);
				regs.push([/^tbtn_/i,ToggleButton]);
				regs.push([/^ta_/i,Textarea]);
				regs.push([/^tit_/i,TitleCore]);
				regs.push([/^progress_/i,Progress]);
				regs.push([/^stepper_/i,Stepper]);
				regs.push([/^tabbar_/i, Tabbar]);
			}
		}
		
		public function getComponent(name:String):Object {
			return components[name];
		}
		
		public function parser(isChickFront:Boolean=true):void {
			parserCore(mc);
			if (isChickFront) mc.addEventListener(MouseEvent.MOUSE_DOWN, mc_mouseDown);
		}
		
		private var parent:String = "";
		private function parserCore(mc:*):void {
			var xml:XML = describeType(mc);
			var list:XMLList = xml.variable;
			for each(xml in list) {
				var name:String = xml.@name;
				
				var temp:String = parent;
				parent = parent + name+".";
				parserCore(mc[name]);
				parent = temp;
				for each(var arr:Array in regs) {
					var reg:RegExp = arr[0];
					var obj:Object = reg.exec(name);
					if (obj) {
						var str:String = obj[0];
						if (str == "tit_") {
							components[parent + name] = new TitleCore(mc[name], mc);
							components[parent+name+"-btn"]= new Button(mc[name]);
						}else if(str=="progress_"){
							components[parent + name] = new Progress(mc[name]);
						}
						else{
							components[parent + name] = new (arr[1] as Class)(mc[name]);
						}
						break;
					}
				}
			}
			
		}
		
		private function mc_mouseDown(e:MouseEvent):void 
		{
			if (mc.parent) mc.parent.setChildIndex(mc, mc.parent.numChildren - 1);
		}
	}

}