package idv.cjcat.stardustextended.threeD.geom {
	
	/**
	 * 6D vector value class.
	 */
	public class MotionData6D {
		public var x:Number;
		public var y:Number;
		public var z:Number;
		public var vx:Number;
		public var vy:Number;
		public var vz:Number;
		
		public function MotionData6D(x:Number = 0, y:Number = 0, z:Number = 0, vx:Number = 0, vy:Number = 0, vz:Number = 0) {
			this.x = x;
			this.y = y;
			this.z = z;
			this.vx = vx;
			this.vy = vy;
			this.vz = vz;
		}
	}
}