package idv.cjcat.stardustextended.threeD.geom {

import idv.cjcat.stardustextended.cjsignals.ISignal;
import idv.cjcat.stardustextended.cjsignals.Signal;
import idv.cjcat.stardustextended.common.math.StardustMath;
	
	/**
	 * 3D Vector with common vector operations.
	 */
	public final class Vec3D {
		
		
		//signals
		//------------------------------------------------------------------------------------------------
		
		private var _onChange:ISignal = new Signal(Vec3D);
		/**
		 * Dispatched when the vector is changed.
		 * <p/>
		 * Signature: (vec:Vec3D)
		 */
		public function get onChange():ISignal { return _onChange; }
		
		//------------------------------------------------------------------------------------------------
		//end of signals
		
		
		public static const ZERO:Vec3D = new Vec3D(0, 0, 0);
		public static const X_AXIS:Vec3D = new Vec3D(1, 0, 0);
		public static const Y_AXIS:Vec3D = new Vec3D(0, 1, 0);
		public static const Z_AXIS:Vec3D = new Vec3D(0, 0, 1);
		
		public static function angleBetween(v1:Vec3D, v2:Vec3D, useRadian:Boolean = false):Number {
			var angle:Number = Math.acos(v1.dot(v2) / (v1.length * v2.length));
			if (!useRadian) angle *= StardustMath.RADIAN_TO_DEGREE;
			return angle
		}
		
		private var _x:Number;
		private var _y:Number;
		private var _z:Number;
		
		public function Vec3D(x:Number = 0, y:Number = 0, z:Number = 0) {
			_x = x;
			_y = y;
			_z = z;
		}
		
		public final function get x():Number { return _x; }
		public final function set x(value:Number):void {
			_x = value;
			onChange.dispatch(this)
		}
		
		public final function get y():Number { return _y; }
		public function set y(value:Number):void {
			_y = value;
			onChange.dispatch(this)
		}
		
		public final function get z():Number { return _z; }
		public function set z(value:Number):void {
			_z = value;
			onChange.dispatch(this)
		}
		
		public final function clone():Vec3D {
			return new Vec3D(_x, _y, _z);
		}
		
		/**
		 * Dot product.
		 * @param	vector
		 * @return
		 */
		public final function dot(vector:Vec3D):Number {
			return (_x * vector._x) + (_y * vector._y) + (_z * vector._z);
		}
		
		/**
		 * Cross Product
		 * @param	vector
		 * @return
		 */
		public final function cross(vector:Vec3D):Vec3D {
			return new Vec3D((_y * vector._z - _z * vector._y), (_z * vector._x - _x * vector._z), (_x * vector._y - _y * vector._x));
		}
		
		/**
		 * Vector projection.
		 * @param	target
		 * @return
		 */
		public final function project(target:Vec3D):Vec3D {
			var temp:Vec3D = clone();
			temp.projectThis(target);
			return temp;
		}
		
		public final function projectThis(target:Vec3D):void {
			var temp:Vec3D = Vec3DPool.get(target._x, target._y, target._z);
			temp.length = 1;
			temp.length = dot(temp);
			_x = temp._x;
			_y = temp._y;
			_z = temp._z;
			Vec3DPool.recycle(temp);
		}
		
		public final function rotate(axis:Vec3D, angle:Number, useDegree:Boolean = true):Vec3D {
			if (useDegree) angle = angle * StardustMath.DEGREE_TO_RADIAN;
			var n:Vec3D = axis.unitVec();
			var dotProd:Number = this.dot(n);
			var par:Vec3D = new Vec3D(dotProd * n._x, dotProd * n._y, dotProd * n._z);
			var per:Vec3D = new Vec3D(_x - par._x, _y - par._y, _z - par._z);
			var w:Vec3D = n.cross(this);
			
			var cosine:Number = Math.cos(angle);
			var sine:Number = Math.sin(angle);
			
			return new Vec3D((cosine * per._x + sine * w._x + par._x), (cosine * per._y + sine * w._y + par._y), (cosine * per._z + sine * w._z + par._z));
		}
		
		public final function rotateThis(axis:Vec3D, angle:Number, useRadian:Boolean = false):void {
			var temp:Vec3D = rotate(axis, angle, useRadian);
			_x = temp._x;
			_y = temp._y;
			_z = temp._z;
			
			onChange.dispatch(this)
		}
		
		/**
		 * Rotates a clone of the vector along the X axis.
		 * @param	angle
		 * @param	useRadian
		 * @return The rotated clone vector.
		 */
		public final function rotateX(angle:Number, useRadian:Boolean = false):Vec3D {
			var temp:Vec3D = new Vec3D(_x, _y, _z);
			temp.rotateXThis(angle, useRadian);
			return temp;
		}
		
		/**
		 * Rotates the vector along the X axis.
		 * @param	angle
		 * @param	useRadian
		 */
		public final function rotateXThis(angle:Number, useRadian:Boolean = false):void {
			if (!useRadian) angle = angle * StardustMath.DEGREE_TO_RADIAN;
			var originalY:Number = _y;
			_y = originalY * Math.cos(angle) - _z * Math.sin(angle);
			_z = originalY * Math.sin(angle) + _z * Math.cos(angle);
			
			onChange.dispatch(this)
		}
		
		/**
		 * Rotates a clone of the vector along the Y axis.
		 * @param	angle
		 * @param	useRadian
		 * @return The rotated clone vector.
		 */
		public final function rotateY(angle:Number, useRadian:Boolean = false):Vec3D {
			var temp:Vec3D = new Vec3D(_x, _y, _z);
			temp.rotateYThis(angle, useRadian);
			return temp;
		}
		
		/**
		 * Rotates the vector along the Y axis.
		 * @param	angle
		 * @param	useRadian
		 */
		public final function rotateYThis(angle:Number, useRadian:Boolean = false):void {
			if (!useRadian) angle = angle * StardustMath.DEGREE_TO_RADIAN;
			var originalZ:Number = _z;
			_z = originalZ * Math.cos(angle) - _x * Math.sin(angle);
			_x = originalZ * Math.sin(angle) + _x * Math.cos(angle);
			
			onChange.dispatch(this)
		}
		
		/**
		 * Rotates a clone of the vector along the Z axis.
		 * @param	angle
		 * @param	useRadian
		 * @return The rotated clone vector.
		 */
		public final function rotateZ(angle:Number, useRadian:Boolean = false):Vec3D {
			var temp:Vec3D = new Vec3D(_x, _y, _z);
			temp.rotateZThis(angle, useRadian);
			return temp;
		}
		
		/**
		 * Rotates the vector along the Z axis.
		 * @param	angle
		 * @param	useRadian
		 */
		public final function rotateZThis(angle:Number, useRadian:Boolean = false):void {
			if (!useRadian) angle = angle * StardustMath.DEGREE_TO_RADIAN;
			var originalX:Number = _x;
			_x = originalX * Math.cos(angle) - _y * Math.sin(angle);
			_y = originalX * Math.sin(angle) + _y * Math.cos(angle);
			
			onChange.dispatch(this)
		}
		
		/**
		 * Unit vector.
		 * @return
		 */
		public final function unitVec():Vec3D {
			if (length == 0) return new Vec3D();
			var length_inv:Number = 1 / length;
			return new Vec3D(_x * length_inv, _y * length_inv, _z * length_inv);
		}
		
		/**
		 * Vector length.
		 */
		public final function get length():Number {
			return Math.sqrt(_x * _x + _y * _y + _z * _z);
		}
		public final function set length(value:Number):void {
			if ((_x == 0) && (_y == 0) && (_z == 0)) return;
			var factor:Number = value / length;
			
			_x = _x * factor;
			_y = _y * factor;
			_z = _z * factor;
			
			onChange.dispatch(this)
		}
		
		/**
		 * Sets the vector's both components at once.
		 * @param	x
		 * @param	y
		 */
		public final function set(x:Number, y:Number, z:Number):void {
			_x = x;
			_y = y;
			_z = z;
			
			onChange.dispatch(this)
		}
		
		public function toString():String {
			return "[Vec3D x=" + _x + " y=" + _y + " z=" + _z + "]";
		}
	}
}