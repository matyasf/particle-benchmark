package idv.cjcat.stardustextended.twoD.geom {
	
	public class MotionData4DPool {

		protected static var _vec:Array = [new MotionData4D()];
		protected static var _position:int = 0;

		[Inline]
		public static function get(x:Number = 0, y:Number = 0, vx:Number = 0, vy:Number = 0):MotionData4D {
			if (_position == _vec.length) {
				_vec.length <<= 1;
				
				for (var i:int = _position; i < _vec.length; i++) {
					_vec[i] = new MotionData4D();
				}
			}
			_position++;
			var obj:MotionData4D = _vec[_position - 1];
			obj.x = x;
			obj.y = y;
			obj.vx = vx;
			obj.vy = vy;
			return obj;
		}

		[Inline]
		public static function recycle(obj:MotionData4D):void {
			if (_position == 0) return;
			if (!obj) return;
			
			_vec[_position - 1] = obj;
			if (_position) _position--;
			
			//if (_vec.length >= 16) {
				//if (_position < (_vec.length >> 4)) {
					//
					//trace("MotionData4DPool contracted");
					//
					//_vec.length >>= 1;
				//}
			//}
		}
	}
}