package idv.cjcat.stardustextended.common.handlers {
	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.StardustElement;
	
	/**
	 * A particle handler is assigned to a particle by using the <code>Handler</code> initializer. 
	 * A handler monitors the beginning of an emitter step, the end of an emitter step, 
	 * the adding of a new particle, and the removal of a dead particle. 
	 * Also, the <code>readParticle()<code> method is used to read data out of <code>Particle</code> 
	 * objects when each paritcle is completely updated by actions.
	 */
	public class ParticleHandler extends StardustElement {
		
		private static var _singleton:ParticleHandler;
		public static function getSingleton():ParticleHandler {
			if (!_singleton) _singleton = new ParticleHandler();
			return _singleton;
		}
		
		public function ParticleHandler() {
			
		}
		
		/**
		 * [Abstract Method] Invoked when each emitter step begins.
		 * @param	emitter
		 * @param	particles
		 * @param	time
		 */
		public function stepBegin(emitter:Emitter, particles:Vector.<Particle>, time:Number):void {
			
		}
		
		/**
		 * [Abstract Method] Invoked when each emitter step ends.
		 * @param	emitter
		 * @param	particles
		 * @param	time
		 */
		public function stepEnd(emitter:Emitter, particles:Vector.<Particle>, time:Number):void {
			
		}
		
		/**
		 * [Abstract Method] Invoked for each particle added.
		 * Handle particle creation in this method.
		 * @param	particle
		 */
		public function particleAdded(particle:Particle):void {
			
		}
		
		/**
		 * [Abstract Method] Invoked for each particle removed.
		 * Handle particle removal in this method.
		 * @param	particle
		 */
		public function particleRemoved(particle:Particle):void {
			
		}
		
		/**
		 * [Abstract Method] Invoked for each particle when each particle's actions are all executed. 
		 * Read out the particle's data in this method.
		 * @param	particle
		 */
		public function readParticle(particle:Particle):void {
			
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "ParticleHandler";
		}
		
		override public function getElementTypeXMLTag():XML {
			return <handlers/>;
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}