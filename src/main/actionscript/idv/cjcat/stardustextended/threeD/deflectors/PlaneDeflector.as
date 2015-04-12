package idv.cjcat.stardustextended.threeD.deflectors {
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.threeD.geom.MotionData6D;
	import idv.cjcat.stardustextended.threeD.geom.MotionData6DPool;
	import idv.cjcat.stardustextended.threeD.geom.Vec3D;
	import idv.cjcat.stardustextended.threeD.geom.Vec3DPool;
	import idv.cjcat.stardustextended.threeD.particles.Particle3D;
	
	/**
	 * Infinitely large plane-shaped obstacle. 
	 * One side of the plane is free space, and the other side is "solid", 
	 * not allowing any particle to go through. 
	 * The plane is defined by a point it passes through and its normal vector.
	 * 
	 * <p>
	 * When a particle hits the border, it bounces back.
	 * </p>
	 */
	public class PlaneDeflector extends Deflector3D {
		
		/**
		 * The X coordinate of a point the border passes through.
		 */
		public var x:Number;
		/**
		 * The Y coordinate of a point the border passes through.
		 */
		public var y:Number;
		/**
		 * The Z coordinate of a point the border passes through.
		 */
		public var z:Number;
		
		private var _normal:Vec3D;
		
		public function PlaneDeflector(x:Number = 0, y:Number = 0, z:Number = 0, nx:Number = 0, ny:Number = -1, nz:Number = 0) {
			this.x = x;
			this.y = y;
			this.z = z;
			_normal = new Vec3D(nx, ny, nz);
		}
		
		/**
		 * The normal of the border, pointing to the free space side.
		 */
		public function get normal():Vec3D { return _normal; }
		
		private var r:Vec3D;
		private var dot:Number;
		private var radius:Number;
		private var dist:Number;
		private var v:Vec3D;
		private var factor:Number;
		override protected final function calculateMotionData6D(particle:Particle3D):MotionData6D {
			//normal dispacement
			r = Vec3DPool.get(particle.x - x, particle.y - y, particle.z - z);
			
			r = r.project(normal);
			
			dot = r.dot(normal);
			radius = particle.collisionRadius * particle.scale;
			dist = r.length;
			
			//no collision detected
			if (dot > 0) {
				if (dist > radius) {
					Vec3DPool.recycle(r);
					return null;
				} else {
					r.length = radius - dist;
				}
			} else {
				r.length = -(dist + radius);
			}
			
			//collision detected
			v = Vec3DPool.get(particle.vx, particle.vy, particle.vz);
			v = v.project(normal);
			
			factor = 1 + bounce;
			
			Vec3DPool.recycle(r);
			Vec3DPool.recycle(v);
			return MotionData6DPool.get(particle.x + r.x, particle.y + r.y, particle.z + r.z, particle.vx - v.x * factor, particle.vy - v.y * factor, particle.vz - v.z * factor);
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "PlaneDeflector";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@x = x;
			xml.@y = y;
			xml.@z = z;
			xml.@normalX = normal.x;
			xml.@normalY = normal.y;
			xml.@normalZ = normal.z;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@x.length()) x = parseFloat(xml.@x);
			if (xml.@y.length()) y = parseFloat(xml.@y);
			if (xml.@z.length()) z = parseFloat(xml.@z);
			if (xml.@normalX.length()) normal.x = parseFloat(xml.@normalX);
			if (xml.@normalY.length()) normal.y = parseFloat(xml.@normalY);
			if (xml.@normalZ.length()) normal.z = parseFloat(xml.@normalZ);
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}