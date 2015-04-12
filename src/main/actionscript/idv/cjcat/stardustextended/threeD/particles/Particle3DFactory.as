package idv.cjcat.stardustextended.threeD.particles {
	import flash.errors.IllegalOperationError;
	import flash.utils.getQualifiedClassName;
	import idv.cjcat.stardustextended.common.initializers.Initializer;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.particles.ParticleFactory;
	import idv.cjcat.stardustextended.sd;

	public class Particle3DFactory extends ParticleFactory {
		
		public function Particle3DFactory() {
			
		}
		
		override protected final function createNewParticle():Particle {
			return new Particle3D();
		}
		
		override public final function addInitializer(initializer:Initializer):void {
			if (!initializer.supports3D) {
				throw new IllegalOperationError("This initializer does not support 3D: " + getQualifiedClassName(Object(initializer).constructor as Class));
			}
			super.addInitializer(initializer);
		}
	}
}