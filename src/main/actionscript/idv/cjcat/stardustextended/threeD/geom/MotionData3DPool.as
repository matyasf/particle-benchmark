package idv.cjcat.stardustextended.threeD.geom {
	
	public class MotionData3DPool {
		
		private static var _vec:Array = [new MotionData3D()];
		private static var _position:int = 0;
		
		public static function get(x:Number = 0, y:Number = 0, z:Number = 0):MotionData3D {
			if (_position == _vec.length) {
				_vec.length <<= 1;
				
				//trace("MotionData3DPool expanded");
				
				for (var i:int = _position; i < _vec.length; i++) {
					_vec[i] = new MotionData3D();
				}
			}
			_position++;
			var obj:MotionData3D = _vec[_position - 1];
			obj.x = x;
			obj.y = y;
			obj.z = z;
			return obj;
		}
		
		public static function recycle(obj:MotionData3D):void {
			if (_position == 0) return;
			if (!obj) return;
			
			_vec[_position - 1] = obj;
			if (_position) _position--;
			
			//if (_vec.length >= 16) {
				//if (_position < (_vec.length >> 4)) {
					//
					//trace("MotionData3DPool contracted");
					//
					//_vec.length >>= 1;
				//}
			//}
		}
	}
}