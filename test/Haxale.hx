import nme.display.*;
import nme.events.*;
import nme.utils.ByteArray;
import nme.geom.*;
import ale.*;
using StringTools;


class Haxale extends Sprite
{
   var bitmap:Bitmap;
   var bitmapData:BitmapData;
   var ale:Ale;
   var screenBuffer:ByteArray;
   var screenRect:Rectangle;
   var allGames = new Array<String>();
   var actions:Array<Action>;

   public function new()
   {
      super();
      for(a in nme.Assets.list())
         if (a.endsWith(".bin"))
            allGames.push(a);

      bitmap = new Bitmap();
      addChild(bitmap);

      loadGame();

      addEventListener(Event.ENTER_FRAME, function(_) stepGame() );
      stage.addEventListener(Event.RESIZE, function(_) onResize());
      stage.addEventListener(MouseEvent.CLICK, function(_) loadGame());
   }

   function loadGame()
   {
      if (ale!=null)
         ale.destroy();

      var game = allGames[ Std.int( allGames.length * Math.random() ) ];
      ale = new Ale(game);
      if (ale.ok())
      {
         bitmapData = new BitmapData(ale.width, ale.height, false, 0x808080);
         bitmap.bitmapData = bitmapData;
         screenRect = new Rectangle(0,0,ale.width,ale.height);

         actions = ale.getActions(true);
         if (actions.length==0)
            throw "No valid actions";

         ale.resetGame();
         screenBuffer = new ByteArray(ale.width*ale.height*4);
         screenBuffer.bigEndian = false;
         stepGame();
      }

      onResize();
   }

   function stepGame()
   {
      if(!ale.gameOver())
      {
         var reward = ale.act( actions[ Std.int( Math.random()*actions.length ) ] );
         ale.getScreenRgb32(screenBuffer);
         screenBuffer.position = 0;
         bitmapData.setPixels(screenRect,screenBuffer);
      }
      else
         loadGame();
   }

   function onResize()
   {
      if (ale!=null && ale.ok())
      {
         var scale = Math.min( stage.stageWidth/ale.width, stage.stageHeight/ale.height );
         bitmap.scaleX = bitmap.scaleY = scale;
      }
   }
}

