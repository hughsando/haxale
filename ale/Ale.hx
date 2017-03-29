package ale;

class Ale
{
   var handle:Dynamic;
   public var width(default,null):Int;
   public var height(default,null):Int;

   public function new(inRom:String)
   {
      handle = createInterface(inRom);
      width = getWidthFunc(handle);
      height = getHeightFunc(handle);
   }
   public function resetGame() resetGameFunc(handle);
   public function gameOver(): Bool return gameOverFunc(handle);
   public function act(action:Action):Int  return actFunc(handle,cast action);
   public function getActions(inMinimal:Bool):Array<Action>
   {
      var result = new Array<Action>();
      getActionSet(handle,result,inMinimal);
      return result;
   }
   public function savePng(filename:String) : Void savePngFunc(handle,filename);
   public function getScreenRgb32(bytes:haxe.io.Bytes) : Void getScreenRgb32Func(handle,bytes);
   public function ok() return handle!=null;
   public function destroy():Void { destroyFunc(handle); handle = null; }

   public static function main()
   {
      var ale = new Ale(Sys.args()[0]);
      var actions = ale.getActions(true);
      if (actions.length==0)
         throw "No valid actions";
      ale.resetGame();
      var totalScore = 0;
      while(!ale.gameOver())
      {
         var reward = ale.act( actions[ Std.int( Math.random()*actions.length ) ] );
         totalScore += reward;
         if (reward>0)
            Sys.println("reward " + reward);
      }
      Sys.println("Game over! " + totalScore);
      ale.savePng("gameover.png");
   }


   static var createInterface = Loader.load("createInterface", "so" );
   static var resetGameFunc = Loader.load("resetGame", "ov" );
   static var gameOverFunc = Loader.load("gameOver", "ob" );
   static var actFunc = Loader.load("act", "oii" );
   static var getActionSet = Loader.load("getActionSet", "oobv" );
   static var getWidthFunc = Loader.load("getWidth", "oi" );
   static var getHeightFunc = Loader.load("getHeight", "oi" );
   static var getScreenRgb32Func = Loader.load("getScreenRgb32", "oov" );
   static var savePngFunc = Loader.load("savePng", "osv" );
   static var destroyFunc = Loader.load("destroy", "ov" );
}

