# PleaseTouchMe
Simple touch raw data manipulation for Adobe AIR AS3. Recognises swipe gesture angle and simple taps.

Splits the screen as a big X mark that begins at the primary touchpoint.
Considers that four 90° angles form an "X mark" as default behanior.
You can change any angle by tweeking the apropriate constants (all values in angle degrees): 
	
		private const UP_LEFT_ANGLE:int = -135;
		private const UP_RIGHT_ANGLE:int = -45;
		private const DOWN_LEFT_ANGLE:int = 135;
		private const DOWN_RIGHT_ANGLE:int = 45;

By default, if the angle of the swipe is:

		  45°  to  135° then the gesture is recognised as swipe down 
		-135°  to  -45° then the gesture is recognised as swipe up
		 -45°  to   45° then the gesture is recognised as swipe right
		 135°  to -135° then the gesture is recognised as swipe left
	 
 Simple Tap interaction instead of swipe is recognised, the swipe of any angle have a minimum (distance start to end gesure)
 You change the minimum swipe distance by tweeking the apropriate constant (value in stage pixels):

	private const MIN_SWIPE_DISTANCE = 20;

