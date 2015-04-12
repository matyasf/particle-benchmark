package idv.cjcat.stardustextended.threeD.handlers {

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.handlers.ParticleHandler;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.threeD.cameras.Camera3D;
	import idv.cjcat.stardustextended.threeD.geom.Matrix3D;
	import idv.cjcat.stardustextended.threeD.geom.Vec3D;
	import idv.cjcat.stardustextended.threeD.geom.ZData;
	import idv.cjcat.stardustextended.threeD.geom.ZDataPool;
	import idv.cjcat.stardustextended.threeD.particles.Particle3D;
	
	/**
	 * This handler adds display object particles to the target container's display list, 
	 * removes dead particles from the display list, 
	 * and updates the display object's x, y, rotation, scaleX, scaleY, and alpha properties, 
	 * applying 3D Z-sorting and optional perspective projection to the diplay objects.
	 */
	public class DisplayObjectHandler3D extends ParticleHandler {
		
		/**
		 * The target container.
		 */
		public var container:DisplayObjectContainer;
		/**
		 * Whether to change a display object's parent to the target container if the object already belongs to another parent.
		 */
		public var forceParentChange:Boolean;
		
		private var _camera:Camera3D;
		public function get camera():Camera3D { return _camera; }
		public function set camera(value:Camera3D):void {
			if (!value) {
				value = new Camera3D();
				value.position.set(0, 0, -1000);
			}
			_camera = value;
		}
		
		public function DisplayObjectHandler3D(container:DisplayObjectContainer = null, camera:Camera3D = null) {
			this.container = container;
			this.camera = camera;
			forceParentChange = false;
		}
		
		private var displayObj:DisplayObject;
		
		override public final function particleAdded(particle:Particle):void {
			displayObj = DisplayObject(particle.target);
			if (!forceParentChange && displayObj.parent) return;
			container.addChild(displayObj);
		}
		
		override public final function particleRemoved(particle:Particle):void {
			displayObj = DisplayObject(particle.target);
			displayObj.parent.removeChild(displayObj);
		}
		
		private var _cameraMatrix:Matrix3D = new Matrix3D();
		private var _cameraDiff:Vec3D = new Vec3D();
		private var _zdList:Array = [];
		private var i:int, j:int;
		
		override final public function stepBegin(emitter:Emitter, particles:Vector.<Particle>, time:Number):void {
			_cameraMatrix.identity();
			_cameraMatrix.rotateY(Math.atan2(-_camera.direction.x, _camera.direction.z));
			_cameraMatrix.rotateX(Math.atan2(_camera.direction.y, Math.sqrt(_camera.direction.x * _camera.direction.x + _camera.direction.z * _camera.direction.z)));
			
			_zdList.length = 0;
			_zdList.length = particles.length;
			
			i = 0;
		}
		
		private var p3D:Particle3D;
		
		override public function readParticle(particle:Particle):void {
			p3D = Particle3D(particle);
			
			_cameraDiff.set(p3D.x - _camera.position.x, p3D.y - _camera.position.y, p3D.z - _camera.position.z);
			_cameraMatrix.transformThisVec(_cameraDiff);
			
			particle.dictionary[DisplayObjectHandler3D] =
			_zdList[i++] = ZDataPool.get(DisplayObject(particle.target), p3D, _cameraDiff.x, _cameraDiff.y, _cameraDiff.z);
			
			_cameraDiff.set(p3D.vx, p3D.vy, p3D.vz);
			_cameraMatrix.transformThisVec(_cameraDiff);
			
			//screen velocity
			p3D.screenVX = _cameraDiff.x;
			p3D.screenVY = _cameraDiff.y;
		}
		
		override final public function stepEnd(emitter:Emitter, particles:Vector.<Particle>, time:Number):void {
			_zdList.sort(zdSorter);
			
			var focalLength_inv:Number = 1 / _camera.focalLength;
			var zd:ZData;
			for (j = 0; j < i; ++j) {
				zd = _zdList[j];
				
				container.addChild(zd.displayObject);
				
				if (zd.cameraDiff.z < 0) {
					zd.displayObject.visible = false;
				} else {
					zd.displayObject.visible = true;
				}
				
				//calculate screen velocity
				if (_camera.usePerspective) {
					var factor:Number = _camera.zoom / ((zd.cameraDiff.z * focalLength_inv) + 1);
					zd.particle.screenX = zd.cameraDiff.x * factor;
					zd.particle.screenY = zd.cameraDiff.y * factor;
					zd.particle.dictionary[DisplayObjectHandler3D] = factor * zd.particle.initScale;
				} else {
					zd.particle.screenX = _camera.zoom * zd.cameraDiff.x;
					zd.particle.screenY = _camera.zoom * zd.cameraDiff.y;
					zd.particle.dictionary[DisplayObjectHandler3D] = 1;
				}
				
				renderDisplayObject(zd.particle);
				ZDataPool.recycle(zd);
			}
		}
		
		private function zdSorter(zd1:ZData, zd2:ZData):Number {
			if (zd1.cameraDiff.z > zd2.cameraDiff.z) return -1;
			return 1;
		}
		
		private function renderDisplayObject(particle:Particle3D):void {
			var displayObj:DisplayObject = DisplayObject(particle.target);
			if (!displayObj) return;
			
			displayObj.x = particle.screenX;
			displayObj.y = particle.screenY;
			displayObj.rotation = particle.rotationZ;
			displayObj.scaleX = displayObj.scaleY = particle.scale * Number(particle.dictionary[DisplayObjectHandler3D]);
			displayObj.alpha = particle.alpha;
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "DisplayObjectHandler3D";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@forceParentChange = forceParentChange;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@forceParentChange.length()) forceParentChange = (xml.@forceParentChange == "true");
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}