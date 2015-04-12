package idv.cjcat.stardustextended.threeD.particles {
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.particles.ParticlePool;
	
	public class Particle3DPool extends ParticlePool {
		
		private static var _instance:Particle3DPool;
		public static function getInstance():Particle3DPool {
			if (!_instance) _instance = new Particle3DPool();
			return _instance;
		}
		
		public function Particle3DPool() {
			
		}
		
		override protected final function createNewParticle():Particle {
			return new Particle3D();
		}
	}
}