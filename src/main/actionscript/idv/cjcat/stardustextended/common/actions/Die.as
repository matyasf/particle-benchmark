package idv.cjcat.stardustextended.common.actions {
	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.particles.Particle;
	
	/**
	 * Instantly marks a particle as dead.
	 * 
	 * <p>
	 * This action should be used with action triggers. 
	 * If this action is directly added to an emitter, all particles will be marked dead upon birth.
	 * </p>
	 */
	public class Die extends Action {
		
		public function Die() {
			
		}
		
		override public final function update(emitter:Emitter, particle:Particle, timeDelta:Number, currentTime:Number):void {
			particle.isDead = true;
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "Die";
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}