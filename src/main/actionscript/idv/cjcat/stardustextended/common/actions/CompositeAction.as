package idv.cjcat.stardustextended.common.actions {

	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	/**
	 * This actions is a group of actions. Multiple actions can be grouped together into one single composite action.
	 * 
	 * <p>
	 * Note that if the bitwise AND of a composite action's mask and a particle's mask is non-zero, 
	 * all underlying component actions' <code>update()</code> methods will be called for the particle, 
	 * without further checking the masks of these actions if the <code>checkComponentMasks</code> property is false, 
	 * which is false by default.
	 * </p>
	 */
	public class CompositeAction extends Action implements ActionCollector {
		
		public var checkComponentMasks:Boolean;
		
		protected var _actionCollection:ActionCollection;

		public function CompositeAction() {
			checkComponentMasks = false;
			_actionCollection = new ActionCollection();
		}
		
		private var activeActions:Array;
		override public final function preUpdate(emitter:Emitter, time:Number):void {
			activeActions = [];
			for each (var action:Action in _actionCollection.actions) {
				if (action.active) {
					if (action.mask) {
						activeActions.push(action);
						action.preUpdate(emitter, time);
					}
				}
			}
		}
		
		override public function update(emitter:Emitter, particle:Particle, timeDelta:Number, currentTime:Number):void {
			var action:Action;
			if (checkComponentMasks) {
				for each (action in activeActions) {
					if (action.mask & particle.mask) action.update(emitter, particle, timeDelta, currentTime);
				}
			} else {
				for each (action in activeActions) {
					action.update(emitter, particle, timeDelta, currentTime);
				}
			}
		}
		
		override public final function postUpdate(emitter:Emitter, time:Number):void {
			activeActions = null;
		}
		
		/**
		 * Adds an action to the composite action.
		 * @param	action
		 */
		public function addAction(action:Action):void {
			_actionCollection.actions.push(action);
			action.onPriorityChange.add(sortActions);
			sortActions();
		}
		
		/**
		 * Removes an action to the composite action.
		 * @param	action
		 */
		public function removeAction(action:Action):void {
			var index:int;
			while ((index = _actionCollection.actions.indexOf(action)) >= 0) {
				var act:Action = _actionCollection.actions.splice(index, 1)[0];
				act.onPriorityChange.remove(sortActions);
			}
		}

		public function get actionCollection():ActionCollection {
			return _actionCollection;
		}

		/**
		 * Removes all actions from the composite action.
		 */
		public function clearActions():void {
			for each (var action:Action in _actionCollection.actions) removeAction(action);
		}
		
		public final function sortActions(action:Action = null):void {
			_actionCollection.actions.sortOn("priority", Array.NUMERIC | Array.DESCENDING);
		}
		
		override public final function get needsSortedParticles():Boolean {
			for each (var action:Action in _actionCollection.actions) {
				if (action.needsSortedParticles) return true;
			}
			return false;
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObjects():Array {
			return _actionCollection.actions.concat();
		}
		
		override public function getXMLTagName():String {
			return "CompositeAction";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			if (xml.@checkComponentMasks.length()) xml.@checkComponentMasks = checkComponentMasks;
			
			if (_actionCollection.actions.length > 0) {
				xml.appendChild(<actions/>);
				var action:Action;
				for each (action in _actionCollection.actions) {
					xml.actions.appendChild(action.getXMLTag());
				}
			}
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			checkComponentMasks = (xml.@checkComponentMasks == "true");
			
			clearActions();
			for each (var node:XML in xml.actions.*) {
				addAction(Action(builder.getElementByName(node.@name)));
			}
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}