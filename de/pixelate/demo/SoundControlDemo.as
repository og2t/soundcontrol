/**
 * SoundControl
 * A better workflow for developers and sound designers in AS3 projects
 * Copyright (c) 2009 Andreas Zecher, http://www.pixelate.de
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package de.pixelate.demo
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.display.Sprite;
	import flash.utils.Timer;
	import de.pixelate.soundcontrol.SoundControl;
	import de.pixelate.soundcontrol.SoundEvent;

	public class SoundControlDemo extends Sprite
	{
		private var _exampleSprite: Sprite;
		private var _demoGUI: SoundControlDemoGUI;
		private var _soundControl: SoundControl;
		
		public function SoundControlDemo()
		{
			_soundControl = new SoundControl();
			_soundControl.addEventListener(Event.INIT, onSoundControlInit);

			// When embedded in HTML, set basePath to the folder of your main SWF
			// _soundControl.basePath = "swfs/";

			// Load external XML config file
			_soundControl.loadXMLConfig("xml/soundConfig.xml");

			// Or use embedded config XML
			// _soundControl.xmlConfig = xml;
			
			// Use SoundEvents to trigger a sound from another object on the display list			
			_exampleSprite = new Sprite();
			_exampleSprite.addEventListener(SoundEvent.PLAY_SOUND, onSoundEvent);
			_exampleSprite.addEventListener(SoundEvent.FADEIN_SOUND, onSoundEvent);
			_exampleSprite.addEventListener(SoundEvent.FADEOUT_SOUND, onSoundEvent);
			addChild(_exampleSprite);			

			_demoGUI = new SoundControlDemoGUI();
			addChild(_demoGUI);
		}
		
		private function onSoundControlInit(event: Event):void
		{
			var timer: Timer = new Timer(10000, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			timer.start();

			// Call functions on the SoundControl instance directly
			_soundControl.playSound("HelloWorld");
			_soundControl.fadeInSound("Loop");
			
			// Or dispatch events from objects on the display list 
			// _exampleSprite.dispatchEvent( new SoundEvent(SoundEvent.PLAY_SOUND, "HelloWorld") );			
			// _exampleSprite.dispatchEvent( new SoundEvent(SoundEvent.FADEIN_SOUND, "Loop") );			
		}
		
		private function onTimerComplete(event: TimerEvent):void
		{
			_soundControl.fadeOutSound("Loop");
			// _exampleSprite.dispatchEvent( new SoundEvent(SoundEvent.FADEOUT_SOUND, "Loop") );			
		}

		private function onSoundEvent(event: SoundEvent):void
		{
			switch (event.type)
			{
				case SoundEvent.PLAY_SOUND:
					_soundControl.playSound(event.soundId);
					break;
				case SoundEvent.STOP_SOUND:
					_soundControl.stopSound(event.soundId);
					break;
				case SoundEvent.FADEIN_SOUND:
					_soundControl.fadeInSound(event.soundId);
					break;
				case SoundEvent.FADEOUT_SOUND:
					_soundControl.fadeOutSound(event.soundId);
					break;
			}
		}
	}
}

