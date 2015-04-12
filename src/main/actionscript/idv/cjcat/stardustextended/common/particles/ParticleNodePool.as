package idv.cjcat.stardustextended.common.particles {
	
	internal class ParticleNodePool {
		
		private static var _vec:Array = [new ParticleNode()];
		private static var _position:int = 0;
		
		public static function get(particle:Particle):ParticleNode {
			if (_position == _vec.length) {
				_vec.length <<= 1;
				
				//trace("ParticleNodePool expanded");
				
				for (var i:int = _position; i < _vec.length; i++) {
					_vec[i] = new ParticleNode();
				}
			}
			_position++;
			var node:ParticleNode = _vec[_position - 1];
			node.particle = particle;
			return node;
		}
		
		public static function recycle(node:ParticleNode):void {
			if (_position == 0) return;
			node.particle = null;
			node.next = node.prev = null;
			//node.next = null;
			_vec[_position - 1] = node;
			if (_position) _position--;
			
			//if (_vec.length >= 16) {
				//if (_position < (_vec.length >> 4)) {
					//
					//trace("ParticlePool contracted");
					//
					//_vec.length >>= 1;
				//}
			//}
		}
	}
}