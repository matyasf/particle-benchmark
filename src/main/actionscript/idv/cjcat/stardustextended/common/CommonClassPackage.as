package idv.cjcat.stardustextended.common {
	import idv.cjcat.stardustextended.common.actions.Age;
	import idv.cjcat.stardustextended.common.actions.AlphaCurve;
import idv.cjcat.stardustextended.common.actions.ColorCurve;
import idv.cjcat.stardustextended.common.actions.CompositeAction;
	import idv.cjcat.stardustextended.common.actions.DeathLife;
	import idv.cjcat.stardustextended.common.actions.Die;
	import idv.cjcat.stardustextended.common.actions.ScaleCurve;
	import idv.cjcat.stardustextended.common.actions.triggers.DeathTrigger;
	import idv.cjcat.stardustextended.common.actions.triggers.LifeTrigger;
	import idv.cjcat.stardustextended.common.clocks.CompositeClock;
	import idv.cjcat.stardustextended.common.clocks.ImpulseClock;
	import idv.cjcat.stardustextended.common.clocks.RandomClock;
	import idv.cjcat.stardustextended.common.clocks.SteadyClock;
	import idv.cjcat.stardustextended.common.handlers.PollingStation;
	import idv.cjcat.stardustextended.common.initializers.Alpha;
	import idv.cjcat.stardustextended.common.initializers.CollisionRadius;
	import idv.cjcat.stardustextended.common.initializers.Color;
	import idv.cjcat.stardustextended.common.handlers.ParticleHandler;
	import idv.cjcat.stardustextended.common.initializers.CompositeInitializer;
	import idv.cjcat.stardustextended.common.initializers.Life;
	import idv.cjcat.stardustextended.common.initializers.Mask;
	import idv.cjcat.stardustextended.common.initializers.Mass;
	import idv.cjcat.stardustextended.common.initializers.Scale;
	import idv.cjcat.stardustextended.common.initializers.SwitchInitializer;
	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.math.AveragedRandom;
	import idv.cjcat.stardustextended.common.math.UniformRandom;
	import idv.cjcat.stardustextended.common.xml.ClassPackage;
	
	/**
	 * Packs together common classes for both 2D and 3D.
	 */
	public class CommonClassPackage extends ClassPackage {
		
		private static var _instance:CommonClassPackage;
		
		public static function getInstance():CommonClassPackage {
			if (!_instance) _instance = new CommonClassPackage();
			return _instance;
		}
		
		public function CommonClassPackage() {
			
		}
		
		
		override protected final function populateClasses():void {
			//common actions
			classes.push(AlphaCurve);
			classes.push(CompositeAction);
			classes.push(DeathLife);
			classes.push(Die);
			classes.push(ScaleCurve);
			classes.push(ColorCurve);

			//common action triggers
			classes.push(DeathTrigger);
			classes.push(LifeTrigger);
			
			//common clocks
			classes.push(CompositeClock);
			classes.push(ImpulseClock);
			classes.push(RandomClock);
			classes.push(SteadyClock);
			
			//common emitters
			classes.push(Emitter);
			
			//common initializers
			classes.push(Age);
			classes.push(Alpha);
			classes.push(CollisionRadius);
			classes.push(Color);
			classes.push(CompositeInitializer);
			classes.push(Life);
			classes.push(Mask);
			classes.push(Mass);
			classes.push(Scale);
			classes.push(SwitchInitializer);
			
			//common particle handlers
			classes.push(PollingStation);
			
			//common randoms
			classes.push(AveragedRandom);
			classes.push(UniformRandom);
			
			classes.push(ParticleHandler);
		}
	}
}