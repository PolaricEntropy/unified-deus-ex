//=============================================================================
// Lamp.
//=============================================================================
class Lamp extends Furniture
   abstract;

var() bool bOn;

function Frob(Actor Frobber, Inventory frobWith)
{
   Super.Frob(Frobber, frobWith);

   if (!bOn)
   {
      bOn = True;
      LightType = LT_Steady;
      PlaySound(sound'Switch4ClickOn');
   }
   else
   {
      bOn = False;
      LightType = LT_None;
      PlaySound(sound'Switch4ClickOff');
   }
   ResetScaleGlow();
}

function PostBeginPlay()
{
   lighttype = LT_Steady;
   ResetScaleGlow();//might as well do this every time, because seriously, what the fuck is your problem, light?
   Super.PostBeginPlay();
}


function ResetScaleGlow()
{
   local float mod;

   if (!bInvincible)
      mod = float(HitPoints) / float(Default.HitPoints) * 0.9 + 0.1;
   else
      mod = 1;

   if(bOn)
   {
      ScaleGlow = 2.0 * mod;
      bUnlit = true;
   }
   else
   {
      ScaleGlow = mod;
      bUnlit = false;
   }

}

defaultproperties
{
     FragType=Class'DeusEx.GlassFragment'
     bPushable=False
     LightBrightness=255
     LightSaturation=255
     LightRadius=10
}
