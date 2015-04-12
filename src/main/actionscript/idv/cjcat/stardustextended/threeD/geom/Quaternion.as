package idv.cjcat.stardustextended.threeD.geom {
	import idv.cjcat.stardustextended.common.math.StardustMath;
	
	public class Quaternion {
		
		public static var ZERO:Quaternion = new Quaternion(0, 0, 0, 0);
		public static var IDENTITY:Quaternion = new Quaternion(1, 0, 0, 0);
		
		/**
		 * Builds a quaternion from a rotation about an arbitrary axis.
		 * @param	angle
		 * @param	axis
		 * @param	useDegree
		 * @return
		 */
		public static function buildFromAxisRotation(axis:Vec3D = null, angle:Number = 0, useDegree:Boolean = true):Quaternion {
			return new Quaternion().setFromAxisRotation(axis, angle, useDegree);
		}
		
		/**
		 * Spherical Linear intERpolation between two quaternions.
		 * @param	q1  The starting quaternion.
		 * @param	q2  The ending quaternion.
		 * @param	t  Interpolation parameter, between 0 and 1.
		 * @return
		 */
		public static function slerp(q1:Quaternion, q2:Quaternion, t:Number):Quaternion {
			t = StardustMath.clamp(t, 0, 1);
			
			var w1:Number = q1.w;
			var x1:Number = q1.x;
			var y1:Number = q1.y;
			var z1:Number = q1.z;
			var cosOmega:Number = w1 * q2.w + x1 * q2.x + y1 * q2.y + z1 * q2.z;
			
			if (cosOmega < 0) {
				w1 = -w1;
				x1 = -x1;
				y1 = -y1;
				z1 = -z1;
				cosOmega = -cosOmega;
			}
			
			var k0:Number, k1:Number;
			if (cosOmega > 0.99999) {
				//blow-up prevention
				k0 = 1 - t;
				k1 = t;
			} else {
				var sinOmega:Number = Math.sqrt(1 - cosOmega * cosOmega);
				var omega:Number = Math.atan2(sinOmega, cosOmega);
				var sinOmega_inv:Number = 1 / sinOmega;
				k0 = Math.sin((1 - t) * omega) * sinOmega_inv;
				k1 = Math.sin(t * omega) * sinOmega_inv;
			}
			
			//interpolation
			return new Quaternion(
				w1 * k0 + q2.w * k1, 
				x1 * k0 + q2.x * k1, 
				y1 * k0 + q2.y * k1, 
				z1 * k0 + q2.z * k1);
		}
		
		/**
		 * The w component of the quaternion.
		 */
		public var w:Number;
		
		/**
		 * The x component of the quaternion.
		 */
		public var x:Number;
		
		/**
		 * The y component of the quaternion.
		 */
		public var y:Number;
		
		/**
		 * The z component of the quaternion.
		 */
		public var z:Number;
		
		public function Quaternion(w:Number = 1, x:Number = 0, y:Number = 0, z:Number = 0) {
			set(w, x, y, z);
		}
		
		/**
		 * Sets all four quaternion components at once;
		 * @param	w
		 * @param	x
		 * @param	y
		 * @param	z
		 */
		public final function set(w:Number, x:Number, y:Number, z:Number):Quaternion {
			this.w = w;
			this.x = x;
			this.y = y;
			this.z = z;
			return this;
		}
		
		/**
		 * Sets this quaternion from a rotation about an arbitrary axis.
		 * @param	angle
		 * @param	axis
		 * @param	useDegree
		 * @return
		 */
		public final function setFromAxisRotation(axis:Vec3D = null, angle:Number = 0, useDegree:Boolean = true):Quaternion {
			if (useDegree) angle *= StardustMath.DEGREE_TO_RADIAN;
			if (!axis) axis = Vec3D.Z_AXIS;
			
			angle *= 0.5;
			axis = axis.unitVec();
			
			var nSin:Number = -Math.sin(angle);
			w = Math.cos(angle);
			x = nSin * axis.x;
			y = nSin * axis.y;
			z = nSin * axis.z;
			return this;
		}
		
		public final function clone():Quaternion {
			return new Quaternion(w, x, y, z);
		}
		
		/**
		 * Returns a copy of the result of premultiplying this quaternion by another quaternion.
		 * @param	lhs
		 * @return
		 */
		public final function preMultiply(lhs:Quaternion):Quaternion {
			return clone().preMultiplyThis(lhs);
		}
		
		/**
		 * Premultiply this quaternion by another quaternion.
		 * @param	lhs
		 * @return
		 */
		public final function preMultiplyThis(lhs:Quaternion):Quaternion {
			w = lhs.w * w - (lhs.x * x + lhs.y * y + lhs.z * z);
			x = lhs.w * x + lhs.x * w + lhs.y * z - lhs.z * y;
			y = lhs.w * y + lhs.y * w + lhs.z * x - lhs.x * z;
			z = lhs.w * z + lhs.z * w + lhs.x * y - lhs.y * x;
			return this;
		}
		
		/**
		 * Returns a copy of the result of postmultiplying this quaternion by another quaternion.
		 * @param	rhs
		 * @return
		 */
		public final function postMultiply(rhs:Quaternion):Quaternion {
			return clone().postMultiplyThis(rhs);
		}
		
		/**
		 * Postmultiply this quaternion by another quaternion.
		 * @param	rhs
		 * @return
		 */
		public final function postMultiplyThis(rhs:Quaternion):Quaternion {
			w = w * rhs.w - (x * rhs.x + y * rhs.y + z * rhs.z);
			x = w * rhs.x + x * rhs.w + y * rhs.z - z * rhs.y;
			y = w * rhs.y + y * rhs.w + z * rhs.x - x * rhs.z;
			z = w * rhs.z + z * rhs.w + x * rhs.y - y * rhs.z;
			return this;
		}
		
		public final function equals(q:Quaternion):Boolean {
			return (w == q.w) && (x == q.x) && (y == q.y) && (z == q.z);
		}
		
		/**
		 * Determines if the absolute value of the difference between two quaternions is less than a given error value.
		 * @param	q
		 * @param	error
		 * @return
		 */
		public final function nearEquals(q:Quaternion, error:Number = 0.0001):Boolean {
			var dw:Number = w - q.w;
			var dx:Number = x - q.x;
			var dy:Number = y - q.y;
			var dz:Number = z - q.z;
			return (dw * dw + dx * dx + dy * dy + dz * dz) < (error * error);
		}
		
		public final function conjugate():Quaternion {
			return clone().conjugateThis();
		}
		
		public final function conjugateThis():Quaternion {
			return set(w, -x, -y, -z);
		}
		
		/**
		 * Converts this quaternion to matrix transformation.
		 * @return
		 */
		public final function toMatrix():Matrix3D {
			var xx:Number = x * x;
			var yy:Number = y * y;
			var zz:Number = z * z;
			var wx:Number = w * x;
			var wy:Number = w * y;
			var wz:Number = w * z;
			var xy:Number = x * y;
			var xz:Number = x * z;
			var yz:Number = y * z;
			return new Matrix3D(
				1 - 2 * ( yy + zz ), 2 * ( xy - wz ), 2 * ( xz + wy ),
				2 * ( xy + wz ), 1 - 2 * ( xx + zz ), 2 * ( yz - wx ),
				2 * ( xz - wy ), 2 * ( yz + wx ), 1 - 2 * ( xx + yy ));
		}
		
		public function toString():String {
			return "[Quaternion w=" + w + " x=" + x + " y=" + y + " z=" + z + "]";
		}
	}
}