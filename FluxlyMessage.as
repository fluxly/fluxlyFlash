package {
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;

    public class FluxlyMessage extends Sprite {
      public var n:Number;
      private var label:TextField;
      private var labelText:String;

        public function FluxlyMessage() {
            label = new TextField();
            label.autoSize = TextFieldAutoSize.CENTER;
            label.background = false;
            label.border = false;
            addChild(label);
        }

        public function setLabel(str:String):void {
            label.text = str;
            var format:TextFormat = new TextFormat();
            format.font = "Georgia";
            format.color = 0xAAAAAA;
            format.size = 48;
            format.underline = false;

            label.defaultTextFormat = format;
            label.text = str;
        }

       public function setScore():void {
            var format:TextFormat = new TextFormat();
            format.font = "Georgia";
            format.color = 0xAAAAAA;
            format.size = 24;
            format.underline = false;

            label.defaultTextFormat = format;
            label.text = String(n);
        }
    }
}