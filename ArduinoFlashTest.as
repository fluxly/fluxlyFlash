package {

	import flash.display.*;
import flash.errors.*;
import flash.events.*;
import flash.net.Socket;
 import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;


public class ArduinoFlashTest extends MovieClip {
var arduinoSocket:Socket;
 var label:TextField;
 var labelText:String;
  var input:int;

public function ArduinoFlashTest():void  {
 
   init();
}

private function init()
{
           label = new TextField();
            label.autoSize = TextFieldAutoSize.CENTER;
            label.background = false;
            label.border = false;
            stage.addChild(label);
            label.text = "foo";
            var format:TextFormat = new TextFormat();
            format.font = "Georgia";
            format.color = 0xAAAAAA;
            format.size = 24;
            format.underline = false;
            label.defaultTextFormat = format;
	openArduinoSocket();
}
 
 
private function openArduinoSocket()
{

	//Create a socket connection to serproxy
	arduinoSocket = new Socket("localhost",5331);
	arduinoSocket.addEventListener(Event.CLOSE, closeHandler);
	arduinoSocket.addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
}
 
private function closeHandler(event:Event):void
{
	// For some reason, the socket gets closed sometimes, re-open it.
	trace("[Workaround] Socket closed, reopening...");
	openArduinoSocket();
}
 
private function socketDataHandler(event:ProgressEvent):void
{
trace("socketDataHandler...");
  var value:String;
  value=" ";
  if (arduinoSocket.bytesAvailable >=6) {
  for (var i:int=0; i<6; i++) {
     input = arduinoSocket.readByte();
     value = value+String(input>>4)+":";
     value = value+String(input&15)+" ";
  }
  label.text = value;
 }

	
}
}
}