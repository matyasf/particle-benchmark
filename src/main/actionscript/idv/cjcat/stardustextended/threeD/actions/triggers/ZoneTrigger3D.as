package idv.cjcat.stardustextended.threeD.actions.triggers {
	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.threeD.particles.Particle3D;
	import idv.cjcat.stardustextended.threeD.zones.SinglePoint3D;
	import idv.cjcat.stardustextended.threeD.zones.Zone3D;
	
	/**
	 * This action trigger is triggered when a particle is contained in a zone.
	 * 
	 * <p>
	 * Default priority = -6;
	 * </p>
	 */
	public class ZoneTrigger3D extends ActionTrigger3D {
		
		private var _zone:Zone3D;
		public function ZoneTrigger3D(zone:Zone3D = null) {
			priority = -6;
			
			this.zone = zone;
		}
		
		public function get zone():Zone3D { return _zone; }
		public function set zone(value:Zone3D):void {
			if (!value) value = new SinglePoint3D(0, 0);
			_zone = value;
		}
		
		override public final function testTrigger(emitter:Emitter, particle:Particle, time:Number):Boolean {
			var p3D:Particle3D = Particle3D(particle);
			return _zone.contains(p3D.x, p3D.y, p3D.z);
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObjects():Array {
			return [_zone];
		}
		
		override public function getXMLTagName():String {
			return "ZoneTrigger3D";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@zone = _zone.name;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@zone.length()) zone = builder.getElementByName(xml.@zone) as Zone3D;
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}