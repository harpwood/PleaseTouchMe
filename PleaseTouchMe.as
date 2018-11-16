package
{
	/**
	 *
	 * @author George "Harpwood" Kritikos
	 *
	 *****************************************************************************************************************************
	 *	Simple touch raw data manipulation for Adobe AIR AS3. Recognises swipe gesture angle and simple taps.
	 *	Splits the screen as a big X mark that begins at the primary touchpoint. Considers that four 90° angles form an "X mark" 
	 *  as default behanior. You can change any angle by tweeking the apropriate constants (all values in angle degrees):
	 * ..UP_LEFT_ANGLE....:.-135
	 * ..UP_RIGHT_ANGLE...:..-45
	 * ..DOWN_LEFT_ANGLE..:..135
	 * ..DOWN_RIGHT_ANGLE.:...45
	 *.................................................................
	 *.............................UP_LEFT_ANGLE.......UP_RIGHT_ANGLE..
	 *........\ 90° /......................-135°\ up /-45°.............
	 *..... 90°  .  90°......................left . right..............
	 *......../ 90° \.......................135°/down\45°..............
	 *.............................DOWN_LEFT_ANGLE...DOWN_RIGHT_ANGLE..
	 *.................................................................
	 *	By default, if the angle of the swipe is:
	 *	 		  45°  to  135° then we have swipe down
	 *			-135°  to  -45° then we have swipe up
	 *			 -45°  to   45° then we have swipe right
	 *			 135°  to -135° then we have swipe left
	 *
	 * Simple Tap interaction instead of swipe is recognised, the swipe of any angle have a minimum distance (start to end gesure) 
	 * You change the minimum swipe distance by tweeking the apropriate constant (value in stage pixels): MIN_SWIPE_DISTANCE
	 *
	 ******************************************************************************************************************************
	 */
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	public class PleaseTouchMe extends MovieClip
	{		
		// The minimum distance of the gesture on the screen, in order to be considered as Swipe
		// If the distance of the swipe is smaller, then the interaction will be considered as single Tap
		private const MIN_SWIPE_DISTANCE:int = 20;
		
		// The constants that form the angles of the "X mark"
		private const UP_LEFT_ANGLE:int = -135;
		private const UP_RIGHT_ANGLE:int = -45;
		private const DOWN_LEFT_ANGLE:int = 135;
		private const DOWN_RIGHT_ANGLE:int = 45;
		
		//We need an object to store to possition (x,y) of gesture's starting point
		private var touchBeginObject:Object;
		
		public function PleaseTouchMe()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
		}
		
		private function onAddedToStage(event:Event):void
		{			
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage, false, 0, true);
			
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			touchBeginObject = new Object();
			stage.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin, false, 0, true);
			stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove, false, 0, true);
			stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd, false, 0, true);
		}
		
		private function onRemovedFromStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false);
			stage.removeEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin, false);
			stage.removeEventListener(TouchEvent.TOUCH_END, onTouchEnd, false);
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage, false);
		}
		
		protected function onTouchBegin(event:TouchEvent):void
		{
			//the beginning of the gesture
			if (event.isPrimaryTouchPoint)
			{
				touchBeginObject.x = event.stageX;
				touchBeginObject.y = event.stageY;
			}
		}
		
		protected function onTouchMove(event:TouchEvent):void
		{
			//place your code here
		}
		
		protected function onTouchEnd(event:TouchEvent):void
		{
			var angle:Number;
			var getVectorX:Number;
			var getVectorY:Number;
			
			//the distance between the start and the end of the gesture
			getVectorX = event.stageX - touchBeginObject.x;
			getVectorY = event.stageY - touchBeginObject.y;
			
			//the angle of the gesture
			angle = Math.atan2(getVectorY, getVectorX) * (180 / Math.PI);
			
			/*	 		  45°  to  135° then we have swipe down
			 *			-135°  to  -45° then we have swipe up
			 *			 -45°  to   45° then we have swipe right
						135°  to -135° then we have swipe left
			 */
			
			if (event.isPrimaryTouchPoint)
			{
				/*Swipe down or tap?*/
				if ((angle > DOWN_RIGHT_ANGLE) && (angle < DOWN_LEFT_ANGLE)) //if the angle is  45°  to  135°...
				{
					//...and the gesture distance at y axis is greater than MIN_SWIPE_DISTANCE...
					if (Math.abs(getVectorY) > MIN_SWIPE_DISTANCE)
					{
						//...then we have swipe down											
						trace("Gesture: swipe down");
						trace("Swipe gesture angle: " + Math.floor(angle) + "°");
					}
					else //..else is a tap
					{
						if (event.target.name) trace("Tapped :" + event.target.name);
						else trace("Tap");
					}
				}
				/*Swipe up or tap?*/
				else if ((angle < UP_RIGHT_ANGLE) && (angle > UP_LEFT_ANGLE)) //if the angle is -135°  to  -45°...
				{
					//...and the gesture distance at y axis is greater than MIN_SWIPE_DISTANCE...
					if (Math.abs(getVectorY) > MIN_SWIPE_DISTANCE)
					{
						//...then we have swipe up
						trace("Gesture: swipe up");
						trace("Swipe gesture angle: " + Math.floor(angle) + "°");
					}
					else //..else is a tap
					{
						if (event.target.name) trace("Tapped :" + event.target.name);
						else trace("Tap");
					}
				}
				/*Swipe right or tap?*/
				else if ((angle > UP_RIGHT_ANGLE) && (angle < DOWN_RIGHT_ANGLE)) //if the angle is -45°  to   45°...
				{
					//...and the gesture distance at x axis is greater than MIN_SWIPE_DISTANCE...
					if (Math.abs(getVectorX) > MIN_SWIPE_DISTANCE)
					{
						//...then we have swipe right
						trace("Gesture: swipe right");
						trace("Swipe gesture angle: " + Math.floor(angle) + "°");
					}
					else //..else is a tap
					{
						if (event.target.name) trace("Tapped :" + event.target.name);
						else trace("Tap");
					}
				}
				/*Swipe left or tap?*/
				else if ((angle > DOWN_LEFT_ANGLE) || (angle < UP_LEFT_ANGLE)) //if the angle is 135°  to -135°...
				{
					//...and the gesture distance at x axis is greater than MIN_SWIPE_DISTANCE...
					if (Math.abs(getVectorX) > MIN_SWIPE_DISTANCE)
					{
						//...then we have swipe left
						trace("Gesture: swipe left");
						trace("Swipe gesture angle: " + Math.floor(angle) + "°");
					}
					else //..else is a tap
					{
						if (event.target.name) trace("Tapped :" + event.target.name);
						else trace("Tap");
					}
				}
			}
		}
	}
}
