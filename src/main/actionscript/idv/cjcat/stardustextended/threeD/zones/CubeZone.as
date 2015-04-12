package idv.cjcat.stardustextended.threeD.zones {
	import idv.cjcat.stardustextended.common.math.Random;
	import idv.cjcat.stardustextended.common.math.UniformRandom;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.threeD.geom.MotionData3D;
	
	/**
	 * Rectangle-shaped particle source.
	 */
	public class CubeZone extends Zone3D {
		
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
		
		private var _randomX:Random;
		private var _randomY:Random;
		private var _randomZ:Random;
		private var _width:Number;
		private var _height:Number;
		private var _depth:Number;
		
		public function CubeZone(x:Number = 0, y:Number = 0, z:Number = 0, width:Number = 640, height:Number = 480, depth:Number = 480, randomX:Random = null, randomY:Random = null, randomZ:Random = null) {
			this.x = x;
			this.y = y;
			this.z = z;
			this.width = width;
			this.height = height;
			this.depth = depth;
			this.randomX = randomX;
			this.randomY = randomY;
			this.randomZ = randomZ;
		}
		
		/**
		 * The width of the region.
		 */
		public function get width():Number { return _width; }
		public function set width(value:Number):void {
			_width = value;
			updateVolume();
		}
		
		/**
		 * The height of the region.
		 */
		public function get height():Number { return _height; }
		public function set height(value:Number):void {
			_height = value;
			updateVolume();
		}
		
		/**
		 * The depth of the region.
		 */
		public function get depth():Number { return _depth; }
		public function set depth(value:Number):void {
			_depth = value;
			updateVolume();
		}
		
		public function get randomX():Random { return _randomX; }
		public function set randomX(value:Random):void {
			if (!value) value = new UniformRandom();
			_randomX = value;
		}
		
		public function get randomY():Random { return _randomY; }
		public function set randomY(value:Random):void {
			if (!value) value = new UniformRandom();
			_randomY = value;
		}
		
		public function get randomZ():Random { return _randomZ; }
		public function set randomZ(value:Random):void {
			if (!value) value = new UniformRandom();
			_randomZ = value;
		}
		
		override protected final function updateVolume():void {
			volume = _width * _height * _depth;
		}
		
		override public final function calculateMotionData3D():MotionData3D {
			randomX.setRange(x, x + _width);
			randomY.setRange(y, y + _height);
			randomZ.setRange(z, z + _depth);
			return new MotionData3D(randomX.random(), randomY.random(), randomZ.random());
		}
		
		override public final function contains(x:Number, y:Number, z:Number):Boolean {
			if ((x < this.x) || (x > (this.x + _width))) return false;
			else if ((y < this.y) || (y > (this.y + _height))) return false;
			else if ((z < this.z) || (z > (this.z + _depth))) return false;
			return true;
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObjects():Array {
			return [_randomX, _randomY, _randomZ];
		}
		
		override public function getXMLTagName():String {
			return "CubeZone";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@x = x;
			xml.@y = y;
			xml.@z = z;
			xml.@width = width;
			xml.@height = height;
			xml.@depth = depth;
			xml.@randomX = randomX.name;
			xml.@randomY = randomY.name;
			xml.@randomZ = randomZ.name;
			
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
			if (xml.@randomX.length()) randomX = builder.getElementByName(xml.@randomX) as Random;
			if (xml.@randomY.length()) randomY = builder.getElementByName(xml.@randomY) as Random;
			if (xml.@randomZ.length()) randomZ = builder.getElementByName(xml.@randomZ) as Random;
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}