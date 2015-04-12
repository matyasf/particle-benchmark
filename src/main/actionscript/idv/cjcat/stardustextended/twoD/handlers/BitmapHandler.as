package idv.cjcat.stardustextended.twoD.handlers {
	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import idv.cjcat.stardustextended.common.math.StardustMath;
	import flash.display.BitmapData;
	import idv.cjcat.stardustextended.common.handlers.ParticleHandler;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.twoD.particles.Particle2D;
	
	/**
	 * This handler draws display object particles into a bitmap.
	 */
	public class BitmapHandler extends ParticleHandler {
		
		/**
		 * The target bitmap to draw display object into.
		 */
		public var targetBitmapData:BitmapData;
		/**
		 * The blend mode for drawing.
		 */
		public var blendMode:String;
		
		public function BitmapHandler(targetBitmapData:BitmapData = null, blendMode:String = "normal") {
			this.targetBitmapData = targetBitmapData;
			this.blendMode = blendMode;
		}
		
		private var p2D:Particle2D;
		private var displayObj:DisplayObject;
		private var mat:Matrix = new Matrix();
		private var colorTransform:ColorTransform = new ColorTransform(1, 1, 1);
		override public function readParticle(particle:Particle):void {
			p2D = Particle2D(particle);
			
			displayObj = DisplayObject(particle.target);
				
			mat.identity();
			mat.scale(particle.scale, particle.scale);
			mat.rotate(p2D.rotation * StardustMath.DEGREE_TO_RADIAN);
			mat.translate(p2D.x, p2D.y);
			
			colorTransform.alphaMultiplier = particle.alpha;
			
			targetBitmapData.draw(displayObj, mat, colorTransform, blendMode);
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "BitmapHandler";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@blendMode = blendMode;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@blendMode.length()) blendMode = xml.@blendMode;
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}