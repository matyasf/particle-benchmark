package idv.cjcat.stardustextended.twoD.actions {
	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.twoD.actions.Action2D;
	import idv.cjcat.stardustextended.twoD.fields.Field;
	import idv.cjcat.stardustextended.twoD.fields.UniformField;
	import idv.cjcat.stardustextended.twoD.geom.MotionData2D;
	import idv.cjcat.stardustextended.twoD.geom.MotionData2DPool;
	import idv.cjcat.stardustextended.twoD.particles.Particle2D;
	
	/**
	 * Applies an instant acceleration to particles based on the <code>field</code> property.
	 * 
	 * @see idv.cjcat.stardustextended.twoD.fields.Field
	 */
	public class Impulse extends Action2D {
		
		private var _field:Field;
		
		public function Impulse(field:Field = null) {
			this.field = field;
			_discharged = true;
		}
		
		public function get field():Field { return _field; }
		public function set field(value:Field):void {
			if (!value) value = new UniformField(0, 0);
			_field = value;
		}
		
		private var _discharged:Boolean;
		/**
		 * Applies an instant acceleration to particles based on the <code>field</code> property.
		 * @param	e
		 */
		public function impulse():void {
			_discharged = false;
		}
		
		override public function update(emitter:Emitter, particle:Particle, timeDelta:Number, currentTime:Number):void {
			if (_discharged) return;
			
			var p2D:Particle2D = Particle2D(particle);
			var md2D:MotionData2D = field.getMotionData2D(p2D);
			p2D.vx += md2D.x * timeDelta;
			p2D.vy += md2D.y * timeDelta;
			MotionData2DPool.recycle(md2D);
		}
		
		override public function postUpdate(emitter:Emitter, time:Number):void {
			_discharged = true;
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObjects():Array {
			return [_field];
		}
		
		override public function getXMLTagName():String {
			return "Impulse";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@field = field.name;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@field.length()) field = builder.getElementByName(xml.@field) as Field;
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}