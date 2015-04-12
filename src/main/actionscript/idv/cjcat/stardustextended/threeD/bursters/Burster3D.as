package idv.cjcat.stardustextended.threeD.bursters {
	import idv.cjcat.stardustextended.common.bursters.Burster;
	import idv.cjcat.stardustextended.threeD.particles.Particle3DFactory;
	
	/**
	 * Base class for 3D bursters.
	 */
	public class Burster3D extends Burster {
		
		public function Burster3D() {
			factory = new Particle3DFactory();
		}
	}
}