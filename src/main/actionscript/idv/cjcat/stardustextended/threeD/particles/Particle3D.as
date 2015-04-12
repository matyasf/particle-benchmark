package idv.cjcat.stardustextended.threeD.particles {
	import idv.cjcat.stardustextended.common.particles.Particle;
	
	public class Particle3D extends Particle {
		
		public var x:Number;
		public var y:Number;
		public var z:Number;
		public var screenX:Number;
		public var screenY:Number;
		public var vx:Number;
		public var vy:Number;
		public var vz:Number;
		public var screenVX:Number;
		public var screenVY:Number;
		public var rotationX:Number;
		public var rotationY:Number;
		public var rotationZ:Number;
		public var omegaX:Number;
		public var omegaY:Number;
		public var omegaZ:Number;
		
		public function Particle3D() {
			
		}
		
		override public final function init():void {
			super.init();
			
			x = 0;
			y = 0;
			z = 0;
			screenX = 0;
			screenY = 0;
			vx = 0;
			vy = 0;
			vz = 0;
			screenVX = 0;
			screenVY = 0;
			rotationX = 0;
			rotationY = 0;
			rotationZ = 0;
			omegaX = 0;
			omegaY = 0;
			omegaZ = 0;
		}
	}
}