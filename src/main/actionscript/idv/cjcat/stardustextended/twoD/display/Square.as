package idv.cjcat.stardustextended.twoD.display {
	
	public class Square extends BasicShape {
		
		private var _size:Number;
		public function Square(size:Number = 20, fillColor:uint = 0xFFFFFF, fillAlpha:Number = 1, lineColor:uint = 0x006600, lineAlpha:Number = 1, lineThickness:Number = 0) {
			super(fillColor, fillAlpha, lineColor, lineAlpha, lineThickness);
			_size = size;
			update();
		}
		
		public final function get size():Number { return _size; }
		public final function set size(value:Number):void {
			_size = value;
			update();
		}
		
		override public function update():void {
			graphics.clear();
			if (lineAlpha > 0 && lineThickness > 0) graphics.lineStyle(lineThickness, lineColor, lineAlpha, true);
			if (fillAlpha > 0) graphics.beginFill(fillColor, fillAlpha);
			var origin:Number = -_size * 0.5;
			graphics.drawRect(origin, origin, _size, _size);
		}
	}
}