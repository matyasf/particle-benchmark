package idv.cjcat.stardustextended.threeD.geom {
	import flash.display.DisplayObject;
	import idv.cjcat.stardustextended.threeD.particles.Particle3D;
	
	public class ZDataPool {
		
		private static var _vec:Array = [new ZData()];
		private static var _position:int = 0;
		
		public static function get(displayObject:DisplayObject, particle:Particle3D, x:Number = 0, y:Number = 0, z:Number = 0):ZData {
			if (_position == _vec.length) {
				_vec.length <<= 1;
				
				//trace("ZDataPool expanded");
				
				for (var i:int = _position; i < _vec.length; i++) {
					_vec[i] = new ZData();
				}
			}
			_position++;
			var obj:ZData = _vec[_position - 1] as ZData;
			obj.displayObject = displayObject;
			obj.particle = particle;
			obj.cameraDiff.x = x;
			obj.cameraDiff.y = y;
			obj.cameraDiff.z = z;
			return obj;
		}
		
		public static function recycle(obj:ZData):void {
			obj.displayObject = null;
			if (_position == 0) return;
			if (!obj) return;
			
			_vec[_position - 1] = obj;
			if (_position) _position--;
			
			//if (_vec.length >= 16) {
				//if (_position < (_vec.length >> 4)) {
					//
					//trace("ZDataPool contracted");
					//
					//_vec.length >>= 1;
				//}
			//}
		}
	}
}