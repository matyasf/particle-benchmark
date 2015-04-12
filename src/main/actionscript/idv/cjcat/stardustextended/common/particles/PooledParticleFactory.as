package idv.cjcat.stardustextended.common.particles {
	
	/** @private */
	public class PooledParticleFactory extends ParticleFactory {
		
		protected var particlePool:ParticlePool;
		
		public function PooledParticleFactory() {
			particlePool = ParticlePool.getInstance();
		}

		override protected final function createNewParticle():Particle {
			return particlePool.get();
		}

        [Inline]
		public final function recycle(particle:Particle):void {
			particlePool.recycle(particle);
		}
	}
}