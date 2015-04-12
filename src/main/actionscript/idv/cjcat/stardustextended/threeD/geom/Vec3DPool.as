package idv.cjcat.stardustextended.threeD.geom {
	
	public class Vec3DPool {
		
		private static var _vec:Array = [new Vec3D()];
		private static var _position:int = 0;
		
		public static function get(x:Number = 0, y:Number = 0, z:Number = 0):Vec3D {
			if (_position == _vec.length) {
				_vec.length <<= 1;
				
				//trace("Vec3DPool expanded");
				
				for (var i:int = _position; i < _vec.length; i++) {
					_vec[i] = new Vec3D();
				}
			}
			_position++;
			var obj:Vec3D = _vec[_position - 1];
			obj.x = x;
			obj.y = y;
			obj.z = z;
			return obj;
		}
		
		public static function recycle(obj:Vec3D):void {
			if (_position == 0) return;
			if (!obj) return;
			
			_vec[_position - 1] = obj;
			if (_position) _position--;
			
			//if (_vec.length >= 16) {
				//if (_position < (_vec.length >> 4)) {
					//
					//trace("Vec3DPool contracted");
					//
					//_vec.length >>= 1;
				//}
			//}
		}
	}
}