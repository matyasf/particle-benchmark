package idv.cjcat.stardustextended.twoD.fields {
	import flash.display.BitmapData;
	import idv.cjcat.stardustextended.common.math.StardustMath;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.twoD.geom.MotionData2D;
	import idv.cjcat.stardustextended.twoD.geom.MotionData2DPool;
	import idv.cjcat.stardustextended.twoD.particles.Particle2D;
	
	/**
	 * Vector field based on a bitmap.
	 * 
	 * <p>
	 * For instance, if a pixel at (10, 12) has a color of "R = 100, G = 50, B = 0", 
	 * and the values of the <code>channelX</code> and <code>channelY</code> are 1 (red) and 2(green), respectively (blue is 4), 
	 * then the coordinate (10, 12) of the field corresponds to a <code>MotionData2D</code> object with X and Y components equal to 
	 * "max * (100 - 128) / 255" and "max * (50 - 128) / 255", respectively.
	 * </p>
	 * 
	 * <p>
	 * This field can be combined with perlin noise bitmaps to create turbulence vector fields.
	 * </p>
	 */
	public class BitmapField extends Field {
		
		/**
		 * The X coordinate of the top-left coordinate.
		 */
		public var x:Number;
		/**
		 * The Y coordinate of the top-left coordinate.
		 */
		public var y:Number;
		/**
		 * The color channel for the horizontal direction.
		 */
		public var channelX:uint;
		/**
		 * The color channel for the vertical direction.
		 */
		public var channelY:uint;
		/**
		 * The maximum value of the returned <code>MotionData2D</code> object's components.
		 */
		public var max:Number;
		/**
		 * The horizontal scale of the bitmap.
		 */
		public var scaleX:Number;
		/**
		 * The vertical scale of the bitmap.
		 */
		public var scaleY:Number;
		/**
		 * Whether the bitmap tiles (i.e. repeats) infinitely.
		 */
		public var tile:Boolean;
		
		private var _bmpd:BitmapData;
		
		public function BitmapField(x:Number = 0, y:Number = 0, max:Number = 1, channelX:uint = 1, channelY:uint = 2) {
			this.x = x;
			this.y = y;
			this.max = max;
			this.channelX = channelX;
			this.channelY = channelY;
			this.scaleX = 1;
			this.scaleY = 1;
			this.tile = true;
			
			update();
		}
		
		public function update(bitmapData:BitmapData = null):void {
			if (!bitmapData) bitmapData = new BitmapData(1, 1, false, 0x808080);
			_bmpd = bitmapData;
		}
		
		private var px:Number;
		private var py:Number;
		private var color:int;
		private var finalX:Number;
		private var finalY:Number;
		override protected function calculateMotionData2D(particle:Particle2D):MotionData2D {
			px = particle.x / scaleX;
			py = particle.y / scaleY;
			
			if (tile) {
				px = StardustMath.mod(px, _bmpd.width);
				py = StardustMath.mod(py, _bmpd.height);
			} else {
				if ((px < 0) || (px >= _bmpd.width) || (py < 0) || (py >= _bmpd.height)) {
					return null;
				}
			}
			
			color = _bmpd.getPixel(int(px), int(py));
			switch (channelX) {
				case 1:
					finalX = 2 * ((((color & 0xFF0000) >> 16) / 255) - 0.5) * max;
					break;
				case 2:
					finalX = 2 * ((((color & 0x00FF00) >> 8) / 255) - 0.5) * max;
					break;
				case 4:
					finalX = 2 * (((color & 0x0000FF) / 255) - 0.5) * max;
					break;
			}
			
			switch (channelY) {
				case 1:
					finalY = 2 * ((((color & 0xFF0000) >> 16) / 255) - 0.5) * max;
					break;
				case 2:
					finalY = 2 * ((((color & 0x00FF00) >> 8) / 255) - 0.5) * max;
					break;
				case 4:
					finalY = 2 * (((color & 0x0000FF) / 255) - 0.5) * max;
					break;
			}
			
			return MotionData2DPool.get(finalX, finalY);
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "BitmapField";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@x = x;
			xml.@y = y;
			xml.@channelX = channelX;
			xml.@channelY = channelY;
			xml.@max = max;
			xml.@scaleX = scaleX;
			xml.@scaleY = scaleY;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@x.length()) x = parseFloat(xml.@x);
			if (xml.@y.length()) y = parseFloat(xml.@y);
			if (xml.@channelX.length()) channelX = parseFloat(xml.@channelX);
			if (xml.@channelY.length()) channelY = parseFloat(xml.@channelY);
			if (xml.@max.length()) max = parseFloat(xml.@max);
			if (xml.@scaleX.length()) scaleX = parseFloat(xml.@scaleX);
			if (xml.@scaleY.length()) scaleY = parseFloat(xml.@scaleY);
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}