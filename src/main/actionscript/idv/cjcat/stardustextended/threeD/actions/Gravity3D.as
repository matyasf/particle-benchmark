package idv.cjcat.stardustextended.threeD.actions {
	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.sd;
	import idv.cjcat.stardustextended.threeD.fields.Field3D;
	import idv.cjcat.stardustextended.threeD.geom.MotionData3D;
	import idv.cjcat.stardustextended.threeD.geom.MotionData3DPool;
	import idv.cjcat.stardustextended.threeD.particles.Particle3D;
	
	use namespace sd;
	
	/**
	 * Applies accelerations to particles according to the associated gravity fields.
	 * 
	 * <p>
	 * Default priority = -3;
	 * </p>
	 */
	public class Gravity3D extends Action3D {
		
		/** @private */
		sd var fields:Array;
		
		public function Gravity3D() {
			priority = -3;
			
			fields = [];
		}
		
		/**
		 * Adds a gravity field to the simulation.
		 * @param	field
		 */
		public final function addField(field:Field3D):void {
			if (fields.indexOf(field) < 0) fields.push(field);
		}
		
		/**
		 * Removes a gravity field from the simulation.
		 * @param	field
		 */
		public final function removeField(field:Field3D):void {
			var index:int = fields.indexOf(field);
			if (index >= 0) fields.splice(index, 1);
		}
		
		/**
		 * Removes all gravity fields from the simulation.
		 */
		public final function clearFields():void {
			fields = [];
		}
		
		private var p3D:Particle3D;
		private var field:Field3D;
		private var md3D:MotionData3D;
		override public final function update(emitter:Emitter, particle:Particle, timeDelta:Number, currentTime:Number):void {
			p3D = Particle3D(particle);
			for each (field in fields) {
				md3D = field.getMotionData3D(p3D);
				if (md3D) {
					p3D.vx += md3D.x * timeDelta;
					p3D.vy += md3D.y * timeDelta;
					p3D.vz += md3D.z * timeDelta;
					MotionData3DPool.recycle(md3D);
					md3D = null;
				}
			}
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObjects():Array {
			return fields;
		}
		
		override public function getXMLTagName():String {
			return "Gravity3D";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			if (fields.length > 0) {
				xml.appendChild(<fields/>);
				var field:Field3D;
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
				addField(builder.getElementByName(node.@name) as Field3D);
			}
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}