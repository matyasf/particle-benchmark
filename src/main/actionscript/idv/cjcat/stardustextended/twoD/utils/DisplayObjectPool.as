package idv.cjcat.stardustextended.twoD.utils {

	import flash.display.DisplayObject;
	import idv.cjcat.stardustextended.common.utils.construct;
	
	public class DisplayObjectPool {
		
		private static const DEFAULT_SIZE:int = 32;
		
		protected var _class:Class;
		protected var _params:Array;
		protected var _vec:Array = [];
		protected var _position:int = 0;

		[Inline]
		final public function reset(c:Class, params:Array):void {
			_position = 0;
			_vec = new Array(DEFAULT_SIZE);
			_class = c;
			_params = params;
			for (var i:int = 0; i < DEFAULT_SIZE; i++) {
				_vec[i] = construct(_class, _params); 
			}
		}

		[Inline]
		final public function get():DisplayObject {
			if (_position == _vec.length) {
				_vec.length <<= 1;
				for (var i:int = _position; i < _vec.length; i++) {
					_vec[i] = construct(_class, _params);
				}
			}
			_position++;
			return _vec[_position - 1];
		}

		[Inline]
		final public function recycle(obj:DisplayObject):void {
			if (_position == 0) return;
			if (!obj) return;
			
			_vec[_position - 1] = obj;
			_position--;
			if (_position < 0) _position = 0;
			
			if (_vec.length > DEFAULT_SIZE * 2) {
				if (_position < (_vec.length >> 4)) {
					_vec.length >>= 1;
				}
			}
		}
	}
}