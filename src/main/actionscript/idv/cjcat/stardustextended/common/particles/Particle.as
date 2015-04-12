package idv.cjcat.stardustextended.common.particles {
	import flash.utils.Dictionary;
	
	/**
	 * This class represents a particle and its properties.
	 */
	public class Particle {
		
		/**
		 * The initial life upon birth.
		 */
		public var initLife:Number;
		/**
		 * The normal scale upon birth.
		 */
		public var initScale:Number;
		/**
		 * The normal alpha value upon birth.
		 */
		public var initAlpha:Number;
		
		/**
		 * The remaining life of the particle.
		 */
		public var life:Number;
		/**
		 * The scale of the particle.
		 */
		public var scale:Number;
		/**
		 * The alpha value of the particle.
		 */
		public var alpha:Number;
		/**
		 * The mass of the particle.
		 */
		public var mass:Number;
		/**
		 * The mask value of the particle.
		 * 
		 * <p>
		 * The particle can only affected by an action or initializer only if the bitwise AND of their masks is non-zero.
		 * </p>
		 */
		public var mask:int;
		/**
		 * Whether the particle is marked as dead.
		 * 
		 * <p>
		 * Dead particles would be removed from simulation by an emitter.
		 * </p>
		 */
		public var isDead:Boolean;
		/**
		 * The collision radius of the particle.
		 */
		public var collisionRadius:Number;
		/**
		 * Custom user data of the particle.
		 * 
		 * <p>
		 * Normally, this property contains information for renderers. 
		 * For instance this property should refer to a display object for a <code>DisplayObjectRenderer</code>.
		 * </p>
		 */
		public var target:*;

		/**
		 * current Red color component; in the [0,1] range.
		 */
		public var colorR:Number;
		/**
		 * current Green color component; in the [0,1] range.
		 */
		public var colorG:Number;
		/**
		 * current Blue color component; in the [0,1] range.
		 */
		public var colorB:Number;

        /**
         * initial Red color component; in the [0,1] range.
         */
        public var initColorR:Number;
        /**
         * initial Green color component; in the [0,1] range.
         */
        public var initColorG:Number;
        /**
         * initial Blue color component; in the [0,1] range.
         */
        public var initColorB:Number;
        /**
         * Red color component; in the [0,1] range.
         */
        public var endColorR:Number;
        /**
         * Green color component; in the [0,1] range.
         */
        public var endColorG:Number;
        /**
         * Blue color component; in the [0,1] range.
         */
        public var endColorB:Number;
		/**
		 * Dictionary for storing additional information.
		 */
		public var dictionary:Dictionary;
		
		public var recyclers:Dictionary;

        /**
         * The current frame to display if the particle is animated. Use the AnimateSpriteSheet action to set it.
         */
		public var currentAnimationFrame : int = 0;
		
		public function Particle() {
			dictionary = new Dictionary();
			recyclers = new Dictionary();
		}
		
		/**
		 * Initializes properties to default values.
		 */
		public function init():void {
			initLife = life = currentAnimationFrame = 0;
			initScale = scale = 1;
			initAlpha = alpha = 1;
			mass = 1;
			mask = 1;
			isDead = false;
			collisionRadius = 0;

            initColorR = 1;
            initColorB = 1;
            initColorG = 1;

            colorR = 1;
            colorB = 1;
            colorG = 1;

            endColorR = 0;
            endColorB = 0;
            endColorG = 0;
		}
		
		public function destroy():void {
			target = null;
			var key : *;
			for (key in dictionary) delete dictionary[key];
			for (key in recyclers) delete recyclers[key];
		}

        public static function compareFunction(p1 : Particle, p2 : Particle) : Number
        {
            if (p1["x"] < p2["x"])
            {
                return -1;
            }
            return 1;
        }
	}
}