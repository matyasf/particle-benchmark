package idv.cjcat.stardustextended.twoD.actions.triggers {
	import idv.cjcat.stardustextended.common.actions.triggers.ActionTrigger;
	import idv.cjcat.stardustextended.twoD.actions.Action2DPriority;
	
	/**
	 * Base class for 2D action triggers.
	 */
	public class ActionTrigger2D extends ActionTrigger {
		
		public function ActionTrigger2D() {
			_supports3D = false;
			
			priority = Action2DPriority.getInstance().getPriority(Object(this).constructor as Class);
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "ActionTrigger2D";
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}