package idv.cjcat.stardustextended.threeD.particles {
	import idv.cjcat.stardustextended.common.particles.PooledParticleFactory;
	
	/** @private */
	public class PooledParticle3DFactory extends PooledParticleFactory {
		
		public function PooledParticle3DFactory() {
			particlePool = Particle3DPool.getInstance();
		}
	}
}