package {

/* Kudos:
   Adamatomic/flixel
   http://www.triquitips.com/viewtopic.php?f=26&t=582
   http://www.emanueleferonato.com
 */
	import flash.display.*;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.KeyboardEvent;
        import flash.geom.Matrix;
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;


	public class Fluxly extends MovieClip {

	        private var background:Sprite;
	  private var background_anim:BackgroundAnimation;
		public var the_world:b2World;
	        private var gravityX:Number=0.0;
	        private var gravityY:Number=20.0;
	       private var score1:FluxlyMessage;
	       private var score2:FluxlyMessage;
	  private var message:FluxlyMessage;
	  private var winner:Sprite;
	        private var gravity:b2Vec2=new b2Vec2(gravityX, gravityY);   // was 10
	        private var origGravityX:Number = gravityX;
	        private var origGravityY:Number = gravityY;
		private var time_count:Timer=new Timer(8000);
	        private var gravity_count:Timer=new Timer(2000);
	        private var victory_splash:Timer=new Timer(5000);
	        private var allBlocks:Array = new Array();
	        private var allPlayers:Array = new Array();
	        private var allClouds:Array = new Array();
	        private var blocker:b2Body;
	        private var started:Boolean = false;
	        private var end_bout:Boolean = false;
	        private var p1:Player;
	        private var p2:Player;
	        private var size:Number;
	        private var xLoc:Number;
	        private var yLoc:Number;
	        private var hole1X:Number;
	        private var hole1W:Number;
	        private var hole2X:Number;
	        private var hole2W:Number;
 	         private var kq:Boolean = false;
	         private var kw:Boolean = false;
	         private var ke:Boolean = false;
	         private var kr:Boolean = false;
	         private var kt:Boolean = false;
	         private var ky:Boolean = false;
	         private var ku:Boolean = false;
	         private var ki:Boolean = false;
	         private var ko:Boolean = false;
	         private var kp:Boolean = false;
	         private var ka:Boolean = false;
	         private var ks:Boolean = false;
	         private var kd:Boolean = false;
	         private var kf:Boolean = false;
	         private var kg:Boolean = false;
	         private var kh:Boolean = false;
	         private var kj:Boolean = false;
	         private var kk:Boolean = false;
	         private var kl:Boolean = false;
	         private var kz:Boolean = false;
	         private var kx:Boolean = false;
	         private var kc:Boolean = false;
	         private var kv:Boolean = false;
	         private var kb:Boolean = false;
	         private var kn:Boolean = false;
	         private var km:Boolean = false;
    	         private var Space:Boolean = false;
	         private var Left:Boolean = false;
	         private var Right:Boolean = false;
	         private var Up:Boolean = false;
	  private var Sounds:FluxlySounds;


	  // private var checkBoundaries:b2BoundaryListener = new b2BoundaryListener();

		public function Fluxly() {

		        FluxlyG.init();
			draw_background();
			background_anim= new BackgroundAnimation(100,100,1);
			stage.addChild(background_anim);
			
			var environment:b2AABB = new b2AABB();
			environment.lowerBound.Set(-100.0, -100.0);
			environment.upperBound.Set(100.0, 100.0);
			
			the_world=new b2World(environment,gravity,true);
			Sounds = new FluxlySounds();

			score1 = new FluxlyMessage();
			score2 = new FluxlyMessage();
			message = new FluxlyMessage();
			message.x = 200;
			message.y = 10;
			stage.addChild(message);
			score1.n = 0;
			score2.n = 0;
			score1.x = 0;
			score1.y= 5;
			score2.x = 400;
			score2.y= 5;
			score1.setScore();
			score2.setScore();
			stage.addChild(score1);
			stage.addChild(score2);

			/*		var debug_draw:b2DebugDraw = new b2DebugDraw();
			var debug_sprite:Sprite = new Sprite();
			addChild(debug_sprite);
			debug_draw.m_sprite=debug_sprite;
			debug_draw.m_drawScale=30;
			debug_draw.m_fillAlpha=0.25;
			debug_draw.m_lineThickness=1;
			debug_draw.m_drawFlags=b2DebugDraw.e_shapeBit;
			the_world.SetDebugDraw(debug_draw);*/

			//Top
			add_bounding_block(0,-1,21,.5, 0);
			//Bottom
			//	hole1W = Math.random()*4.0+1.0;
			//	hole2W = Math.random()*4.0+1.0;
			//	hole1X =  Math.random()*(10-hole1W);
			//	hole2X =  Math.random()*(20-hole2W);
			add_bounding_block(0,12,6.5,.1, 0.3);
			add_bounding_block(16.5,12,6.5,.1, 0.3);

			//	add_bounding_block(0,12,hole1X,.1, 0.3);
  	                //add_bounding_block(hole1X+hole1W,12,10,.1, 0.3);
  	                //add_bounding_block(10,12,hole2X,.1, 0.3);
			//add_bounding_block(hole2X+hole2W,12,20-hole2W,.1, 0.3);
			//Sides
			add_bounding_block(-3.5,0,1,13, 0);
			add_bounding_block(20,0,1,13, 0);
			
			setup_blocks();

			addEventListener(Event.ENTER_FRAME, on_enter_frame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, on_keydown);
			stage.addEventListener(KeyboardEvent.KEY_UP, on_keyup);
			time_count.addEventListener(TimerEvent.TIMER, on_timer);
			victory_splash.addEventListener(TimerEvent.TIMER, on_victory);
		
			//	the_world.SetBoundaryListener(checkBoundaries);

			time_count.start();
		}

	  private function on_timer(e:Event):void {

	    	if (!started) {
		  start_game();
		} else {
		  size = Math.random()*2.0/20.0+.25;
                  add_block(Math.random()*17, 0, size,size, 0.3, 1);
		}
	      for each (var c:Cloud in allClouds) {
		 xLoc = Math.random()*-50.0+20.0;
		 yLoc =  Math.random()*-50.0+20.0;
		 c.body.ApplyImpulse(new b2Vec2(xLoc,yLoc), c.body.GetWorldCenter());
	      }
	  }
	  
	  private function on_victory(e:Event):void {
	        Sounds.stopMusic();
	        stage.removeChildAt(stage.getChildIndex(winner));
		winner = null;
	       	// Destroy blocks
		while (allBlocks.length>0) {
		  var b:Block = allBlocks.pop();
		  stage.removeChildAt(stage.getChildIndex(b.graphic));
		  b.body.m_userData = null;
		  the_world.DestroyBody(b.body);
		  b.body = null;
		  b.graphic=null;
		  b=null;
		}

		while (allPlayers.length>0) {
		  var p:Player = allPlayers.pop();
		  stage.removeChildAt(stage.getChildIndex(p.graphic));
		  p.body.m_userData = null;
		  the_world.DestroyBody(p.body);
		  p.body = null;
		  p.graphic=null;
		  p=null;
		}

		while (allClouds.length>0) {
		  var c:Cloud = allClouds.pop();
		  stage.removeChildAt(stage.getChildIndex(c.graphic));
		  c.body.m_userData = null;
		  the_world.DestroyBody(c.body);
		  c.body = null;
		  c.graphic=null;
		  c=null;
		}

		p1=null;
		p2=null;
		// Restart bout
	        message.setLabel("");
		setup_blocks();
		time_count.start();
		victory_splash.stop();
	  }

	  private function setup_blocks():void {
			// block up pit
			var the_body:b2BodyDef;
			var the_box:b2PolygonDef;
			the_body = new b2BodyDef();
			the_body.position.Set(8.25,4);
			the_box = new b2PolygonDef();
			the_box.SetAsBox(2,9);
			the_box.friction=0.3;
			the_box.density=0;
			blocker=the_world.CreateBody(the_body);
			blocker.CreateShape(the_box);
			blocker.SetMassFromShapes();

			// Add piles of blocks
			for (var i:int=0; i<20; i++) {
			    size = Math.random()*2.0/15.0+.35;
			    add_block(0, Math.random()*3+4, size,size, 0.3,1);
			    add_block(1, Math.random()*3+4, size,size, 0.3, 1);
			    add_block(2, Math.random()*3+4,  size,size, 0.3, 1);
			    add_block(16, Math.random()*3+4,  size,size, 0.3, 1);
			    add_block(17, Math.random()*3+4,  size,size, 0.3, 1);
			    add_block(15, Math.random()*3+4, size,size, 0.3, 1);
			}
	  }

	  private function start_game():void {
           
            started = true;
	    end_bout = false;
	    Sounds.setMusic();

            if (blocker != null) {
	      the_world.DestroyBody(blocker);
	    }
  
	    p1=new Player(1, 1,-1, 0.5, 1.0, 0.3, .25);
	    p1.body=the_world.CreateBody(p1.body_def);
	    p1.body.CreateShape(p1.top);
            p1.body.CreateShape(p1.bottom);
 	    p1.body.SetMassFromShapes();
	    p1.body.SetBullet(true);
	    p1.body.m_userData = p1;	    
	    allPlayers.push(p1);
	    stage.addChild(p1.graphic);
           
	    p2=new Player(2, 15,-1, 0.5, 1.0, 0.3, .25);
	    p2.body=the_world.CreateBody(p2.body_def);
	    // p.body.CreateShape(p.top);
            p2.body.CreateShape(p2.bottom);
 	    p2.body.SetMassFromShapes();
	    p2.body.SetBullet(true);
	    p2.body.m_userData = p2;	    
	    allPlayers.push(p2);
	    stage.addChild(p2.graphic);

          }

	  private function end_of_bout():void {
	        score1.setScore();
	    	score2.setScore();
		
		stage.addChild(winner);

		message.setLabel("Winner!");
		victory_splash.start();
		started=false;
		end_bout=false;
                time_count.stop();
	
	  }


	  private function on_enter_frame(e:Event):void {
	      var bodyPosition:b2Vec2;
              var bodyRotation:Number;
	      the_world.m_gravity = new b2Vec2(gravityX,gravityY);
	      background_anim.hide();
              if (started) {
 
	        if (ka){
                   p1.body.WakeUp();
		   p1.body.m_linearVelocity.x = -4;
                }
	        if (ks){
                   p1.body.WakeUp();
		   p1.body.m_sweep.a =0;
                }
	        if (kk){
                   p2.body.WakeUp();
		   p2.body.m_sweep.a =0;
                }	
		if (ku) {
		  p1.body.WakeUp();
		  p2.body.WakeUp();
		  if (kq) {
		    gravityY=gravityY+1;
	  	  }
		  gravityY=gravityY-1;
		} else {
		  if (kq) {
		    gravityY=gravityY+1;
	  	  } else {
		    gravityY = origGravityY;
		  }
		}
		if (ky) {
		  for each (var b:Block in allBlocks) {
		      xLoc = Math.random()*4.0-2.0;
		      yLoc =  Math.random()*4.0-2.0;
		      b.body.ApplyImpulse(new b2Vec2(xLoc,yLoc), b.body.GetWorldCenter());
	          }
		}

                if (kd){
                   p1.body.WakeUp();
                   p1.body.m_linearVelocity.x = 4;
                }
                if (kw){
                  if ( p1.body.GetLinearVelocity().y > -1 &&  p1.body.m_contactList != null && p1.graphic.y>30 ){
                     p1.body.ApplyImpulse(new b2Vec2(0.0, -7.0),  p1.body.GetWorldCenter());
	         }
                }
		
	        if (kj){
                    p2.body.WakeUp();
		   p2.body.m_linearVelocity.x = -4;
                }
                if (kl){
                  p2.body.WakeUp();
                  p2.body.m_linearVelocity.x = 4;
                }
                if (ki){
                  if (p2.body.GetLinearVelocity().y > -1 && p2.body.m_contactList != null 
		      && p2.graphic.y>30 ){
                    p2.body.ApplyImpulse(new b2Vec2(0.0, -7.0), p2.body.GetWorldCenter());
	          }
		 }

		if (ke) {
		  size = Math.random()*2.0/20.0+.25;
		  //add_block(Math.random()*17, 0, size, size, 0.3, Math.random()*5);
		  if (Math.random()>0.5) {
		    xLoc=0;
		  } else {
		    xLoc=17;
		  }
		  add_block(xLoc, 0, size, size, 0.3, Math.random()*5);
		 }

		if (kp) {
		  size = Math.random()*3.0+0.25;
		  add_block(Math.random()*17, 0, size, .1, 0.3,1);
		 }
		if (kf) {
		  add_cloud(Math.random()*20-1, Math.random()*3.0+0.25, .8, .5, 0.3,1);
		 }
		if (kr) {
		  background_anim.show();
		  p1.body.WakeUp();
		  p2.body.WakeUp();
		  if (kt) {
		    gravityX=gravityX+1;
	  	  }
		  gravityX=gravityX-1;
		} else {
		  if (kt) {
		    gravityX=gravityX+1;
	  	  } else {
		    gravityX = origGravityX;
		  }
		}
	       }
		if (kz) {
		  Sounds.setMute(!Sounds.getMute());
		 }

	      the_world.Step(1/20, 10);

	    if (!end_bout) {

	      for each (var b:Block in allBlocks) {
		  draw_graphic(b.body, b.graphic);
	      }
	      for each (var c:Cloud in allClouds) {
		  draw_graphic(c.body,c.graphic);
	          c.body.m_sweep.a =0;
	      }
	      for each (var player:Player in allPlayers) {
		draw_graphic(player.body, player.graphic);
		if (player.graphic.y>400) {
		  player.onscreen = false;
		}
	      }
	    }

	      if (started) {
	        if (!p1.onscreen) {
		  score2.n = score2.n+1;
		  end_bout = true;
		  started=false;
		  winner = p2.getImageScaled(new Matrix(5,0,0,5,0,0));
	        }
	        if (!p2.onscreen) {
		  score1.n = score1.n+1;
		  end_bout = true;
		  started=false;
		  winner = p1.getImageScaled(new Matrix(5,0,0,5,0,0));
	        }
	        if (end_bout) {
	  	  end_of_bout();
	        }
	      }
	      
          } 

	  public function add_block(x:Number,y:Number,w:Number,h:Number,f:Number,d:Number):void {
		  var b:Block;
		  b=new Block(x, y, w, h, f, d);
		  b.body=the_world.CreateBody(b.body_def);
      	          b.body.CreateShape(b.the_box);
 	          b.body.SetMassFromShapes();
		  b.body.m_userData = b;
		  allBlocks.push(b);
		  stage.addChild(b.graphic);
		  b=null;
          }
	  public function add_cloud(x:Number,y:Number,w:Number,h:Number,f:Number,d:Number):void {
		  var c:Cloud;
		  c=new Cloud(x, y, w, h, f, d);
		  c.body=the_world.CreateBody(c.body_def);
      	          c.body.CreateShape(c.the_box);
 	          c.body.SetMassFromShapes();
		  c.body.m_userData = c;
		  allClouds.push(c);
		  stage.addChild(c.graphic);
		  c=null;
          }
	  public function add_bounding_block(x:Number, y:Number, w:Number, h:Number,f:Number):void {
		        var final_body:b2Body;
			var the_body:b2BodyDef;
			var the_box:b2PolygonDef;
			the_body = new b2BodyDef();
			the_body.position.Set(x,y);
			the_box = new b2PolygonDef();
			the_box.SetAsBox(w,h);
			the_box.friction=f;
			the_box.density=0;
			final_body=the_world.CreateBody(the_body);
			final_body.CreateShape(the_box);
			final_body.SetMassFromShapes();
	   }
	  
	  private function draw_graphic(b:b2Body, g:Sprite):void {
                var bodyPosition:b2Vec2=b.GetPosition();
                var bodyRotation:Number=b.GetAngle();
                g.rotation=0; 
                var m:Matrix=g.transform.matrix;
                m.tx=- g.width/2;
                m.ty=- g.height/2;
                m.rotate(bodyRotation);
                m.tx+=bodyPosition.x*30;
                m.ty+=bodyPosition.y*30;
                g.transform.matrix=m;
	      }

          private function draw_background():void {
	                background = new Sprite();
                        var fillType:String = GradientType.LINEAR;
                        var colors:Array = [ 0xffffff,0x999999];
                        var alphas:Array = [1, 1];
                        var ratios:Array = [0x00, 0xF0];
                        var matr:Matrix = new Matrix();
                        matr.createGradientBox(1000, 600, 90, 0, 0);
                        var spreadMethod:String = SpreadMethod.PAD;
                        //background.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);  
                        background.graphics.beginFill(0x666666);
			background.graphics.drawRect(0,0,1000,600);
                        background.graphics.beginFill(0x333333);
			background.graphics.drawRect(0,357,295,30);
			background.graphics.drawRect(400,357,360,30);
			background.x = -100;
			addChild(background);
	  }

               

   public function on_keydown(e:KeyboardEvent):void{

         switch (e.keyCode){
            case 32://space
              Space = true;
              break;
            case 65://a
              ka = true;
              break;
            case 66://b
              kb = true;
              break;
            case 67://c
              kc = true;
              break;
	    case 68://d
              kd = true;
            break;
	   case 69://e
              ke = true;
            break;
            case 70://f
              kf = true;
              break;
            case 71://g
              kg = true;
              break;
            case 72://h
              kh = true;
              break;
            case 73://i
              ki = true;
              break;
            case 74://j
              kj = true;
              break;
            case 75://k
              kk = true;
              break;
            case 76://l
              kl = true;
              break;
            case 77://m
              km = true;
              break;
            case 78://n
              kn = true;
              break;
            case 79://o
              ko = true;
              break;
            case 80://p
              kp = true;
              break;
            case 81://q
              kq = true;
              break;
            case 82://r
              kr = true;
              break;
            case 83://s
              ks = true;
              break;
            case 84://t
              kt = true;
              break;
            case 85://u
              ku = true;
              break;
            case 86://v
              kv = true;
              break;
            case 87://w
              kw = true;
              break;
            case 88://x
              kx = true;
              break;
            case 89://y
              ky = true;
              break;
            case 90://z
              kz = true;
              break;
         }
         
      }
	 public function on_keyup(e:KeyboardEvent):void{
 
         switch (e.keyCode){
            case 32://a
              Space = false;
              break;
            case 65://a
              ka = false;
              break;
            case 66://b
              kb = false;
              break;
            case 67://c
              kc = false;
              break;
	    case 68://d
              kd = false;
            break;
	   case 69://e
              ke = false;
            break;
            case 70://f
              kf = false;
              break;
            case 71://g
              kg = false;
              break;
            case 72://h
              kh = false;
              break;
            case 73://i
              ki = false;
              break;
            case 74://j
              kj = false;
              break;
            case 75://k
              kk = false;
              break;
            case 76://l
              kl = false;
              break;
            case 77://m
              km = false;
              break;
            case 78://n
              kn = false;
              break;
            case 79://o
              ko = false;
              break;
            case 80://p
              kp = false;
              break;
            case 81://q
              kq = false;
              break;
            case 82://r
              kr = false;
              break;
            case 83://s
              ks = false;
              break;
            case 84://t
              kt = false;
              break;
            case 85://u
              ku = false;
              break;
            case 86://v
              kv = false;
              break;
            case 87://w
              kw = false;
              break;
            case 88://x
              kx = false;
              break;
            case 89://y
              ky = false;
              break;
            case 90://z
              kz = false;
              break;
         }
      }

		


	 
	}
}