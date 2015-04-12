package idv.cjcat.stardustextended.threeD.zones {
	import idv.cjcat.stardustextended.common.StardustElement;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.threeD.geom.MotionData3D;
	import idv.cjcat.stardustextended.threeD.geom.Vec3D;
	import idv.cjcat.stardustextended.threeD.geom.Vec3DPool;
	
	public class Zone3D extends StardustElement {
		
		public var rotationX:Number;
		public var rotationY:Number;
		public var rotationZ:Number;
		
		protected var volume:Number;
		public function Zone3D() {
			rotationX = 0;
			rotationY = 0;
			rotationZ = 0;
		}
		
		/**
		 * [Abstract Method] Updates the volume of the zone.
		 */
		protected function updateVolume():void {
			//abstract method
		}
		
		/**
		 * [Abstract Method] Determins if a point is contained by the zone, true if contained.
		 * @param	x
		 * @param	y
		 * @param	z
		 * @return
		 */
		public function contains(x:Number, y:Number, z:Number):Boolean {
			//abstract method
			return false;
		}
		
		public final function getPoint():MotionData3D {
			var md3D:MotionData3D = calculateMotionData3D();
			var v:Vec3D;
			if (rotationZ != 0) {
				v = Vec3DPool.get(md3D.x, md3D.y, md3D.z);
				v.rotateZThis(rotationZ);
				md3D.x = v.x;
				md3D.y = v.y;
				md3D.z = v.z;
				Vec3DPool.recycle(v);
			}
			if (rotationY != 0) {
				v = Vec3DPool.get(md3D.x, md3D.y, md3D.z);
				v.rotateYThis(rotationY);
				md3D.x = v.x;
				md3D.y = v.y;
				md3D.z = v.z;
				Vec3DPool.recycle(v);
			}
			if (rotationX != 0) {
				v = Vec3DPool.get(md3D.x, md3D.y, md3D.z);
				v.rotateXThis(rotationX);
				md3D.x = v.x;
				md3D.y = v.y;
				md3D.z = v.z;
				Vec3DPool.recycle(v);
			}
			
			return md3D;
		}
		
		/**
		 * [Abstract Method] Returns a <code>MotionData3D</code> object representing a random point in the zone.
		 * @return
		 */
		public function calculateMotionData3D():MotionData3D {
			//abstract method
			return null;
		}
		
		/**
		 * Returns the volume of the zone.
		 * @return
		 */
		public final function getVolume():Number {
			return volume;
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "Zone3D";
		}
		
		override public function getElementTypeXMLTag():XML {
			return <zones/>;
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			
			xml.@rotationX = rotationX;
			xml.@rotationY = rotationY;
			xml.@rotationZ = rotationZ;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@rotationX.length()) rotationX = parseFloat(xml.@rotationX);
			if (xml.@rotationY.length()) rotationY = parseFloat(xml.@rotationY);
			if (xml.@rotationZ.length()) rotationZ = parseFloat(xml.@rotationZ);
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}