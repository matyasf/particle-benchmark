package idv.cjcat.stardustextended.twoD.geom {

import flash.geom.Point;

import idv.cjcat.stardustextended.common.math.StardustMath;
	
	/**
	 * 2D Vector with common vector operations.
	 */
	public class Vec2D extends Point{
		
		public function Vec2D(_x:Number = 0, _y:Number = 0) {
			x = _x;
			y = _y;
		}

        override public function clone():Point{
            return new Vec2D(x,y);
        }

        [Inline] //? doesnt seem to work in most cases
        final override public function get length() : Number {
            return Math.sqrt(x * x + y * y);
        }

        [Inline]  //? doesnt seem to work in most cases
        final override public function setTo(xc : Number, yc : Number) : void {
            x = xc;
            y = yc;
        }

        final public function set length(value:Number):void {
            if ((x == 0) && (y == 0)) return;
            var factor:Number = value / length;
            x = x * factor;
            y = y * factor;
        }
		
		/**
		 * Dot product.
		 * @param	vector
		 * @return
		 */
		final public function dot(vector:Vec2D):Number {
			return (x * vector.x) + (y * vector.y);
		}
		
		/**
		 * Vector projection.
		 * @param	target
		 * @return
		 */
		final public function project(target:Vec2D):Vec2D {
			const temp : Vec2D = Vec2D(clone());
			temp.projectThis(target);
			return temp;
		}
		
		final public function projectThis(target:Vec2D):void {
            const temp:Vec2D = Vec2DPool.get(target.x, target.y);
			temp.length = 1;
			temp.length = dot(temp);
			x = temp.x;
			y = temp.y;
			Vec2DPool.recycle(temp);
		}
		
		/**
		 * Rotates a clone of the vector.
		 * @param	angle
		 * @param	useRadian
		 * @return The rotated clone vector.
		 */
		final public function rotate(angle:Number, useRadian:Boolean = false):Vec2D {
			var temp:Vec2D = new Vec2D(x, y);
			temp.rotateThis(angle, useRadian);
			return temp;
		}
		
		/**
		 * Rotates the vector.
		 * @param	angle
		 * @param	useRadian
		 */
		final public function rotateThis(angle:Number, useRadian:Boolean = false):void {
			if (!useRadian) angle = angle * StardustMath.DEGREE_TO_RADIAN;
			var originalX:Number = x;
			x = originalX * Math.cos(angle) - y * Math.sin(angle);
			y = originalX * Math.sin(angle) + y * Math.cos(angle);
		}
		
		/**
		 * The angle between the vector and the positive x axis in degrees.
		 */
		final public function get angle():Number { return Math.atan2(y, x) * StardustMath.RADIAN_TO_DEGREE; }
		final public function set angle(value:Number):void {
			var originalLength:Number = length;
			var rad:Number = value * StardustMath.DEGREE_TO_RADIAN;
			x = originalLength * Math.cos(rad);
			y = originalLength * Math.sin(rad);
		}
	}
}