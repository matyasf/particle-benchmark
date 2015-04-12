package idv.cjcat.stardustextended.twoD.bursters {
	import idv.cjcat.stardustextended.common.bursters.Burster;
	import idv.cjcat.stardustextended.twoD.particles.Particle2DFactory;
	
	/**
	 * Base class for 2D bursters.
	 */
	public class Burster2D extends Burster {
		
		public function Burster2D() {
			factory = new Particle2DFactory();
		}
	}
}