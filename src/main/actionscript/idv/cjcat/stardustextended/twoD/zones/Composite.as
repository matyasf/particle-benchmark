package idv.cjcat.stardustextended.twoD.zones {
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.twoD.geom.MotionData2D;
	
	/**
	 * This is a group of zones. 
	 * 
	 * <p>
	 * The <code>calculateMotionData2D()</code> method returns random points in these zones. 
	 * These points are more likely to be situated in zones with bigger area.
	 * </p>
	 */
	public class Composite extends Zone {
		
		private var _zones:Vector.<Zone>;
		
		public function Composite() {
			_zones = new Vector.<Zone>();
		}
		
		override public function calculateMotionData2D():MotionData2D {
            var sumArea : Number = 0;
            var areas : Array = [];
            for (var i:int = 0; i < _zones.length; i++) {
                sumArea += Zone(_zones[i]).getArea();
                areas.push(sumArea);
            }
			var position:Number = Math.random() * sumArea;
			for (i = 0; i < areas.length; i++) {
				if (position <= areas[i]) {
					return Zone(_zones[i]).calculateMotionData2D();
				}
			}
            return new MotionData2D(); // this should not happen
		}
		
		override public function contains(x:Number, y:Number):Boolean {
			for each (var zone:Zone in _zones) {
				if (zone.contains(x, y)) return true;
			}
			return false;
		}
		
		public final function addZone(zone:Zone):void {
			_zones.push(zone);
		}
		
		public final function removeZone(zone:Zone):void {
			var index:int;
			while ((index = _zones.indexOf(zone)) >= 0) {
				_zones.splice(index, 1);
			}
		}
		
		public final function clearZones():void {
			_zones = new Vector.<Zone>();
		}

        public function get zones():Vector.<Zone> {
            return _zones;
        }

        override public function setPosition(xc : Number, yc : Number):void {
            for each (var zone:Zone in _zones) {
                zone.setPosition(xc, yc);
            }
        }

		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObjects():Array {
            var len:int = _zones.length;
            var ret:Array = new Array(len);
            for (var i:int = 0; i < len; ++i)
            {
                ret[i] = _zones[i];
            }
            return ret;
		}
		
		override public function getXMLTagName():String {
			return "CompositeZone";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			if (_zones.length > 0) {
				xml.appendChild(<zones/>);
				var zone:Zone;
				for each (zone in _zones) {
					xml.zones.appendChild(zone.getXMLTag());
				}
			}
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			clearZones();
			for each (var node:XML in xml.zones.*) {
				addZone(builder.getElementByName(node.@name) as Zone);
			}
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}