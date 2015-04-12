package idv.cjcat.stardustextended.threeD.initializers {
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.threeD.geom.MotionData3D;
	import idv.cjcat.stardustextended.threeD.geom.MotionData3DPool;
	import idv.cjcat.stardustextended.threeD.particles.Particle3D;
	import idv.cjcat.stardustextended.threeD.zones.SinglePoint3D;
	import idv.cjcat.stardustextended.threeD.zones.Zone3D;
	
	/**
	 * Sets a particle's velocity based on the <code>zone</code> property.
	 * 
	 * <p>
	 * A particle's velocity is determined by a random point in the zone. 
	 * (The vector pointing from the origin to the random point).
	 * </p>
	 */
	public class Velocity3D extends Initializer3D {
		
		private var _zone:Zone3D;
		public function Velocity3D(zone:Zone3D = null) {
			this.zone = zone;
		}
		
		override public final function initialize(particle:Particle):void {
			var p3D:Particle3D = Particle3D(particle);
			var md3D:MotionData3D = zone.getPoint();
			p3D.vx = md3D.x;
			p3D.vy = md3D.y;
			p3D.vz = md3D.z;
			MotionData3DPool.recycle(md3D);
		}
		
		public function get zone():Zone3D { return _zone; }
		public function set zone(value:Zone3D):void {
			if (!value) value = new SinglePoint3D(0, 0);
			_zone = value;
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObjects():Array {
			return [_zone];
		}
		
		override public function getXMLTagName():String {
			return "Velocity3D";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@zone = zone.name;
			
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