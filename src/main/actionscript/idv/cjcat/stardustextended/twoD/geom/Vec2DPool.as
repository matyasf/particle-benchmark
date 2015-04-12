package idv.cjcat.stardustextended.twoD.geom {
	
	public class Vec2DPool {
		
		protected static const _vec : Vector.<Vec2D> = new <Vec2D>[new Vec2D()];
		protected static var _position:int = 0;

		[Inline]
		public static function get(x:Number = 0, y:Number = 0):Vec2D {
			if (_position == _vec.length) {
				_vec.length <<= 1;
				for (var i:int = _position; i < _vec.length; i++) {
					_vec[i] = new Vec2D();
				}
			}
			const obj:Vec2D = _vec[_position];
            obj.x = x;
            obj.y = y;
            _position++;
            return obj;
		}

		[Inline]
		public static function recycle(obj:Vec2D):void {
			if (_position > 0 && obj) {
                _vec[_position - 1] = obj;
                _position--;
            }
		}
	}
}