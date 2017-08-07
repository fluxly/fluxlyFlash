package {
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
        import flash.display.Sprite;
        import flash.display.BitmapData;

  public class Cloud {
    [Embed(source="data/cloud.png")] private var CloudGraphic:Class;
    public var body:b2Body;
    public var body_def:b2BodyDef;
    public var the_box:b2PolygonDef;
    public var graphic:Sprite;
    public var onscreen:Boolean;
 
    function Cloud(x:Number, y:Number, w:Number, h:Number,f:Number,d:Number){
        graphic = new Sprite();
        body_def = new b2BodyDef();
	body_def.linearDamping = 19;
	body_def.angularDamping = 19;
	body_def.position.Set(x,y);
	the_box = new b2PolygonDef();
	the_box.SetAsBox(w,h);

	the_box.friction=f;
	the_box.density=d;

        var pixels:BitmapData;
        pixels = (new CloudGraphic).bitmapData;
	graphic.graphics.beginBitmapFill(pixels, null, true);
        graphic.graphics.drawRect(0,0,62,42);
	graphic.x=-62;
	graphic.y=-40;

	
    }
    
  }

}