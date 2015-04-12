package idv.cjcat.stardustextended.threeD.deflectors {
	import idv.cjcat.stardustextended.common.math.StardustMath;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.threeD.geom.MotionData6D;
	import idv.cjcat.stardustextended.threeD.geom.MotionData6DPool;
	import idv.cjcat.stardustextended.threeD.particles.Particle3D;
	
	/**
	 * Keeps particles inside a box region.
	 * 
	 * <p>
	 * When a particle goes beyond a wall of the region, it reappears from the other side.
	 * </p>
	 */
	public class WrappingCube extends Deflector3D {
		
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
		
		public function WrappingCube(x:Number = 0, y:Number = 0, z:Number = 0, width:Number = 640, height:Number = 480, depth:Number = 480) {
			this.x = x;
			this.y = y;
			this.z = z;
			this.width = width;
			this.height = height;
			this.depth = depth;
		}
		
		private var left:Number;
		private var right:Number;
		private var top:Number;
		private var bottom:Number;
		private var front:Number;
		private var back:Number;
		private var deflected:Boolean;
		private var newX:Number;
		private var newY:Number;
		private var newZ:Number;
		override protected final function calculateMotionData6D(particle:Particle3D):MotionData6D {
			left = x;
			right = x + width;
			top = y;
			bottom = y + height;
			front = z;
			back = z + depth;
			
			deflected = false;
			if (particle.x < x) deflected = true;
			else if (particle.x > (x + width)) deflected = true;
			if (particle.y < y) deflected = true;
			else if (particle.y > (y + height)) deflected = true;
			if (particle.z < z) deflected = true;
			else if (particle.z > (z + depth)) deflected = true;
			
			newX = StardustMath.mod(particle.x - x, width);
			newY = StardustMath.mod(particle.y - y, height);
			newZ = StardustMath.mod(particle.z - z, depth);
			
			if (deflected) return MotionData6DPool.get(x + newX, y + newY, z + newZ, particle.vx, particle.vy, particle.vz);
			else return null;
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "WrappingCube";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			delete xml.@bounce;
			
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