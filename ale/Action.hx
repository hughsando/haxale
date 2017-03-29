package ale;

@:enum
abstract Action(Int) 
{
   var PLAYER_A_NOOP           = 0;
   var PLAYER_A_FIRE           = 1;
   var PLAYER_A_UP             = 2;
   var PLAYER_A_RIGHT          = 3;
   var PLAYER_A_LEFT           = 4;
   var PLAYER_A_DOWN           = 5;
   var PLAYER_A_UPRIGHT        = 6;
   var PLAYER_A_UPLEFT         = 7;
   var PLAYER_A_DOWNRIGHT      = 8;
   var PLAYER_A_DOWNLEFT       = 9;
   var PLAYER_A_UPFIRE         = 10;
   var PLAYER_A_RIGHTFIRE      = 11;
   var PLAYER_A_LEFTFIRE       = 12;
   var PLAYER_A_DOWNFIRE       = 13;
   var PLAYER_A_UPRIGHTFIRE    = 14;
   var PLAYER_A_UPLEFTFIRE     = 15;
   var PLAYER_A_DOWNRIGHTFIRE  = 16;
   var PLAYER_A_DOWNLEFTFIRE   = 17;
   var PLAYER_B_NOOP           = 18;
   var PLAYER_B_FIRE           = 19;
   var PLAYER_B_UP             = 20;
   var PLAYER_B_RIGHT          = 21;
   var PLAYER_B_LEFT           = 22;
   var PLAYER_B_DOWN           = 23;
   var PLAYER_B_UPRIGHT        = 24;
   var PLAYER_B_UPLEFT         = 25;
   var PLAYER_B_DOWNRIGHT      = 26;
   var PLAYER_B_DOWNLEFT       = 27;
   var PLAYER_B_UPFIRE         = 28;
   var PLAYER_B_RIGHTFIRE      = 29;
   var PLAYER_B_LEFTFIRE       = 30;
   var PLAYER_B_DOWNFIRE       = 31;
   var PLAYER_B_UPRIGHTFIRE    = 32;
   var PLAYER_B_UPLEFTFIRE     = 33;
   var PLAYER_B_DOWNRIGHTFIRE  = 34;
   var PLAYER_B_DOWNLEFTFIRE   = 35;
   var RESET                   = 40; // note: we use SYSTEM_RESET instead to reset the environment. 
   var UNDEFINED               = 41;
   var RANDOM                  = 42;
   var SAVE_STATE              = 43;
   var LOAD_STATE              = 44;
   var SYSTEM_RESET            = 45;
   var SELECT                  = 46; // Used to select game mode... should only be used internally 
   var LAST_ACTION_INDEX       = 50;
}
