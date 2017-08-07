package {
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

    public class FluxlySounds {
       
        [Embed(source="./data/background.mp3")] private var BkgSnd:Class;
        [Embed(source="./data/fluxlysong2.mp3")] private var BkgSnd2:Class;
      private var current_song:uint = 1;
      private var max_songs:uint = 2;
		static private var _muted:uint=1;
		static private var _music:Sound;
		static private var _musicChannel:SoundChannel;
		static private var _musicPosition:Number;
 		static private var _volume:Number=1;
		static private var _musicVolume:Number=1;
		static private var _masterVolume:Number=1;

        public function FluxlySounds() {
            
        }

 		//@desc		Set up and autoplay a music track
		//@param	Music		The sound file you want to loop in the background
		//@param	Volume		How loud the sound should be, from 0 to 1
		//@param	Autoplay	Whether to automatically start the music or not (defaults to true)
       public function setMusic(Volume:Number=1,Autoplay:Boolean=true):void
		{
			stopMusic();
			switch (current_song % max_songs) {
			  case 0: _music = new BkgSnd; break;
		 	  case 1: _music = new BkgSnd2; break;
			}
			current_song = current_song+1;
			_musicVolume = Volume;
			if(Autoplay)
				playMusic();
		}
		
		//@desc		Plays a sound effect once
		//@param	SoundEffect		The sound you want to play
		//@param	Volume			How loud to play it (0 to 1)
		 public function play(SoundEffect:Class,Volume:Number=.25):void
		{
			(new SoundEffect).play(0,0,new SoundTransform(Volume*_muted*_volume*_masterVolume));
		}
		
		//@desc		Plays or resumes the music file set up using setMusic()
		 public function playMusic():void
		{
			if(_musicPosition < 0)
				return;
			if(_musicPosition == 0)
			{
				if(_musicChannel == null) _musicChannel = _music.play(0,9999,new SoundTransform(_muted*_volume*_musicVolume*_masterVolume));
			}
			else
			{
				_musicChannel = _music.play(_musicPosition,0,new SoundTransform(_muted*_volume*_musicVolume*_masterVolume));
				_musicChannel.addEventListener(Event.SOUND_COMPLETE, loopMusic);
			}
			_musicPosition = 0;
		}
		
		//@desc		An internal helper function used to help Flash resume playing a looped music track
		 private function loopMusic(event:Event=null):void
		{
		    if (_musicChannel == null)
		    	return;
	        _musicChannel.removeEventListener(Event.SOUND_COMPLETE,loopMusic);
			playMusic();
		}
		
		//@desc		Pauses the current music track
		 public function pauseMusic():void
		{
			if(_musicChannel == null)
			{
				_musicPosition = -1;
				return;
			}
			_musicPosition = _musicChannel.position;
			_musicChannel.stop();
			while(_musicPosition >= _music.length)
				_musicPosition -= _music.length;
			_musicChannel = null;
		}
		
		//@desc		Stops the current music track
		 public function stopMusic():void
		{
			_musicPosition = 0;
			if(_musicChannel != null)
			{
				_musicChannel.stop();
				_musicChannel = null;
			}
		}
		
		//@desc		Mutes the sound
		//@param	SoundOff	Whether the sound should be off or on
		 public function setMute(SoundOff:Boolean):void { if(SoundOff) _muted = 0; else _muted = 1; 
                   adjustMusicVolume(); }
		
		//@desc		Check to see if the game is muted
		//@return	Whether the game is muted
		 public function getMute():Boolean { if(_muted == 0) return true; return false; }
		
		//@desc		Change the volume of the game
		//@param	Volume		A number from 0 to 1
		 public function setVolume(Volume:Number):void { _volume = Volume; adjustMusicVolume(); }
		
		//@desc		Find out how load the game is currently
		//@param	A number from 0 to 1
		 public function getVolume():Number { return _volume; }
		
		//@desc		Change the volume of just the music
		//@param	Volume		A number from 0 to 1
		 public function setMusicVolume(Volume:Number):void { _musicVolume = Volume; adjustMusicVolume(); }
		
		//@desc		Find out how loud the music is
		//@return	A number from 0 to 1
		 public function getMusicVolume():Number { return _musicVolume; }
		
		//@desc		An internal function that adjust the volume levels and the music channel after a change
		 private function adjustMusicVolume():void
		{
			if(_muted < 0)
				_muted = 0;
			else if(_muted > 1)
				_muted = 1;
			if(_volume < 0)
				_volume = 0;
			else if(_volume > 1)
				_volume = 1;
			if(_musicVolume < 0)
				_musicVolume = 0;
			else if(_musicVolume > 1)
				_musicVolume = 1;
			if(_masterVolume < 0)
				_masterVolume = 0;
			else if(_masterVolume > 1)
				_masterVolume = 1;
			if(_musicChannel != null)
				_musicChannel.soundTransform = new SoundTransform(_muted*_volume*_musicVolume*_masterVolume);
		}
    }
}