package idv.cjcat.stardustextended.threeD.geom {
	
	public class MotionData6DPool {
		
		private static var _vec:Array = [new MotionData6D()];
		private static var _position:int = 0;
		
		public static function get(x:Number = 0, y:Number = 0, z:Number = 0, vx:Number = 0, vy:Number = 0, vz:Number = 0):MotionData6D {
			if (_position == _vec.length) {
				_vec.length <<= 1;
				
				//trace("MotionData6DPool expanded");
				
				for (var i:int = _position; i < _vec.length; i++) {
					_vec[i] = new MotionData6D();
				}
			}
			_position++;
			var obj:MotionData6D = _vec[_position - 1];
			obj.x = x;
			obj.y = y;
			obj.z = z;
			obj.vx = vx;
			obj.vy = vy;
			obj.vz = vz;
			return obj;
		}
		
		public static function recycle(obj:MotionData6D):void {
			if (_position == 0) return;
			if (!obj) return;
			
			_vec[_position - 1] = obj;
			if (_position) _position--;
			
			//if (_vec.length >= 16) {
				//if (_position < (_vec.length >> 4)) {
					//
					//trace("MotionData6DPool contracted");
					//
					//_vec.length >>= 1;
				//}
			//}
		}
	}
}