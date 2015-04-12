package idv.cjcat.stardustextended.twoD.particles {
	import idv.cjcat.stardustextended.common.particles.PooledParticleFactory;
	
	/** @private */
	public class PooledParticle2DFactory extends PooledParticleFactory {
		
		public function PooledParticle2DFactory() {
			particlePool = Particle2DPool.getInstance();
		}
	}
}