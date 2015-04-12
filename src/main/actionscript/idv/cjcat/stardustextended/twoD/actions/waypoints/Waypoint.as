package idv.cjcat.stardustextended.twoD.actions.waypoints {
	
	/**
	 * Waypoint used by the <code>FollowWaypoints</code> action.
	 * 
	 * @see idv.cjcat.stardustextended.twoD.actions.FollowWaypoints
	 */
	public class Waypoint {
		
		/**
		 * The X coordinate of the center of the waypoint.
		 */
		public var x:Number;
		/**
		 * The Y coordinate of the center of the waypoint.
		 */
		public var y:Number;
		/**
		 * The radius of the waypoint.
		 */
		public var radius:Number;
		/**
		 * The strength of the waypoint. This value must be positive.
		 */
		public var strength:Number;
		/**
		 * The attenuation power of the waypoint, in powers per pixel.
		 */
		public var attenuationPower:Number;
		/**
		 * If a point is closer to the center than this value, 
		 * it's treated as if it's this far from the center. 
		 * This is to prevent simulation from blowing up for points too near to the center.
		 */
		public var epsilon:Number;
		
		public function Waypoint(x:Number = 0, y:Number = 0, radius:Number = 20, strength:Number = 1, attenuationPower:Number = 0, epsilon:Number = 1) {
			this.x = x;
			this.y = y;
			this.radius = radius;
			this.strength = strength;
			this.attenuationPower = attenuationPower;
			this.epsilon = epsilon;
		}
	}
}