package idv.cjcat.stardustextended.threeD.geom {
	
	public class Matrix3DPool {
		
		private static var _vec:Array = [new Matrix3D()];
		private static var _position:int = 0;
		
		public static function get(a:Number = 1, b:Number = 0, c:Number = 0, d:Number = 0, e:Number = 1, f:Number = 0, g:Number = 0, h:Number = 0, i:Number = 1, tx:Number = 0, ty:Number = 0, tz:Number = 0):Matrix3D {
			if (_position == _vec.length) {
				_vec.length <<= 1;
				
				//trace("Matrix3DPool expanded");
				
				for (var j:int = _position; j < _vec.length; j++) {
					_vec[j] = new Matrix3D();
				}
			}
			_position++;
			var obj:Matrix3D = _vec[_position - 1];
			obj.a = a;
			obj.b = b;
			obj.c = c;
			obj.d = d;
			obj.e = e;
			obj.f = f;
			obj.g = g;
			obj.h = h;
			obj.i = i;
			obj.tx = tx;
			obj.ty = ty;
			obj.tz = tz;
			return obj;
		}
		
		public static function recycle(obj:Matrix3D):void {
			if (_position == 0) return;
			if (!obj) return;
			
			_vec[_position - 1] = obj;
			if (_position) _position--;
			
			//if (_vec.length >= 16) {
				//if (_position < (_vec.length >> 4)) {
					//
					//trace("Matrix3DPool contracted");
					//
					//_vec.length >>= 1;
				//}
			//}
		}
	}
}