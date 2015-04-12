package idv.cjcat.stardustextended.threeD.deflectors {
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.threeD.geom.MotionData6D;
	import idv.cjcat.stardustextended.threeD.geom.MotionData6DPool;
	import idv.cjcat.stardustextended.threeD.particles.Particle3D;
	
	/**
	 * Causes particles to be bounded within a box region.
	 * 
	 * <p>
	 * When a particle hits the walls of the region, it bounces back.
	 * </p>
	 */
	public class BoundingCube extends Deflector3D {
		
		/**
		 * The X coordinate of the top-left-front corner.
		 */
		public var x:Number;
		/**
		 * The Y coordinate of the top-left-front corner.
		 */
		public var y:Number;
		/**
		 * The Z coordinate of the top-left-front corner.
		 */
		public var z:Number;
		/**
		 * The width of the region.
		 */
		public var width:Number;
		/**
		 * The height of the region.
		 */
		public var height:Number;
		/**
		 * The depth of the region.
		 */
		public var depth:Number;
		
		public function BoundingCube(x:Number = 0, y:Number = 0, z:Number = 0, width:Number = 640, height:Number = 480, depth:Number = 480) {
			this.bounce = 1;
			this.x = x;
			this.y = y;
			this.z = z;
			this.width = width;
			this.height = height;
			this.depth = depth;
		}
		
		private var radius:Number;
		private var left:Number;
		private var right:Number;
		private var top:Number;
		private var bottom:Number;
		private var front:Number;
		private var back:Number;
		private var factor:Number;
		private var finalX:Number;
		private var finalY:Number;
		private var finalZ:Number;
		private var finalVX:Number;
		private var finalVY:Number;
		private var finalVZ:Number;
		private var deflected:Boolean;
		override protected final function calculateMotionData6D(particle:Particle3D):MotionData6D {
			radius = particle.collisionRadius * particle.scale;
			left = x + radius;
			right = x + width - radius;
			top = y + radius;
			bottom = y + height - radius;
			front = z + radius;
			back = z + depth - radius;
			
			factor = -bounce;
				
			finalX = particle.x;
			finalY = particle.y;
			finalZ = particle.z;
			finalVX = particle.vx;
			finalVY = particle.vy;
			finalVZ = particle.vz;
			
			deflected = false;
			if (particle.x <= left) {
				finalX = left;
				finalVX *= factor;
				deflected = true;
			} else if (particle.x >= right) {
				finalX = right;
				finalVX *= factor;
				deflected = true;
			}
			if (particle.y <= top) {
				finalY = top;
				finalVY *= factor;
				deflected = true;
			} else if (particle.y >= bottom) {
				finalY = bottom;
				finalVY *= factor;
				deflected = true;
			}
			if (particle.z <= front) {
				finalZ = front;
				finalVZ *= factor;
				deflected = true;
			} else if (particle.z >= back) {
				finalZ = back;
				finalVZ *= factor;
				deflected = true;
			}
			
			if (deflected) return MotionData6DPool.get(finalX, finalY, finalZ, finalVX, finalVY, finalVZ);
			else return null;
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "BoundingCube";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@x = x;
			xml.@y = y;
			xml.@z = z;
			xml.@width = width;
			xml.@height = height;
			xml.@depth = depth;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@x.length()) x = parseFloat(xml.@x);
			if (xml.@y.length()) y = parseFloat(xml.@y);
			if (xml.@z.length()) z = parseFloat(xml.@z);
			if (xml.@width.length()) width = parseFloat(xml.@width);
			if (xml.@height.length()) height = parseFloat(xml.@height);
			if (xml.@depth.length()) depth = parseFloat(xml.@depth);
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}