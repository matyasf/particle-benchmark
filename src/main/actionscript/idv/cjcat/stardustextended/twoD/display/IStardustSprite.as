package idv.cjcat.stardustextended.twoD.display {
	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.particles.Particle;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IStardustSprite {
		/**
		 * [Template Method] This method is called by the <code>StardustSpriteInit</code> initializer.
		 * @param	particle
		 */
		function init(particle:Particle):void;
		
		/**
		 * [Template Method] This method is called by the <code>StardustSpriteUpdate</code> action.
		 * @param	emitter
		 * @param	particle
		 * @param	time
		 */
		function update(emitter:Emitter, particle:Particle, time:Number):void;
		
		/**
		 * [Template Method] This method is called by the <code>PooledDisplayObjectClass</code> initializer's <code>recycleInfo()</code> method. 
		 * Release your display object's resource here.
		 * @param	emitter
		 * @param	particle
		 * @param	time
		 */
		function disable():void;
	}
}