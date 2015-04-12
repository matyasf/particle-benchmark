package idv.cjcat.stardustextended.twoD.deflectors {
	import idv.cjcat.stardustextended.common.StardustElement;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.twoD.geom.MotionData4D;
	import idv.cjcat.stardustextended.twoD.particles.Particle2D;
	
	/**
	 * Used along with the <code>Deflect</code> action.
	 * 
	 * @see idv.cjcat.stardustextended.twoD.actions.Deflect
	 */
	public class Deflector extends StardustElement {
		
		public var active:Boolean;
		public var bounce:Number;
		/**
		 * Determines how slippery the surfaces are. A value of 1 (default) means that the surface is fully slippery,
		 * a value of 0 means that particles will not slide on its surface at all.
		 */
		public var slipperiness:Number;

		public function Deflector() {
			active = true;
			bounce = 0.8;
			slipperiness = 1;
		}
		
		public final function getMotionData4D(particle:Particle2D):MotionData4D {
			if (active) {
				return calculateMotionData4D(particle);
			}
			return null;
		}
		
		/**
		 * [Abstract Method] Returns a <code>MotionData4D</code> object representing the deflected position and velocity coordinates for a particle. 
		 * Returns null if no deflection occurred. A non-null value can trigger the <code>DeflectorTrigger</code> action trigger.
		 * @param	particle
		 * @return
		 * @see idv.cjcat.stardustextended.twoD.actions.triggers.DeflectorTrigger
		 */
		protected function calculateMotionData4D(particle:Particle2D):MotionData4D {
			//abstract method
			return null;
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "Deflector";
		}
		
		override public function getElementTypeXMLTag():XML {
			return <deflectors/>;
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			xml.@active = active;
			xml.@bounce = bounce;
			xml.@slipperiness = slipperiness;
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@active.length()) active = (xml.@active == "true");
			if (xml.@bounce.length()) bounce = parseFloat(xml.@bounce);
			if (xml.@slipperiness.length()) slipperiness = parseFloat(xml.@slipperiness);
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}