package idv.cjcat.stardustextended.common.actions.triggers {
	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	
	/**
	 * This trigger will be triggered when a particle's life is a multiple of the <code>triggerEvery</code> property.
	 * 
	 * <p>
	 * For instance, when the <code>triggerEvery</code> property is set to 2. This trigger will be triggered every two function calls of the <code>Emitter.step()</code> method,
	 * if the emitter's <code>stepTimeInterval</code> property is 1.
	 * </p>
	 * 
	 * <p>
	 * Default priority = -5;
	 * </p>
	 */
	public class LifeTrigger extends ActionTrigger {
		
		/**
		 * For this trigger to work, a particle's life must also be within the lower and upper bounds when this property is set to true, 
		 * or outside of the range if this property is set to false.
		 */
		public var triggerWithinBounds: Boolean;
		/**
		 * The trigger is triggered if a particle's life is a multiple of this property.
		 */
		public var triggerEvery:Number;
		private var _lowerBound:Number;
		private var _upperBound:Number;
		public function LifeTrigger(lowerBound:Number = 0, upperBound:Number = Number.MAX_VALUE, triggerWithinBounds:Boolean = true, triggerEvery:Number = 1 ) {
			priority = -5;
			
			this.lowerBound = lowerBound;
			this.upperBound = upperBound;
			this.triggerWithinBounds = triggerWithinBounds;
			this.triggerEvery = triggerEvery;
		}
		
		override public final function testTrigger(emitter:Emitter, particle:Particle, time:Number):Boolean {
			if (triggerWithinBounds) {
				if ((particle.life >= lowerBound) && (particle.life <= upperBound)) {
					return (particle.life % triggerEvery < time);
				}
			} else {
				if ((particle.life < lowerBound) || (particle.life > upperBound)) {
					return (particle.life % triggerEvery < time);
				}
			}
			return false;
		}
		
		/**
		 * The lower bound of effective range.
		 */
		public function get lowerBound():Number { return _lowerBound; }
		public function set lowerBound(value:Number):void {
			if (value > _upperBound) _upperBound = value;
			_lowerBound = value;
		}
		
		/**
		 * The upper bound of effectivce range.
		 */
		public function get upperBound():Number { return _upperBound; }
		public function set upperBound(value:Number):void {
			if (value < _lowerBound) _lowerBound = value;
			_upperBound = value;
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "LifeTrigger";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			if (xml.@triggerWithinBounds.length()) xml.@triggerWithinBounds = triggerWithinBounds;
			if (xml.@triggerEvery.length()) xml.@triggerEvery = triggerEvery;
			if (xml.@lowerBound.length()) xml.@lowerBound = lowerBound;
			if (xml.@upperBound.length()) xml.@upperBound = upperBound;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			triggerWithinBounds = (xml.@triggerWithinBounds == "true");
			triggerEvery = parseFloat(xml.@triggerEvery);
			lowerBound = parseFloat(xml.@lowerBound);
			upperBound = parseFloat(xml.@upperBound);
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}