package idv.cjcat.stardustextended.common.particles {

	/**
	 * This is an object pool for particle objects.
	 * 
	 * <p>
	 * Be sure to recycle a particle after getting it from the pool.
	 * </p>
	 */
	public class ParticlePool {
		
		private static var _instance:ParticlePool;
		/**
		 * Returns the singleton of the pool.
		 * @return
		 */
		public static function getInstance():ParticlePool {
			if (!_instance) _instance = new ParticlePool();
			return _instance;
		}

		protected var _array:Vector.<Particle>;
		protected var _position:int;
		
		public function ParticlePool() {
			_array = new <Particle>[createNewParticle()];
			_position = 0;
		}
		
		/** @private */
		protected function createNewParticle():Particle {
			return new Particle();
		}

		[Inline]
		public final function get():Particle {
			if (_position == _array.length) {
				_array.length <<= 1;
				for (var i:int = _position; i < _array.length; i++) {
					_array[i] = createNewParticle();
				}
			}
			_position++;
			return _array[_position - 1];
		}

		[Inline]
		public final function recycle(particle:Particle):void {
			if (_position > 0 && particle) {
                _array[_position - 1] = particle;
                _position--;
            }
		}
	}
}