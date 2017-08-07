package {
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
        import flash.display.Sprite;
        import flash.display.BitmapData;
        import flash.geom.Matrix;

  public class BackgroundAnimation extends Sprite {
    [Embed(source="data/anim1.png")] private var Anim1Graphic:Class;
    [Embed(source="data/fluxa1.png")] private var Player2Graphic:Class;
    public var xLoc:int;
    public var yLoc:int;
    public var frameWidth:int;
    public var frameHeight:int;
    public var currentFrame:int;
    public var frames:int;
    public var scale:int;
    private var pixels:BitmapData;

    function BackgroundAnimation(x:int, y:int, w:int, h:int, f:int, s:int)  {
        pixels = (new Anim1Graphic).bitmapData;
	this.graphics.beginBitmapFill(pixels, null, true);
        this.graphics.drawRect(0,0,w,h);
	xLoc=x;
	yLoc=y;
        frameWidth=w;
	frameHeight=h;
	currentFrame = 0;
	frames=f;
	scale=s;
    }   
    public function nextFrame():void  {
        currentFrame=currentFrame+1;
	if (currentFrame == frames) {
	  currentFrame = 0;
	}
        this.graphics.beginBitmapFill(pixels, null, true);
        this.graphics.drawRect(currentFrame*frameWidth,0,frameWidth, frameHeight);
    } 

  }

}