package idv.cjcat.stardustextended.common.handlers {

	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.particles.Particle;
	
	/**
	 * This handler works as a polling station. Use it as an ordinary particle handler, 
	 * and after each emitter step, you may poll the <code>particlesAdded</code>, <code>particlesRemoved</code>, and <code>particles</code> properties 
	 * in order to traverse the new particles added, the removed dead particles, and the particles that are currently living, 
	 * respectively, after each emitter step.
	 */
	public final class PollingStation extends ParticleHandler {
		
		private var _particlesAdded:Vector.<Particle> = new Vector.<Particle>;
		public final function get particlesAdded():Vector.<Particle> { return _particlesAdded; }
		
		private var _particlesRemoved:Vector.<Particle> = new Vector.<Particle>;
		public final function get particlesRemoved():Vector.<Particle> { return _particlesRemoved;}
		
		private var _emitter:Emitter;
		public final function get particles():Vector.<Particle> {
			return (Boolean(_emitter))?(_emitter.particles):(null);
		}
		
		public function PollingStation() {
			
		}
		
		override public final function stepBegin(emitter:Emitter, particles:Vector.<Particle>, time:Number):void {
			_particlesAdded = new Vector.<Particle>();
			_particlesRemoved = new Vector.<Particle>();
			_emitter = emitter;
		}
		
		override public final function particleAdded(particle:Particle):void {
			_particlesAdded.push(particle);
		}
		
		override public final function particleRemoved(particle:Particle):void {
			_particlesRemoved.push(particle);
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "PollingStation";
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}