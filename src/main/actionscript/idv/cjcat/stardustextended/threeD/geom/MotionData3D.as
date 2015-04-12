package idv.cjcat.stardustextended.threeD.geom {
	
	/**
	 * 3D vector value class.
	 * 
	 * <p>
	 * Unlike the <code>Vec3D</code> class, 
	 * the sole purpose of this class is to hold two numeric values (X, Y, and Z components). 
	 * It does not provide vector operations like the <code>Vec3D</code> class does.
	 * </p>
	 */
	public class MotionData3D {
		public var x:Number;
		public var y:Number;
		public var z:Number;
		
		public function MotionData3D(x:Number = 0, y:Number = 0, z:Number = 0) {
			this.x = x;
			this.y = y;
			this.z = z;
		}
	}
}