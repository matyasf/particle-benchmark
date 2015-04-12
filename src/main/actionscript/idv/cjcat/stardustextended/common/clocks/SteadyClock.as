package idv.cjcat.stardustextended.common.clocks {
	import idv.cjcat.stardustextended.common.math.StardustMath;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	
	/**
	 * Causes the emitter to create particles at a steady rate.
	 */
	public class SteadyClock extends Clock {
		
		/**
		 * How many particles to create in each emitter step.
		 * 
		 * <p>
		 * If less than one, it's the probability of an emitter to create a single particle in each step.
		 * </p>
		 */
		public var ticksPerCall:Number;
		
		public function SteadyClock(ticksPerCall:Number = 0) {
			this.ticksPerCall = ticksPerCall;
		}
		
		override public final function getTicks(time:Number):int {
			return StardustMath.randomFloor(ticksPerCall * time);
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "SteadyClock";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@ticksPerCall = ticksPerCall;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@ticksPerCall.length()) ticksPerCall = parseFloat(xml.@ticksPerCall);
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}