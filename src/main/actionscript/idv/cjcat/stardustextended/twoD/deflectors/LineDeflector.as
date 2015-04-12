package idv.cjcat.stardustextended.twoD.deflectors {
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.twoD.geom.MotionData4D;
	import idv.cjcat.stardustextended.twoD.geom.MotionData4DPool;
	import idv.cjcat.stardustextended.twoD.geom.Vec2D;
	import idv.cjcat.stardustextended.twoD.geom.Vec2DPool;
	import idv.cjcat.stardustextended.twoD.particles.Particle2D;
	
	/**
	 * Infinitely long line-shaped obstacle. 
	 * One side of the line is free space, and the other side is "solid", 
	 * not allowing any particle to go through. 
	 * The line is defined by a point it passes through and its normal vector.
	 * 
	 * <p>
	 * When a particle hits the border, it bounces back.
	 * </p>
	 */
	public class LineDeflector extends Deflector {
		
		/**
		 * The X coordinate of a point the border passes through.
		 */
		public var x:Number;
		/**
		 * The Y coordinate of a point the border passes through.
		 */
		public var y:Number;
		private var _normal:Vec2D;
		
		public function LineDeflector(x:Number = 0, y:Number = 0, nx:Number = 0, ny:Number = -1) {
			this.x = x;
			this.y = y;
			_normal = new Vec2D(nx, ny);
		}
		
		/**
		 * The normal of the border, pointing to the free space side.
		 */
		public function get normal():Vec2D { return _normal; }

		private var r:Vec2D;
		private var dot:Number;
		private var radius:Number;
		private var dist:Number;
		private var v:Vec2D;
		private var factor:Number;
		override protected function calculateMotionData4D(particle:Particle2D):MotionData4D {
			//normal displacement
			r = Vec2DPool.get(particle.x - x, particle.y - y);
			r = r.project(_normal);
			
			dot = r.dot(_normal);
			radius = particle.collisionRadius * particle.scale;
			dist = r.length;

			if (dot > 0) {
				if (dist > radius) {
					//no collision detected
					Vec2DPool.recycle(r);
					return null;
				} else {
					r.length = radius - dist;
				}
			} else {
				//collision detected
				r.length = -(dist + radius);
			}

			v = Vec2DPool.get(particle.vx, particle.vy);
			v = v.project(_normal);
			
			factor = 1 + bounce;
			
			Vec2DPool.recycle(r);
			Vec2DPool.recycle(v);
			return MotionData4DPool.get(particle.x + r.x, particle.y + r.y,
									   (particle.vx - v.x * factor) * slipperiness, (particle.vy - v.y * factor) * slipperiness);
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "LineDeflector";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			xml.@x = x;
			xml.@y = y;
			xml.@normalX = _normal.x;
			xml.@normalY = _normal.y;
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			if (xml.@x.length()) x = parseFloat(xml.@x);
			if (xml.@y.length()) y = parseFloat(xml.@y);
			if (xml.@normalX.length()) _normal.x = parseFloat(xml.@normalX);
			if (xml.@normalY.length()) _normal.y = parseFloat(xml.@normalY);
		}

		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}