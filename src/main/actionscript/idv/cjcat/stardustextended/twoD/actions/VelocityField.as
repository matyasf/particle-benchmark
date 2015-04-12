package idv.cjcat.stardustextended.twoD.actions {
	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.twoD.fields.Field;
	import idv.cjcat.stardustextended.twoD.geom.MotionData2D;
	import idv.cjcat.stardustextended.twoD.geom.MotionData2DPool;
	import idv.cjcat.stardustextended.twoD.particles.Particle2D;
	
	/**
	 * Alters a particle's velocity based on a vector field.
	 * 
	 * <p>
	 * The returned value of a field is a <code>MotionData2D</code> object, which is a 2D value class. 
	 * The particle's velocity X and Y components are set to the <code>MotionData2D</code> object's <code>x</code> and <code>y</code> properties, respectively.
	 * </p>
	 * 
	 * <p>
	 * Default priority = -2;
	 * </p>
	 */
	public class VelocityField extends Action2D {
		
		public var field:Field;
		public function VelocityField(field:Field = null) {
			priority = -2;
			
			this.field = field;
		}
		
		override public function update(emitter:Emitter, particle:Particle, timeDelta:Number, currentTime:Number):void {
			if (!field) return;
			
			var p2D:Particle2D = Particle2D(particle);
			var md2D:MotionData2D = field.getMotionData2D(p2D);
			p2D.vx = md2D.x;
			p2D.vy = md2D.y;
			MotionData2DPool.recycle(md2D);
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObjects():Array {
			if (field != null) return [field];
			else return [];
		}
		
		override public function getXMLTagName():String {
			return "VelocityField";
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
			else if (xml.@field.length()) field = builder.getElementByName(xml.@field) as Field;
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}