package {
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
        import flash.display.Sprite;
        

  public class Block {
    //  [Embed(source="data/block.png")] private var BlockGraphic:Class;
    public var body:b2Body;
    public var body_def:b2BodyDef;
    public var the_box:b2PolygonDef;
    public var graphic:Sprite;
    public var onscreen:Boolean;
 
    function Block(x:Number, y:Number, w:Number, h:Number,f:Number,d:Number,c:uint){
        graphic = new Sprite();
        body_def = new b2BodyDef();
	body_def.position.Set(x,y);
	the_box = new b2PolygonDef();
	the_box.SetAsBox(w,h);
	the_box.friction=f;
	the_box.density=d;

        graphic.graphics.beginFill(c);
        graphic.graphics.drawRect(0,0,w*60,h*60);
	graphic.x = -30;
	graphic.y=-30;
	
    }
   
  }

}