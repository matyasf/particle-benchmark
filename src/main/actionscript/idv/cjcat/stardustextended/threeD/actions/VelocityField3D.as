package idv.cjcat.stardustextended.threeD.actions {
	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.threeD.fields.Field3D;
	import idv.cjcat.stardustextended.threeD.geom.MotionData3D;
	import idv.cjcat.stardustextended.threeD.geom.MotionData3DPool;
	import idv.cjcat.stardustextended.threeD.particles.Particle3D;
	
	/**
	 * Alters a particle's velocity based on a vector field.
	 * 
	 * <p>
	 * The returned value of a field is a <code>MotionData3D</code> object, which is a 3D value class. 
	 * The particle's velocity X, Y, and Z components are set to the <code>MotionData3D</code> object's <code>x</code>, <code>y</code>, and <code>z</code> properties, respectively.
	 * </p>
	 * 
	 * <p>
	 * Default priority = -2;
	 * </p>
	 */
	public class VelocityField3D extends Action3D {
		
		public var field:Field3D;
		public function VelocityField3D(field:Field3D = null) {
			priority = -2;
			
			this.field = field;
		}
		
		override public final function update(emitter:Emitter, particle:Particle, timeDelta:Number, currentTime:Number):void {
			if (!field) return;
			
			var p3D:Particle3D = Particle3D(particle);
			var md3D:MotionData3D = field.getMotionData3D(p3D);
			p3D.vx = md3D.x;
			p3D.vy = md3D.y;
			p3D.vz = md3D.z;
			MotionData3DPool.recycle(md3D);
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "VelocityField3D";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			if (!field) xml.@field = "null";
			else xml.@field = field.name;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@field == "null") field = null;
			else if (xml.@field.length()) field = builder.getElementByName(xml.@field) as Field3D;
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}