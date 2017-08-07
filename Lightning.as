package {
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
        import flash.display.Sprite;
       import flash.display.BitmapData;
        
  public class Lightning {

    [Embed(source="data/lightning.png")] private var LightningGraphic:Class;
    public var body:b2Body;
    public var body_def:b2BodyDef;
    public var the_box:b2PolygonDef;
    public var graphic:Sprite;
    public var onscreen:Boolean;
    private var w:Number=.5;
    private var h:Number=10.0;

    function Lightning(x1:Number, y1:Number, angle:Number){
         
        graphic = new Sprite();
        body_def = new b2BodyDef();
	body_def.position.Set(x1,y1);
	body_def.linearDamping = 20;
	body_def.angularDamping = 20;
	the_box = new b2PolygonDef();
	the_box.SetAsBox(w,h);
	the_box.friction=1;
	the_box.density=5.0;

        var pixels:BitmapData;
        pixels = (new LightningGraphic).bitmapData;
	graphic.graphics.beginBitmapFill(pixels, null, true);
        graphic.graphics.drawRect(0,0,64,649);
	graphic.x=-60;
	graphic.y=-40;
	
    }
   
  }

}