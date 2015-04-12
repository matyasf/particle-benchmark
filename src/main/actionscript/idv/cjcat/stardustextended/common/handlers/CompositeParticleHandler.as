package idv.cjcat.stardustextended.common.handlers {

	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	
	public class CompositeParticleHandler extends ParticleHandler {
		
		protected var handlers:Array;
		public function CompositeParticleHandler() {
			handlers = [];
		}
		
		override public final function stepBegin(emitter:Emitter, particles:Vector.<Particle>, time:Number):void {
			for (i = 0, len = handlers.length; i < len; ++i) {
				ParticleHandler(handlers[i]).stepBegin(emitter, particles, time);
			}
		}
		
		override public final function stepEnd(emitter:Emitter, particles:Vector.<Particle>, time:Number):void {
			for (i = 0, len = handlers.length; i < len; ++i) {
				ParticleHandler(handlers[i]).stepEnd(emitter, particles, time);
			}
		}
		
		private var i:int, len:int;
		
		override public final function particleAdded(particle:Particle):void {
			for (i = 0, len = handlers.length; i < len; ++i) {
				ParticleHandler(handlers[i]).particleAdded(particle);
			}
		}
		
		override public final function particleRemoved(particle:Particle):void {
			for (i = 0, len = handlers.length; i < len; ++i) {
				ParticleHandler(handlers[i]).particleRemoved(particle);
			}
		}
		
		override public final function readParticle(particle:Particle):void {
			for (i = 0, len = handlers.length; i < len; ++i) {
				ParticleHandler(handlers[i]).readParticle(particle);
			}
		}
		
		public function addParticleHandler(particleHandler:ParticleHandler):void {
			if (handlers.indexOf(particleHandler) < 0) handlers.push(particleHandler);
		}
		
		public function removeParticleHandler(particleHandler:ParticleHandler):void {
			var index:int;
			if ((index = handlers.indexOf(particleHandler)) >= 0) {
				handlers.splice(index, 1);
			}
		}
		
		public function clearParticleHandlers():void {
			for (i = 0, len = handlers.length; i < len; ++i) {
				removeParticleHandler(ParticleHandler(handlers[i]));
			}
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObjects():Array {
			return handlers;
		}
		
		override public function getXMLTagName():String {
			return "CompositeParticleHandler";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			if (handlers.length) {
				xml.appendChild(<handlers/>);
				for (i = 0, len = handlers.length; i < len; ++i) {
					xml.handlers.appendChild(ParticleHandler(handlers[i]).getXMLTag());
				}
			}
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			clearParticleHandlers();
			for each (var node:XML in xml.handlers.*) {
				addParticleHandler(ParticleHandler(builder.getElementByName(node.@name)));
			}
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}