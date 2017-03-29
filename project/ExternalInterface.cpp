#ifndef STATIC_LINK
#define IMPLEMENT_API
#elif defined(HXCPP_JS_PRIME)
#define IMPLEMENT_API
#endif

#if defined(HX_WINDOWS) || defined(HX_MACOS) || defined(HX_LINUX)
// Include neko glue....
#define NEKO_COMPATIBLE
#endif

#include <hx/CFFIPrime.h>

#include "ale_interface.hpp"

using namespace ale;

namespace xitari
{

vkind aleKind = 0;
static int sRgbPalette[256];

void freeAle(value v)
{
   void *data = val_data(v);
   if (data)
   {
      delete (ALEInterface *)data;
   }
}

ALEInterface *getAle(value inHandle)
{
   return (ALEInterface *)val_to_kind(inHandle, aleKind);
}

value createInterface(HxString inRomFile)
{
   //printf("createInterface %s\n", inRomFile.c_str() );

   ALEInterface *ale = new ALEInterface(inRomFile.c_str());

   if (!aleKind)
   {
      kind_share(&aleKind,"ale");
      unsigned char r,g,b;
      for(int i=0;i<256;i++)
      {
         ALEInterface::getRGB(i,r,g,b);
         sRgbPalette[i] = 0xff000000 | (r<<16) | (g<<8) | b;
      }
   }
   value abstract = alloc_abstract(aleKind, ale);
   val_gc(abstract, freeAle );

   return abstract;
}
DEFINE_PRIME1(createInterface)

void resetGame(value inHandle)
{
   ALEInterface *ale = getAle(inHandle);
   if (ale)
   {
      //printf("resetGame\n");
      ale->resetGame();
   }
}
DEFINE_PRIME1v(resetGame);

bool gameOver(value inHandle)
{
   ALEInterface *ale = getAle(inHandle);
   if (ale)
   {
      return ale->gameOver();
   }
   return true;
}
DEFINE_PRIME1(gameOver);

int act(value inHandle,int inAction)
{
   ALEInterface *ale = getAle(inHandle);
   if (ale)
   {
      return (int)ale->act((Action)inAction);
   }
   return 0;
}
DEFINE_PRIME2(act)

void getActionSet(value inHandle,value outArray,bool inMinimal)
{
   ALEInterface *ale = getAle(inHandle);
   if (ale)
   {
      ActionVect a = inMinimal ? ale->getMinimalActionSet() : ale->getLegalActionSet();
      for(int i=0;i<a.size();i++)
         val_array_push( outArray, alloc_int(a[i]) );
   }
}
DEFINE_PRIME3v(getActionSet);


int getWidth(value inHandle)
{
   ALEInterface *ale = getAle(inHandle);
   if (ale)
      return ale->getScreen().width();
   return 0;
}
DEFINE_PRIME1(getWidth);


int getHeight(value inHandle)
{
   ALEInterface *ale = getAle(inHandle);
   if (ale)
      return ale->getScreen().height();
   return 0;
}
DEFINE_PRIME1(getHeight);


void getScreenRgb32(value inHandle, value inBytes)
{
   ALEInterface *ale = getAle(inHandle);
   if (ale)
   {
      const ALEScreen &screen = ale->getScreen();
      CffiBytes bytes = getByteData(inBytes);

      int n =  screen.width()*screen.height();
      if (bytes.length>=n*4)
      {
         const std::vector<pixel_t> &pixels = screen.getArray();

         int *rgb = (int *)bytes.data;
         for(int i=0;i<n;i++)
            rgb[i] = sRgbPalette[(int)pixels[i]];
      }
   }
}
DEFINE_PRIME2v(getScreenRgb32);


void savePng(value inHandle, HxString inFilename)
{
   ALEInterface *ale = getAle(inHandle);
   if (ale)
   {
      ale->screenToPNG(inFilename.c_str());
   }
}
DEFINE_PRIME2v(savePng);

void destroy(value inHandle)
{
   ALEInterface *ale = getAle(inHandle);
   if (ale)
   {
      delete ale;
      val_gc(inHandle,0);
   }
}
DEFINE_PRIME1v(destroy);



}
