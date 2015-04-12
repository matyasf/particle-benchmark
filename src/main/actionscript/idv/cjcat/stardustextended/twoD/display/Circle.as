package idv.cjcat.stardustextended.twoD.display {
	
	public class Circle extends BasicShape {
		
		private var _radius:Number;
		public function Circle(radius:Number = 10, fillColor:uint = 0xFFFFFF, fillAlpha:Number = 1, lineColor:uint = 0x006600, lineAlpha:Number = 1, lineThickness:Number = 0) {
			super(fillColor, fillAlpha, lineColor, lineAlpha, lineThickness);
			_radius = radius;
			update();
		}
		
		public final function get radius():Number { return _radius; }
		public final function set radius(value:Number):void {
			_radius = value;
			update();
		}
		
		override public function update():void {
			graphics.clear();
			if (lineAlpha > 0) graphics.lineStyle(lineThickness, lineColor, lineAlpha, true);
			if (fillAlpha > 0) graphics.beginFill(fillColor, fillAlpha);
			graphics.drawCircle(0, 0, _radius);
		}
	}
}