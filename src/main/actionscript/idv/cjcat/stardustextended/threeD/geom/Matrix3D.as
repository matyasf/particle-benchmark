package idv.cjcat.stardustextended.threeD.geom {
	
	public final class Matrix3D {
		
		public var a:Number;
		public var b:Number;
		public var c:Number;
		public var d:Number;
		public var e:Number;
		public var f:Number;
		public var g:Number;
		public var h:Number;
		public var i:Number;
		public var tx:Number;
		public var ty:Number;
		public var tz:Number;
		
		public function Matrix3D(a:Number = 1, b:Number = 0, c:Number = 0, d:Number = 0, e:Number = 1, f:Number = 0, g:Number = 0, h:Number = 0, i:Number = 1, tx:Number = 0, ty:Number = 0, tz:Number = 0) {
			this.a = a;	this.b = b;	this.c = c;
			this.d = d;	this.e = e;	this.f = f;
			this.g = g;	this.h = h;	this.i = i;
			this.tx = tx; this.ty = ty; this.tz = tz;
		}
		
		public final function set(rotationX:Number = 0, rotationY:Number = 0, rotationZ:Number = 0, scaleX:Number = 1, scaleY:Number = 1, scaleZ:Number = 1, tx:Number = 0, ty:Number = 0, tz:Number = 0, rotationOrder:int = 0):Matrix3D {
			identity();
			if (rotationZ) rotateZ(rotationZ);
			if (rotationY) rotateY(rotationY);
			if (rotationX) rotateX(rotationX);
			if (scaleX != 1 || scaleY != 1 || scaleZ != 1) scale(scaleX, scaleY, scaleZ);
			if (tx || ty || tz) translate(tx, ty, tz);
			return this;
		}
		
		public final function transformThisVec(v:Vec3D):Vec3D {
			v.set((a * v.x + b * v.y + c * v.z + tx), (d * v.x + e * v.y + f * v.z + ty), (g * v.x + h * v.y + i * v.z + tz));
			return v;
		}
		
		public final function transform(v:Vec3D):Vec3D {
			return transformThisVec(v.clone());
		}
		
		public final function postMultiply(rhs:Matrix3D):Matrix3D {
			var thisClone:Matrix3D = Matrix3DPool.get(a, b, c, d, e, f, g, h, i, tx, ty, tz);
			a = thisClone.a * rhs.a + thisClone.b * rhs.d + thisClone.c * rhs.g;
			b = thisClone.a * rhs.b + thisClone.b * rhs.e + thisClone.c * rhs.h;
			c = thisClone.a * rhs.c + thisClone.b * rhs.f + thisClone.c * rhs.i;
			d = thisClone.d * rhs.a + thisClone.e * rhs.d + thisClone.f * rhs.g;
			e = thisClone.d * rhs.b + thisClone.e * rhs.e + thisClone.f * rhs.h;
			f = thisClone.d * rhs.c + thisClone.e * rhs.f + thisClone.f * rhs.i;
			g = thisClone.g * rhs.a + thisClone.h * rhs.d + thisClone.i * rhs.g;
			h = thisClone.g * rhs.b + thisClone.h * rhs.e + thisClone.i * rhs.h;
			i = thisClone.g * rhs.c + thisClone.h * rhs.f + thisClone.i * rhs.i;
			tx = thisClone.a * rhs.tx + thisClone.b * rhs.ty + thisClone.c * rhs.tz + thisClone.tx;
			ty = thisClone.d * rhs.tx + thisClone.e * rhs.ty + thisClone.f * rhs.tz + thisClone.ty;
			tz = thisClone.g * rhs.tx + thisClone.h * rhs.ty + thisClone.i * rhs.tz + thisClone.tz;
			Matrix3DPool.recycle(thisClone);
			return this;
		}
		
		public final function preMultiply(lhs:Matrix3D):Matrix3D {
			var thisClone:Matrix3D = Matrix3DPool.get(a, b, c, d, e, f, g, h, i, tx, ty, tz);
			a = lhs.a * thisClone.a + lhs.b * thisClone.d + lhs.c * thisClone.g;
			b = lhs.a * thisClone.b + lhs.b * thisClone.e + lhs.c * thisClone.h;
			c = lhs.a * thisClone.c + lhs.b * thisClone.f + lhs.c * thisClone.i;
			d = lhs.d * thisClone.a + lhs.e * thisClone.d + lhs.f * thisClone.g;
			e = lhs.d * thisClone.b + lhs.e * thisClone.e + lhs.f * thisClone.h;
			f = lhs.d * thisClone.c + lhs.e * thisClone.f + lhs.f * thisClone.i;
			g = lhs.g * thisClone.a + lhs.h * thisClone.d + lhs.i * thisClone.g;
			h = lhs.g * thisClone.b + lhs.h * thisClone.e + lhs.i * thisClone.h;
			i = lhs.g * thisClone.c + lhs.h * thisClone.f + lhs.i * thisClone.i;
			tx = lhs.a * thisClone.tx + lhs.b * thisClone.ty + lhs.c * thisClone.tz + lhs.tx;
			ty = lhs.d * thisClone.tx + lhs.e * thisClone.ty + lhs.f * thisClone.tz + lhs.ty;
			tz = lhs.g * thisClone.tx + lhs.h * thisClone.ty + lhs.i * thisClone.tz + lhs.tz;
			Matrix3DPool.recycle(thisClone);
			return this;
		}
		
		public final function identity():Matrix3D {
			a = 1; b = 0; c = 0;
			d = 0; e = 1; f = 0;
			g = 0; h = 0; i = 1;
			tx = ty = tz = 0;
			return this;
		}
		
		/**
		 * 
		 * @param	angle  In radians.
		 */
		public final function rotateX(angle:Number):Matrix3D {
			var thisClone:Matrix3D = Matrix3DPool.get(a, b, c, d, e, f, g, h, i, tx, ty, tz);
			var cos:Number = Math.cos(angle);
			var sin:Number = Math.sin(angle);
			d = thisClone.d * cos - thisClone.g * sin;
			e = thisClone.e * cos - thisClone.h * sin;
			f = thisClone.f * cos - thisClone.i * sin;
			g = thisClone.g * cos + thisClone.d * sin;
			h = thisClone.h * cos + thisClone.e * sin;
			i = thisClone.i * cos + thisClone.f * sin;
			Matrix3DPool.recycle(thisClone);
			return this;
		}
		
		/**
		 * 
		 * @param	angle  In radians.
		 */
		public final function rotateY(angle:Number):Matrix3D {
			var thisClone:Matrix3D = Matrix3DPool.get(a, b, c, d, e, f, g, h, i, tx, ty, tz);
			var cos:Number = Math.cos(angle);
			var sin:Number = Math.sin(angle);
			a = thisClone.a * cos + thisClone.g * sin;
			b = thisClone.b * cos + thisClone.h * sin;
			c = thisClone.c * cos + thisClone.i * sin;
			g = thisClone.g * cos - thisClone.a * sin ;
			h = thisClone.h * cos - thisClone.b * sin ;
			i = thisClone.i * cos - thisClone.c * sin ;
			Matrix3DPool.recycle(thisClone);
			return this;
		}
		
		/**
		 * 
		 * @param	angle  In radians.
		 */
		public final function rotateZ(angle:Number):Matrix3D {
			var thisClone:Matrix3D = Matrix3DPool.get(a, b, c, d, e, f, g, h, i, tx, ty, tz);
			var cos:Number = Math.cos(angle);
			var sin:Number = Math.sin(angle);
			a = thisClone.a * cos - thisClone.d * sin;
			b = thisClone.b * cos - thisClone.e * sin;
			c = thisClone.c * cos - thisClone.f * sin;
			d = thisClone.d * cos + thisClone.a * sin;
			e = thisClone.e * cos + thisClone.b * sin;
			f = thisClone.f * cos + thisClone.c * sin;
			Matrix3DPool.recycle(thisClone);
			return this;
		}
		
		public final function scale(x:Number, y:Number, z:Number):Matrix3D {
			a *= x; b *= x; c *= x;
			d *= y; e *= y; f *= y;
			g *= z; h *= z; i *= z;
			return this;
		}
		
		public final function translate(x:Number, y:Number, z:Number):Matrix3D {
			tx += x; ty += y; tz += z;
			return this;
		}
		
		public final function clone():Matrix3D {
			return new Matrix3D(a, b, c, d, e, f, g, h, i, tx, ty, tz);
		}
		
		public function toString():String {
			return "[Matrix3D a=" + a + ", b=" + b + ", c=" + c + ", d=" + d + ", e=" + e + ", f=" + f + ", g=" + g + ", h=" + h + ", i=" + i + ", tx=" + tx + ", ty=" + ty + ", tz=" + tz + "]";
		}
	}
}