package idv.cjcat.stardustextended.common.actions.triggers {
	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.particles.Particle;
	
	/**
	 * This action trigger will be triggered if a particle is dead.
	 * 
	 * <p>
	 * Default priority = -20;
	 * </p>
	 */
	public class DeathTrigger extends ActionTrigger {
		
		public function DeathTrigger() {
			priority = -20;
		}
		
		override public final function testTrigger(emitter:Emitter, particle:Particle, time:Number):Boolean {
			return particle.isDead;
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "DeathTrigger";
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}