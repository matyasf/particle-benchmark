package idv.cjcat.stardustextended.threeD.deflectors {
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.threeD.geom.MotionData6D;
	import idv.cjcat.stardustextended.threeD.geom.MotionData6DPool;
	import idv.cjcat.stardustextended.threeD.geom.Vec3D;
	import idv.cjcat.stardustextended.threeD.geom.Vec3DPool;
	import idv.cjcat.stardustextended.threeD.particles.Particle3D;
	
	/**
	 * Spherical obstacle.
	 * 
	 * <p>
	 * When a particle hits the obstacle, it bounces back.
	 * </p>
	 */
	public class SphereDeflector extends Deflector3D {
		
		/**
		 * The X coordinate of the center of the obstacle.
		 */
		public var x:Number = 0;
		/**
		 * The Y coordinate of the center of the obstacle.
		 */
		public var y:Number = 0;
		/**
		 * The Z coordinate of the center of the obstacle.
		 */
		public var z:Number = 0;
		/**
		 * The radius of the obstacle.
		 */
		public var radius:Number;
		
		public function SphereDeflector(x:Number = 0, y:Number = 0, z:Number = 0, radius:Number = 100) {
			this.x = x;
			this.y = y;
			this.z = z;
			this.radius = radius;
		}
		
		private var cr:Number;
		private var r:Vec3D;
		private var len:Number;
		private var v:Vec3D;
		private var factor:Number;
		override protected final function calculateMotionData6D(particle:Particle3D):MotionData6D {
			//normal displacement
			cr = particle.collisionRadius * particle.scale;
			r = Vec3DPool.get(particle.x - x, particle.y - y, particle.z - z);
			
			//no collision detected
			len = r.length - cr;
			if (len > radius) {
				Vec3DPool.recycle(r);
				return null;
			}
			
			//collision detected
			r.length = radius + cr;
			v = Vec3DPool.get(particle.vx, particle.vy, particle.vz);
			v.projectThis(r);
			
			factor = 1 + bounce;
			
			Vec3DPool.recycle(r);
			Vec3DPool.recycle(v);
			return MotionData6DPool.get(x + r.x, y + r.y, z + r.z, particle.vx - v.x * factor, particle.vy - v.y * factor, particle.vz - v.z * factor);
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "SphereDeflector";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@x = x;
			xml.@y = y;
			xml.@z = z;
			xml.@radius = radius;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@x.length()) x = parseFloat(xml.@x);
			if (xml.@y.length()) y = parseFloat(xml.@y);
			if (xml.@z.length()) z = parseFloat(xml.@z);
			if (xml.@radius.length()) radius = parseFloat(xml.@radius);
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}