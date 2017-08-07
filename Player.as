package {
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
        import flash.display.Sprite;
        import flash.display.BitmapData;
        import flash.geom.Matrix;

  public class Player {
    [Embed(source="data/fluxum1.png")] private var Player1Graphic:Class;
    [Embed(source="data/fluxa1.png")] private var Player2Graphic:Class;
    public var body:b2Body;
    public var body_def:b2BodyDef;
    public var top:b2PolygonDef;
    public var bottom:b2PolygonDef;
    public var the_circle:b2CircleDef;
    public var graphic:Sprite;
    public var onscreen:Boolean=true;
    public var n:int;
    public var offset:int;

    function Player(num:int,x:Number, y:Number, w:Number, h:Number,f:Number,d:Number, s:Boolean) {
      n = num;
      graphic = new Sprite();
        body_def = new b2BodyDef();
	body_def.position.Set(x,y);

        if (s) {
	  the_circle = new b2CircleDef();
  	  the_circle.radius=1;
	  the_circle.friction=f/4;
	  the_circle.density=d/8;

        } else {
          top = new b2PolygonDef();
  	  top.SetAsOrientedBox(w,h/2,new b2Vec2(0, 0), 0);
	  top.friction=f;
	  top.density=0.0;

	  bottom = new b2PolygonDef();
	  bottom.SetAsOrientedBox(w,h/2,new b2Vec2(0, h/2), 0);
	  bottom.friction=f;
	  bottom.density=d*2;
	}

        var pixels:BitmapData;
        if (num==1) {
	    pixels = (new Player1Graphic).bitmapData;
        } 
        if (num==2) {
	    pixels = (new Player2Graphic).bitmapData;
        } 
	if (s) {
	  graphic.graphics.beginFill(random_color(),.5);
	  graphic.graphics.drawCircle(15,30,30);
	   graphic.graphics.beginBitmapFill(pixels, null, true);
          graphic.graphics.drawRect(0,0,30,60);
	  graphic.x=60;
	  graphic.y=-30;
	} else {
	  graphic.graphics.beginBitmapFill(pixels, null, true);
          graphic.graphics.drawRect(0,0,30,60);
	  graphic.x=-30;
	  graphic.y=-60;
        }
    }
   
    public function getImageScaled(m:Matrix):Sprite {
      var g:Sprite = new Sprite;
      var pixels:BitmapData;
        if (n==1) {
	    pixels = (new Player1Graphic).bitmapData;
        } 
        if (n==2) {
	    pixels = (new Player2Graphic).bitmapData;
        } 
	g.graphics.beginBitmapFill(pixels, m, true);
        g.graphics.drawRect(0,0,150,300);
	g.x=175;
	g.y=50;
	return g;
    }
	  private function random_color():uint {
            return Math.round( Math.random()*0xFFFFFF );
          }
  }

}