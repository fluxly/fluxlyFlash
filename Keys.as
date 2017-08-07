package {
	import flash.events.KeyboardEvent;
        
  public class Keys {
   

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
	static public function on_keyup(e:KeyboardEvent):void{
 
         switch (e.keyCode){
            case 97://a
              ka = false;
              break;
	    case 100://d
              kd = false;
            break;
              case 113://q
              kq = false;
            break;
            case 119://w
              kw = false;
              break;
            case 106://j
              kj = false;
              break;
	    case 108://l
              kl = false;
            break;
              case 117://u
              ku = false;
            break;
            case 105://i
              ki = false;
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