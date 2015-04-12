package idv.cjcat.stardustextended.twoD.particles {
	import idv.cjcat.stardustextended.common.particles.Particle;
	
	/**
	 * This class represents a 2D particle and its properties.
	 */
	public class Particle2D extends Particle {
		
		public var x:Number;
		public var y:Number;
		public var vx:Number;
		public var vy:Number;
		public var rotation:Number;
		public var omega:Number;
		
		public function Particle2D() {
			
		}
		
		override public function init():void {
			super.init();
			
			x = 0;
			y = 0;
			vx = 0;
			vy = 0;
			rotation = 0;
			omega = 0;
		}
	}
}