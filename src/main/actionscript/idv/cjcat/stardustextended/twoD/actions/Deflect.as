package idv.cjcat.stardustextended.twoD.actions {

	import idv.cjcat.stardustextended.common.actions.Action;
	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.twoD.actions.triggers.DeflectorTrigger;
	import idv.cjcat.stardustextended.twoD.deflectors.Deflector;
	import idv.cjcat.stardustextended.twoD.geom.MotionData4D;
	import idv.cjcat.stardustextended.twoD.particles.Particle2D;
	

	/**
	 * This action is useful to manipulate a particle's position and velocity as you like.
	 * 
	 * <p>
	 * Each deflector returns a <code>MotionData4D</code> object, which contains four numeric properties: x, y, vx, and vy, 
	 * according to the particle's position and velocity.
	 * The particle's position and velocity are then reassigned to the new values (x, y) and (vx, vy), respectively.
	 * </p>
	 * 
	 * <p>
	 * Deflectors can be used to create obstacles, bounding boxes, etc. 
	 * </p>
	 * 
	 * <p>
	 * Default priority = -5;
	 * </p>
	 * 
	 * @see idv.cjcat.stardustextended.twoD.deflectors.Deflector
	 */
	public class Deflect extends Action2D {
		
		protected var _deflectors:Array;
		protected var hasTrigger:Boolean;

		public function Deflect() {
			priority = -5;
			_deflectors = [];
		}
		
		/**
		 * Adds a deflector to the simulation.
		 * @param	deflector
		 */
		public function addDeflector(deflector:Deflector):void {
			if (_deflectors.indexOf(deflector) < 0) _deflectors.push(deflector);
		}
		
		/**
		 * Removes a deflector from the simulation.
		 * @param	deflector
		 */
		public function removeDeflector(deflector:Deflector):void {
			var index:int = _deflectors.indexOf(deflector);
			if (index >= 0) _deflectors.splice(index, 1);
		}
		
		/**
		 * Removes all deflectors from the simulation.
		 */
		public function clearDeflectors():void {
			_deflectors = [];
		}

		public function get deflectors():Array {
			return _deflectors;
		}

		override public function update(emitter:Emitter, particle:Particle, timeDelta:Number, currentTime:Number):void {
			var p2D : Particle2D = Particle2D(particle);
			for each (var deflector : Deflector in _deflectors) {
				var md4D : MotionData4D = deflector.getMotionData4D(p2D);
				if (md4D) {
					if (hasTrigger)	p2D.dictionary[deflector] = true;
					p2D.x = md4D.x;
					p2D.y = md4D.y;
					p2D.vx = md4D.vx;
					p2D.vy = md4D.vy;
				} else if (hasTrigger) {
					p2D.dictionary[deflector] = false;
				}
			}
		}

		override public function preUpdate(emitter:Emitter, time:Number):void {
			for each (var action:Action in emitter.actions)
			{
				if (action is DeflectorTrigger)
				{
					hasTrigger = true;
					return;
				}
			}
			hasTrigger = false;
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObjects():Array {
			return _deflectors;
		}
		
		override public function getXMLTagName():String {
			return "Deflect";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			if (_deflectors.length > 0) {
				xml.appendChild(<deflectors/>);
				var deflector:Deflector;
				for each (deflector in _deflectors) {
					xml.deflectors.appendChild(deflector.getXMLTag());
				}
			}
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			clearDeflectors();
			for each (var node:XML in xml.deflectors.*) {
				addDeflector(builder.getElementByName(node.@name) as Deflector);
			}
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}