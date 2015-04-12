package idv.cjcat.stardustextended.twoD.initializers {

import flash.display.DisplayObject;
import flash.utils.getDefinitionByName;
import flash.utils.getQualifiedClassName;

import idv.cjcat.stardustextended.common.particles.Particle;
import idv.cjcat.stardustextended.common.xml.XMLBuilder;
import idv.cjcat.stardustextended.twoD.display.IStardustSprite;
	import idv.cjcat.stardustextended.twoD.utils.DisplayObjectPool;

	/**
	 * This is a pooled version of the <code>DisplayObjectClass</code> initializer, 
	 * which makes use of an object pool to reuse display objects, 
	 * saving time spent for instantiating new display objects.
	 * 
	 * <p>
	 * Default priority = 1;
	 * </p>
	 * 
	 * @see idv.cjcat.stardustextended.twoD.initializers.DisplayObjectClass
	 */
	public class PooledDisplayObjectClass extends Initializer2D {
		
		private var _constructorParams:Array;
		
		private var _pool:DisplayObjectPool;
		private var _displayObjectClass:Class;
		public function PooledDisplayObjectClass(displayObjectClass:Class = null, constructorParams:Array = null) {
			priority = 1;
			_pool = new DisplayObjectPool();
			
			_displayObjectClass = displayObjectClass;
			_constructorParams = constructorParams;
			if (_displayObjectClass) _pool.reset(_displayObjectClass, _constructorParams);
		}
		
		override public function initialize(p:Particle):void {
			if (_displayObjectClass) p.target = _pool.get();
			
		}
		
		public function get displayObjectClass():Class { return _displayObjectClass; }
		public function set displayObjectClass(value:Class):void {
			_displayObjectClass = value;
			if (_displayObjectClass) _pool.reset(_displayObjectClass, _constructorParams);
		}
		
		public function get constructorParams():Array { return _constructorParams; }
		public function set constructorParams(value:Array):void {
			_constructorParams = value;
			if (_displayObjectClass) _pool.reset(_displayObjectClass, _constructorParams);
		}
		
		override public function recycleInfo(particle:Particle):void {
			var obj:DisplayObject = DisplayObject(particle.target);
			if (obj) {
				if (obj is IStardustSprite) IStardustSprite(obj).disable();
				if (obj is _displayObjectClass) _pool.recycle(obj);
			}
		}

		override public function get needsRecycle():Boolean {
			return true;
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "PooledDisplayObjectClass";
		}

        override public function toXML():XML {
            var xml:XML = super.toXML();
            if (_displayObjectClass) {
                xml.@displayObjectClass = getQualifiedClassName( _displayObjectClass );
            }
            if (_constructorParams && _constructorParams.length > 0)
            {
                var paramStr : String = "";
                for (var i:int=0; i<_constructorParams.length; i++) {
                    paramStr += _constructorParams[i] + ",";
                }
                paramStr = paramStr.substr(0, paramStr.length-1);
                xml.@constructorParameters = paramStr;
            }
            return xml;
        }

        override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
            super.parseXML(xml, builder);
            if (xml.@constructorParameters.length()) {
                constructorParams = String(xml.@constructorParameters ).split(",");
            }
            if (xml.@displayObjectClass.length()) {
                displayObjectClass = getDefinitionByName(  xml.@displayObjectClass ) as Class;
            }
        }
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}