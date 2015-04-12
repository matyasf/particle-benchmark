package idv.cjcat.stardustextended.twoD.actions {

import idv.cjcat.stardustextended.common.emitters.Emitter;
import idv.cjcat.stardustextended.common.particles.Particle;
import idv.cjcat.stardustextended.common.xml.XMLBuilder;
import idv.cjcat.stardustextended.twoD.geom.Vec2D;
import idv.cjcat.stardustextended.twoD.geom.Vec2DPool;
import idv.cjcat.stardustextended.twoD.particles.Particle2D;
import idv.cjcat.stardustextended.twoD.zones.RectZone;
import idv.cjcat.stardustextended.twoD.zones.Zone;
	
	/**
	 * Causes particles to change acceleration specified zone.
	 * 
	 * <p>
	 * Default priority = -6;
	 * </p>
	 */
	public class AccelerationZone extends Action2D implements IZoneContainer {

        public function get zone():Zone { return _zone; }
        public function set zone(value:Zone):void {
            if (!value) value = new RectZone();
            _zone = value;
        }
		private var _zone:Zone;
		/**
		 * Inverts the zone region.
		 */
		public var inverted:Boolean;

		/**
		 * The acceleration applied in each step to particles inside the zone.
		 * Default is 1.
		 */
		public var acceleration:Number;
		/**
		 * Flag whether to use the particle's speed or the direction variable. Default is true.
		 */
		public var useParticleDirection:Boolean;


		private var _direction : Vec2D;
		/**
		 * the direction of the acceleration. Only used if useParticleDirection is true
		 */
		public function get direction():Vec2D { return _direction; }

		public function set direction(value:Vec2D):void {
			value.length = 1;
			_direction = value;
		}

		public function AccelerationZone(zone:Zone = null, inverted:Boolean = false) {
			priority = -6;
			
			this.zone = zone;
			this.inverted = inverted;
			acceleration = 1;
			useParticleDirection = true;
			_direction = new Vec2D(1, 0);
		}
		
		override public function update(emitter:Emitter, particle:Particle, timeDelta:Number, currentTime:Number):void {
			var p2D : Particle2D = Particle2D(particle);
			var affected : Boolean = _zone.contains(p2D.x, p2D.y);
			if (inverted)
			{
				affected = !affected;
			}
			if (affected)
			{
				if (useParticleDirection)
				{
					var v : Vec2D = Vec2DPool.get(p2D.vx, p2D.vy);
					const vecLength : Number = v.length;
					if (vecLength > 0) {
						var finalVal : Number = vecLength + acceleration * timeDelta;
						if (finalVal < 0) {
							finalVal = 0;
						}
						v.length = finalVal;
						p2D.vx = v.x;
						p2D.vy = v.y;
					}
					Vec2DPool.recycle(v);
				}
				else
				{
					var finalX : Number = p2D.vx + acceleration * _direction.x * timeDelta;
					var finalY : Number = p2D.vy + acceleration * _direction.y * timeDelta;
					p2D.vx = finalX;
					p2D.vy = finalY;
				}
			}
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObjects():Array {
			return [_zone];
		}
		
		override public function getXMLTagName():String {
			return "AccelerationZone";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			xml.@zone = _zone.name;
			xml.@inverted = inverted;
			xml.@acceleration = acceleration;
			xml.@useParticleDirection = useParticleDirection;
			xml.@directionX = _direction.x;
			xml.@directionY = _direction.y;
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			_zone = builder.getElementByName(xml.@zone) as Zone;
			inverted = (xml.@inverted == "true");
			acceleration = parseFloat(xml.@acceleration);
			useParticleDirection = (xml.@useParticleDirection == "true");
			_direction.x = parseFloat(xml.@directionX);
			_direction.y = parseFloat(xml.@directionY);
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}