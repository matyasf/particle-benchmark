package idv.cjcat.stardustextended.twoD.actions {
	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.twoD.fields.Field;
	import idv.cjcat.stardustextended.twoD.geom.MotionData2D;
	import idv.cjcat.stardustextended.twoD.geom.MotionData2DPool;
	import idv.cjcat.stardustextended.twoD.particles.Particle2D;
	
	/**
	 * Applies accelerations to particles according to the associated gravity fields, in pixels.
	 * 
	 * <p>
	 * Default priority = -3;
	 * </p>
	 * 
	 * @see idv.cjcat.stardustextended.twoD.fields.Field
	 */
	public class Gravity extends Action2D {

		public var fields : Vector.<Field>;
		
		public function Gravity() {
			priority = -3;
			fields = new Vector.<Field>();
		}
		
		/**
		 * Adds a gravity field to the simulation.
		 * @param	field
		 */
		public function addField(field:Field):void {
			if (fields.indexOf(field) < 0) fields.push(field);
		}
		
		/**
		 * Removes a gravity field from the simulation.
		 * @param	field
		 */
		public function removeField(field:Field):void {
			var index:int = fields.indexOf(field);
			if (index >= 0) fields.splice(index, 1);
		}
		
		/**
		 * Removes all gravity fields from the simulation.
		 */
		public function clearFields():void {
			fields = new Vector.<Field>();
		}

		override public function update(emitter:Emitter, particle:Particle, timeDelta:Number, currentTime:Number):void {
			const p2D : Particle2D = Particle2D(particle);
            var md2D : MotionData2D;
			for (var i : int = 0; i < fields.length; i++) {
				md2D = fields[i].getMotionData2D(p2D);
				if (md2D) {
					p2D.vx += md2D.x * timeDelta;
					p2D.vy += md2D.y * timeDelta;
					MotionData2DPool.recycle(md2D);
				}
			}
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObjects():Array {
            const result:Array = [];
            for(var i : int = 0; i < fields.length; i++) {
                result[result.length] = fields[i];
            }
			return result;
		}
		
		override public function getXMLTagName():String {
			return "Gravity";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			if (fields.length > 0) {
				xml.appendChild(<fields/>);
				var field:Field;
				for each (field in fields) {
					xml.fields.appendChild(field.getXMLTag());
				}
			}
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			clearFields();
			for each (var node:XML in xml.fields.*) {
				addField(builder.getElementByName(node.@name) as Field);
			}
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}