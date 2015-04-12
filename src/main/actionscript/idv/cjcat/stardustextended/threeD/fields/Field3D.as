package idv.cjcat.stardustextended.threeD.fields {
	import idv.cjcat.stardustextended.common.StardustElement;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.threeD.geom.MotionData3D;
	import idv.cjcat.stardustextended.threeD.geom.MotionData3DPool;
	import idv.cjcat.stardustextended.threeD.particles.Particle3D;
	
	/**
	 * 3D vector field.
	 */
	public class Field3D extends StardustElement {
		
		public var active:Boolean;
		public var massless:Boolean;
		
		public function Field3D() {
			active = true;
			massless = true;
		}
		
		public final function getMotionData3D(particle:Particle3D):MotionData3D {
			if (!active) return MotionData3DPool.get(0, 0, 0);
			
			var md3D:MotionData3D = calculateMotionData3D(particle);
			if (!massless) {
				var mass_inv:Number = 1 / particle.mass;
				md3D.x *= mass_inv;
				md3D.y *= mass_inv;
				md3D.z *= mass_inv;
			}
			return md3D;
		}
		
		protected function calculateMotionData3D(particle:Particle3D):MotionData3D {
			return null;
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "Field3D";
		}
		
		override public function getElementTypeXMLTag():XML {
			return <fields/>;
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@active = active;
			xml.@massless = massless;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@active.length()) active = (xml.@active == "action");
			if (xml.@massless.length()) massless = (xml.@active == "massless");
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}