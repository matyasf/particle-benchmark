package idv.cjcat.stardustextended.twoD.particles {
	import flash.errors.IllegalOperationError;
	import flash.utils.getQualifiedClassName;
	import idv.cjcat.stardustextended.common.initializers.Initializer;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.particles.ParticleFactory;
	
	public class Particle2DFactory extends ParticleFactory {
		
		public function Particle2DFactory() {
			
		}
		
		override protected function createNewParticle():Particle {
			return new Particle2D();
		}
		
		override public function addInitializer(initializer:Initializer):void {
			if (!initializer.supports2D) {
				throw new IllegalOperationError("This initializer does not support 2D: " + getQualifiedClassName(Object(initializer).constructor as Class));
			}
			super.addInitializer(initializer);
		}
	}
}