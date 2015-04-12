package idv.cjcat.stardustextended.common.errors {
	
	/**
	 * This error is thrown when a 2D emitter finds 3D particles in the particle list, 
	 * or a 3D emitter finds 2D particles in the particle list.
	 */
	public class ParticleClassError extends Error {
		
		private var _invalidClass:Class;
		private var _expectedClass:Class;
		public function ParticleClassError(message:*, invalidClass:Class, expectedClass:Class) {
			super(message);
			_invalidClass = invalidClass;
			_expectedClass = expectedClass;
		}
		
		public function get invalidClass():Class { return _invalidClass; }
		public function get expectedClass():Class { return _expectedClass; }
	}
}