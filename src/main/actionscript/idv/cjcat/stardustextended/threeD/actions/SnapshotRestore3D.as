package idv.cjcat.stardustextended.threeD.actions  {

    import idv.cjcat.stardustextended.cjsignals.ISignal;
    import idv.cjcat.stardustextended.cjsignals.Signal;
    import idv.cjcat.stardustextended.common.easing.EasingFunctionType;
	import idv.cjcat.stardustextended.common.easing.Linear;
	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.math.Random;
	import idv.cjcat.stardustextended.common.math.StardustMath;
	import idv.cjcat.stardustextended.common.math.UniformRandom;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.threeD.particles.Particle3D;
	
	/**
	 * Restores particle states to previously taken "snapshot" by the <code>Snapshot3D</code> class. 
	 * You can also specify the duration and easing curve for the restoration process.
	 * 
	 * <p>
	 * Default priority = -7;
	 * </p>
	 * 
	 * @see idv.cjcat.stardustextended.threeD.actions.Snapshot3D
	 */
	public class SnapshotRestore3D extends Action3D {
		
		
		//signals
		//------------------------------------------------------------------------------------------------
		
		private var _onComplete:ISignal = new Signal(SnapshotRestore3D);
		/**
		 * Dispatched when the snapshot restoration is complete.
		 * <p/>
		 * Signature: (snapshotRestore3D:SnapshotRestore3D)
		 */
		public function get onComplete():ISignal { return _onComplete; }
		
		//------------------------------------------------------------------------------------------------
		//end of signals
		
		
		/**
		 * Flags determining whether the positions, rotations, or scales of particles are restored.
		 * @see idv.cjcat.stardustextended.threeD.actions.SnapshotRestore3DFlag
		 */
		public var flags:int;
		private var _duration:Random;
		private var _curve:Function;
		
		public function SnapshotRestore3D(duration:Random = null, flags:int = 1, curve:Function = null) {
			priority = -7;
			
			this.duration = duration;
			this.flags = flags;
			this.curve = curve;
		}
		
		private var _started:Boolean = false;
		private var _started2:Boolean = false;
		private var _counter:Number;
		private var _maxDuration:Number;
		public function start():void {
			_started = true;
			_started2 = true;
			_counter = 0;
			_maxDuration = _duration.getRange()[1];
		}
		
		/**
		 * The duration of snapshot restoration for a particle.
		 */
		public function get duration():Random { return _duration; }
		public function set duration(value:Random):void {
			if (!value) value = new UniformRandom(0, 0);
			_duration = value;
		}
		private var _durationKey:Object = {};
		
		override public final function preUpdate(emitter:Emitter, time:Number):void {
			_counter += time;
			_counter = StardustMath.clamp(_counter, 0, _maxDuration);
		}
		
		override public final function update(emitter:Emitter, particle:Particle, timeDelta:Number, currentTime:Number):void {
			if (!_started) {
				skipThisAction = true;
				return;
			}
			
			var p3D:Particle3D = Particle3D(particle);
			if (!p3D.dictionary[Snapshot3D]) return;
			
			if (_started2) {
				p3D.dictionary[SnapshotRestore3D] = new SnapshotData3D(p3D);
				p3D.dictionary[_durationKey] = _duration.random();
			}
			var initData:SnapshotData3D = p3D.dictionary[SnapshotRestore3D] as SnapshotData3D;
			var finalData:SnapshotData3D = p3D.dictionary[Snapshot3D] as SnapshotData3D;
			var duration:Number = p3D.dictionary[_durationKey];
			var counter:Number = StardustMath.clamp(_counter, 0, duration);
			
			if (flags & SnapshotRestore3DFlag.POSITION) {
				p3D.x = curve.apply(null, [counter, initData.x, finalData.x - initData.x, duration]);
				p3D.y = curve.apply(null, [counter, initData.y, finalData.y - initData.y, duration]);
				p3D.z = curve.apply(null, [counter, initData.z, finalData.z - initData.z, duration]);
			}
			
			if (flags & SnapshotRestore3DFlag.ROTATION) {
				p3D.rotationX = curve.apply(null, [counter, initData.rotationX, finalData.rotationX - initData.rotationX, duration]);
				p3D.rotationY = curve.apply(null, [counter, initData.rotationY, finalData.rotationY - initData.rotationY, duration]);
				p3D.rotationZ = curve.apply(null, [counter, initData.rotationZ, finalData.rotationZ - initData.rotationZ, duration]);
			}
			
			if (flags & SnapshotRestore3DFlag.SCALE) {
				p3D.scale = curve.apply(null, [counter, initData.scale, finalData.scale - initData.scale, duration]);
			}
			
			p3D.vx = p3D.vy = p3D.vz = p3D.omegaX = p3D.omegaY = p3D.omegaZ = 0;
		}
		
		override public final function postUpdate(emitter:Emitter, time:Number):void {
			if (_started2) _started2 = false;
			if (_started) {
				if (_counter >= _maxDuration) {
					_started = false;
					onComplete.dispatch(this);
				}
			}
		}
		
		/**
		 * The easing function for snapshot restoration.
		 */
		public function get curve():Function { return _curve; }
		public function set curve(value:Function):void {
			if (value == null) value = Linear.easeOut;
			_curve = value;
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObjects():Array {
			return [_duration];
		}
		
		override public function getXMLTagName():String {
			return "SnapshotRestore3D";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@duration = duration.name;
			xml.@flags = flags;
			xml.@curve = EasingFunctionType.functions[curve];
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@duration.length()) duration = builder.getElementByName(xml.@duration) as Random;
			if (xml.@flags.length()) flags = parseInt(xml.@flags);
			if (xml.@curve.length()) curve = EasingFunctionType.functions[xml.@curve.toString()];
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}