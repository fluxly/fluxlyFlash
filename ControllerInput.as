package {
  import flash.events.KeyboardEvent;
  import flash.errors.*;
  import flash.events.*;
  import flash.net.Socket;
        
  public class ControllerInput {
    public var state:Array = new Array(32);
    private var arduinoSocket:Socket;
    private var input:int;

    public function ControllerInput() {
        for (var i:int=0; i<32; i++) {
	  state[i]=false;      
        }
        openArduinoSocket();
    }

    public function on_keydown(e:KeyboardEvent):void {
       state[e.keyCode-65] = true;

    }
         
    public function on_keyup(e:KeyboardEvent):void {
       state[e.keyCode-65]=false;
      
    }

    private function openArduinoSocket():void {
	//Create a socket connection to serproxy
	arduinoSocket = new Socket("localhost",5331);
	arduinoSocket.addEventListener(Event.CLOSE, closeHandler);
	arduinoSocket.addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
    }
 
    private function closeHandler(event:Event):void {
	//  re-open socket if it gets closed accidentially
	openArduinoSocket();
    }
 
    private function socketDataHandler(event:ProgressEvent):void {
        var base_index:uint;
        if (arduinoSocket.bytesAvailable >=6) {
        for (var i:int=0; i<6; i++) {
            input = arduinoSocket.readByte();
            // place byte in state table
            base_index = input >>4;
	    for (var j:int=0;j<0;j++) {
	      //    state[base_index+j] = (input >> j) & 0x01;
            }
        } 
     }
    }
  }
}