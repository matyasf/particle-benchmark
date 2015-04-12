package idv.cjcat.stardustextended.twoD.initializers {
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
import idv.cjcat.stardustextended.twoD.actions.IZoneContainer;
import idv.cjcat.stardustextended.twoD.geom.MotionData2D;
	import idv.cjcat.stardustextended.twoD.geom.MotionData2DPool;
	import idv.cjcat.stardustextended.twoD.particles.Particle2D;
	import idv.cjcat.stardustextended.twoD.zones.SinglePoint;
	import idv.cjcat.stardustextended.twoD.zones.Zone;
	
	/**
	 * Sets a particle's position based on the <code>zone</code> property.
	 * 
	 * <p>
	 * A particle's position is determined by a random point in the zone.
	 * </p>
	 */
	public class Position extends Initializer2D implements IZoneContainer {
		
		private var _zone:Zone;
		public function Position(zone:Zone = null) {
			this.zone = zone;
		}
		
		override public function initialize(particle:Particle):void {
			var p2D:Particle2D = Particle2D(particle);
			var md2D:MotionData2D = zone.getPoint();
			p2D.x = md2D.x;
			p2D.y = md2D.y;
			MotionData2DPool.recycle(md2D);
		}
		
		public function get zone():Zone { return _zone; }
		public function set zone(value:Zone):void {
			if (!value) value = new SinglePoint(0, 0);
			_zone = value;
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObjects():Array {
			return [_zone];
		}
		
		override public function getXMLTagName():String {
			return "Position";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@zone = zone.name;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@zone.length()) zone = builder.getElementByName(xml.@zone) as Zone;
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}