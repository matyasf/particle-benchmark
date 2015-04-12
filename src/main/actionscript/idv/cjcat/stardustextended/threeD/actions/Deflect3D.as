package idv.cjcat.stardustextended.threeD.actions {
	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.sd;
	import idv.cjcat.stardustextended.threeD.deflectors.Deflector3D;
	import idv.cjcat.stardustextended.threeD.geom.MotionData6D;
	import idv.cjcat.stardustextended.threeD.geom.MotionData6DPool;
	import idv.cjcat.stardustextended.threeD.particles.Particle3D;
	
	use namespace sd;
	
	/**
	 * This action is useful to manipulate a particle's position and velocity as you like.
	 * 
	 * <p>
	 * Each deflector returns a <code>MotionData6D</code> object, which contains four numeric properties: x, y, z, vx, vy, and vz, 
	 * according to the particle's positoin and velocity. 
	 * The particle's position and velocity are then reassigned to the new values (x, y, z) and (vx, vy, vz), respectively.
	 * </p>
	 * 
	 * <p>
	 * Deflectors can be used to create obstacles, bounding boxes, etc. 
	 * </p>
	 * 
	 * <p>
	 * Default priority = -5;
	 * </p>
	 */
	public class Deflect3D extends Action3D {
		
		/** @private */
		sd var deflectors:Array;
		
		public function Deflect3D() {
			priority = -5;
			
			deflectors = [];
		}
		
		/**
		 * Adds a deflector to the simulation.
		 * @param	deflector
		 */
		public final function addDeflector(deflector:Deflector3D):void {
			if (deflectors.indexOf(deflector) < 0) deflectors.push(deflector);
		}
		
		/**
		 * Removes a deflector from the simulation.
		 * @param	deflector
		 */
		public final function removeDeflector(deflector:Deflector3D):void {
			var index:int = deflectors.indexOf(deflector);
			if (index >= 0) deflectors.splice(index, 1);
		}
		
		/**
		 * Removes all deflectors from the simulation.
		 */
		public final function clearDeflectors():void {
			deflectors = [];
		}
		
		private var p3D:Particle3D;
		private var deflector:Deflector3D;
		private var md6D:MotionData6D;
		override public final function update(emitter:Emitter, particle:Particle, timeDelta:Number, currentTime:Number):void {
			p3D = Particle3D(particle);
			for each (deflector in deflectors) {
				md6D = deflector.getMotionData6D(p3D);
				if (md6D) {
					p3D.dictionary[deflector] = true;
					p3D.x = md6D.x;
					p3D.y = md6D.y;
					p3D.z = md6D.z;
					p3D.vx = md6D.vx;
					p3D.vy = md6D.vy;
					p3D.vz = md6D.vz;
					MotionData6DPool.recycle(md6D);
					md6D = null;
				} else {
					p3D.dictionary[deflector] = false;
				}
			}
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObjects():Array {
			return deflectors;
		}
		
		override public function getXMLTagName():String {
			return "Deflect3D";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			if (deflectors.length > 0) {
				xml.appendChild(<deflectors/>);
				var deflector:Deflector3D;
				for each (deflector in deflectors) {
					xml.deflectors.appendChild(deflector.getXMLTag());
				}
			}
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			clearDeflectors();
			for each (var node:XML in xml.deflectors.*) {
				addDeflector(builder.getElementByName(node.@name) as Deflector3D);
			}
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}