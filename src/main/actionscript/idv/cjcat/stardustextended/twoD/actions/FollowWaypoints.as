package idv.cjcat.stardustextended.twoD.actions {
	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.twoD.actions.waypoints.Waypoint;
	import idv.cjcat.stardustextended.twoD.geom.Vec2D;
	import idv.cjcat.stardustextended.twoD.geom.Vec2DPool;
	import idv.cjcat.stardustextended.twoD.particles.Particle2D;
	
	/**
	 * Causes particles to go through a series of waypoints.
	 * 
	 * @see idv.cjcat.stardustextended.twoD.actions.waypoints.Waypoint
	 */
	public class FollowWaypoints extends Action2D {
		
		/**
		 * Whether the particles head for the first waypoint after passing through the last waypoint.
		 */
		public var loop:Boolean;
		/**
		 * Whether the particles' mass is taken into account. 
		 * If true, the acceleration applied to a particle is divided by the particle's mass.
		 */
		public var massless:Boolean;
		private var _waypoints:Array;
		
		public function FollowWaypoints(waypoints:Array = null, loop:Boolean = false, massless:Boolean = true) {
			this.loop = loop;
			this.massless = massless;
			this.waypoints = waypoints;
		}
		
		/**
		 * An array of waypoints.
		 */
		public function get waypoints():Array { return _waypoints; }
		public function set waypoints(value:Array):void {
			if (!value) value = [];
			_waypoints = value;
		}
		
		/**
		 * Adds a waypoint to the waypoint array.
		 * @param	waypoint
		 */
		public function addWaypoint(waypoint:Waypoint):void {
			_waypoints.push(waypoint);
		}
		
		/**
		 * Removes all waypoints from the waypoint array.
		 */
		public function clearWaypoints():void {
			_waypoints = [];
		}
		
		override public function update(emitter:Emitter, particle:Particle, timeDelta:Number, currentTime:Number):void {
			if (!_waypoints.length) return;
			
			var p2D:Particle2D = Particle2D(particle);
			if (!p2D.dictionary[FollowWaypoints]) p2D.dictionary[FollowWaypoints] = 0;
			
			var index:int = p2D.dictionary[FollowWaypoints];
			
			var waypoint:Waypoint = _waypoints[index] as Waypoint;
			var dx:Number = p2D.x - waypoint.x;
			var dy:Number = p2D.y - waypoint.y;
			if (dx * dx + dy * dy <= waypoint.radius * waypoint.radius) {
				if (index < _waypoints.length - 1) {
					p2D.dictionary[FollowWaypoints]++;
					waypoint = _waypoints[index + 1];
				} else {
					if (loop) waypoint = _waypoints[0];
					else return;
				}
				dx = p2D.x - waypoint.x;
				dy = p2D.y - waypoint.y;
			}
			
			var r:Vec2D = Vec2DPool.get(dx, dy);
			var len:Number = r.length;
			if (len < waypoint.epsilon) len = waypoint.epsilon;
			r.length = -waypoint.strength * Math.pow(len, -0.5 * waypoint.attenuationPower);
			if (!massless) r.length /= p2D.mass;
			Vec2DPool.recycle(r);
			
			p2D.vx += r.x;
			p2D.vy += r.y;
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		override public function getXMLTagName():String {
			return "FollowWaypoints";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			var waypointsXML:XML = <waypoints/>;
			for each (var waypoint:Waypoint in _waypoints) {
				var waypointXML:XML = <Waypoint/>;
				waypointXML.@x = waypoint.x;
				waypointXML.@y = waypoint.y;
				waypointXML.@radius = waypoint.radius;
				waypointXML.@strength = waypoint.strength;
				waypointXML.@attenuationPower = waypoint.attenuationPower;
				waypointXML.@epsilon = waypoint.epsilon;
				
				waypointsXML.appendChild(waypointXML);
			}
			xml.appendChild(waypointsXML);
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			clearWaypoints();
			for each (var node:XML in xml.waypoints.Waypoint) {
				var waypoint:Waypoint = new Waypoint();
				waypoint.x = parseFloat(node.@x);
				waypoint.y = parseFloat(node.@y);
				waypoint.radius = parseFloat(node.@radius);
				waypoint.strength = parseFloat(node.@strength);
				waypoint.attenuationPower = parseFloat(node.@attenuationPower);
				waypoint.epsilon = parseFloat(node.@epsilon);
				
				addWaypoint(waypoint);
			}
		}
		//------------------------------------------------------------------------------------------------
		//XML
	}
}