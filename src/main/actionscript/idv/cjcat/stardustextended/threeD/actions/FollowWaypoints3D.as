package idv.cjcat.stardustextended.threeD.actions {
	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.threeD.actions.waypoints.Waypoint3D;
	import idv.cjcat.stardustextended.threeD.geom.Vec3D;
	import idv.cjcat.stardustextended.threeD.geom.Vec3DPool;
	import idv.cjcat.stardustextended.threeD.particles.Particle3D;
	
	/**
	 * Causes particles to go through a series of waypoints.
	 * 
	 * @see idv.cjcat.stardustextended.threeD.actions.waypoints.Waypoint3D
	 */
	public class FollowWaypoints3D extends Action3D {
		
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
		
		public function FollowWaypoints3D(waypoints:Array = null, loop:Boolean = false, massless:Boolean = true) {
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
		public final function addWaypoint(waypoint:Waypoint3D):void {
			_waypoints.push(waypoint);
		}
		
		/**
		 * Removes all waypoints from the waypoint array.
		 */
		public final function clearWaypoints():void {
			_waypoints = [];
		}
		
		override public final function update(emitter:Emitter, particle:Particle, timeDelta:Number, currentTime:Number):void {
			if (!_waypoints.length) return;
			
			var p3D:Particle3D = Particle3D(particle);
			if (!p3D.dictionary[FollowWaypoints3D]) p3D.dictionary[FollowWaypoints3D] = 0;
			
			var index:int = p3D.dictionary[FollowWaypoints3D];
			
			var waypoint:Waypoint3D = _waypoints[index] as Waypoint3D;
			var dx:Number = p3D.x - waypoint.x;
			var dy:Number = p3D.y - waypoint.y;
			var dz:Number = p3D.z - waypoint.z;
			if (dx * dx + dy * dy + dz * dz <= waypoint.radius * waypoint.radius) {
				if (index < _waypoints.length - 1) {
					p3D.dictionary[FollowWaypoints3D]++;
					waypoint = _waypoints[index + 1];
				} else {
					if (loop) waypoint = _waypoints[0];
					else return;
				}
				dx = p3D.x - waypoint.x;
				dy = p3D.y - waypoint.y;
				dz = p3D.z - waypoint.z;
			}
			
			var r:Vec3D = Vec3DPool.get(dx, dy, dz);
			var len:Number = r.length;
			if (len < waypoint.epsilon) len = waypoint.epsilon;
			r.length = -waypoint.strength * Math.pow(len, -0.5 * waypoint.attenuationPower);
			if (!massless) r.length /= p3D.mass;
			Vec3DPool.recycle(r);
			
			p3D.vx += r.x;
			p3D.vy += r.y;
			p3D.vz += r.z;
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		override public function getXMLTagName():String {
			return "FollowWaypoints3D";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			var waypointsXML:XML = <waypoints/>;
			for each (var waypoint:Waypoint3D in _waypoints) {
				var waypointXML:XML = <Waypoint3D/>;
				waypointXML.@x = waypoint.x;
				waypointXML.@y = waypoint.y;
				waypointXML.@z = waypoint.z;
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
			for each (var node:XML in xml.waypoints.Waypoint3D) {
				var waypoint:Waypoint3D = new Waypoint3D();
				waypoint.x = parseFloat(node.@x);
				waypoint.y = parseFloat(node.@y);
				waypoint.z = parseFloat(node.@z);
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