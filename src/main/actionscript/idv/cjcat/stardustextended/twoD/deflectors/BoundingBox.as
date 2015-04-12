package idv.cjcat.stardustextended.twoD.deflectors {
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.twoD.geom.MotionData4D;
	import idv.cjcat.stardustextended.twoD.geom.MotionData4DPool;
	import idv.cjcat.stardustextended.twoD.particles.Particle2D;
	
	/**
	 * Causes particles to be bounded within a rectangular region.
	 * 
	 * <p>
	 * When a particle hits the walls of the region, it bounces back.
	 * </p>
	 */
	public class BoundingBox extends Deflector {
		
		/**
		 * The X coordinate of the top-left corner.
		 */
		public var x:Number;
		/**
		 * The Y coordinate of the top-left corner.
		 */
		public var y:Number;
		/**
		 * The width of the region.
		 */
		public var width:Number;
		/**
		 * The height of the region.
		 */
		public var height:Number;
		
		public function BoundingBox(x:Number = 0, y:Number = 0, width:Number = 640, height:Number = 480) {
			this.bounce = 1;
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
		}
		
		private var radius:Number;
		private var left:Number;
		private var right:Number;
		private var top:Number;
		private var bottom:Number;
		private var factor:Number;
		private var finalX:Number;
		private var finalY:Number;
		private var finalVX:Number;
		private var finalVY:Number;
		private var deflected:Boolean;
		override protected function calculateMotionData4D(particle:Particle2D):MotionData4D {
			radius = particle.collisionRadius * particle.scale;
			left = x + radius;
			right = x + width - radius;
			top = y + radius;
			bottom = y + height - radius;
			
			factor = -bounce;
			
			finalX = particle.x;
			finalY = particle.y;
			finalVX = particle.vx;
			finalVY = particle.vy;
			
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
			
			if (deflected) return MotionData4DPool.get(finalX, finalY, finalVX, finalVY);
			else return null;
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "BoundingBox";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@x = x;
			xml.@y = y;
			xml.@width = width;
			xml.@height = height;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@x.length()) x = parseFloat(xml.@x);
			if (xml.@y.length()) y = parseFloat(xml.@y);
			if (xml.@width.length()) width = parseFloat(xml.@width);
			if (xml.@height.length()) height = parseFloat(xml.@height);
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}