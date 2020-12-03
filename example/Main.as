package
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.TouchEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	public class Main extends Sprite
	{
		private var traceField:TextField;
		private var traceFormat:TextFormat;
		
		//private var drawArea:Shape;
		private var trackBeginObject:Object;
		
		public function Main()
		{
			setupTextField();
			//setupDrawArea();
			setupTouchEvents();
		}
		
		protected function setupTextField():void
		{
			traceFormat = new TextFormat();
			traceFormat.bold = true;
			traceFormat.font = "_sans";
			traceFormat.size = 32;
			traceFormat.align = "center";
			traceFormat.color = 0x333333;
			traceField = new TextField();
			traceField.defaultTextFormat = traceFormat;
			traceField.selectable = false;
			traceField.mouseEnabled = false;
			traceField.width = stage.stageWidth;
			traceField.height = stage.stageHeight;
			addChild(traceField);
		}
		
		/*protected function setupDrawArea():void
		{
			drawArea = new Shape();
			addChild(drawArea);
		}*/
		
		protected function setupTouchEvents():void
		{
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			trackBeginObject = new Object();
			stage.addEventListener(TouchEvent.TOUCH_BEGIN, touchBegin);
			stage.addEventListener(TouchEvent.TOUCH_MOVE, touchMove);
			stage.addEventListener(TouchEvent.TOUCH_END, touchEnd);
		}
		
		protected function touchBegin(event:TouchEvent):void
		{
			if (event.isPrimaryTouchPoint)
			{
				//drawArea.graphics.clear();
				//drawArea.graphics.lineStyle(20, 0xFFFFFF, 0.8);
				trackBeginObject.x = event.stageX;
				trackBeginObject.y = event.stageY;
				//drawArea.graphics.moveTo(event.stageX, event.stageY);
				//traceField.text = "Touch Begins!";
			}
		}
		
		protected function touchMove(event:TouchEvent):void
		{
			/*if (event.isPrimaryTouchPoint)
			{
				//drawArea.graphics.lineTo(event.stageX, event.stageY);
				traceField.text = "Touch event!";
			}*/
		}
		
		protected function touchEnd(event:TouchEvent):void
		{
			var angle:Number;
			var getVectorX:Number;
			var getVectorY:Number;
			
			getVectorX = trackBeginObject.x - event.stageX;
			getVectorY = trackBeginObject.y - event.stageY;
			angle = Math.atan2( -getVectorY, -getVectorX) * (180 / Math.PI);
			
			if (event.isPrimaryTouchPoint)
			{
				
				if ((angle > 45) && (angle < 135))
				{
					traceField.text = "swipe down";
				}
				else if ((angle < -45) && (angle > -135))
				{
					traceField.text = "swipe up";
				}
				else if ((angle > -45) && (angle < 45))
				{
					traceField.text ="swipe right";
				}
				else if ((angle > 135) || (angle < -135))
				{
					traceField.text ="swipe left";
				}
				trace(angle);
				
			}
		
		}
	}

}