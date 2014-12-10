//=============================================================================
// LifeSupportBase.
//=============================================================================
class LifeSupportBase extends DeusExDecoration;

var bool bOn;

function bool Facelift(bool bLiftOn)
{
	if(!Super.Facelift(bLiftOn))
		return false;

	if(bLiftOn)
		Skin = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPLightswitchTex1",class'Texture', True));

	if(Skin == None || bLiftOn)
		Skin = None;

	return true;
}

function Frob(Actor Frobber, Inventory frobWith)
{
	Super.Frob(Frobber, frobWith);


	if (bOn)
	{
		PlaySound(sound'Switch4ClickOff');
		PlayAnim('Off');
	}
	else
	{
		PlaySound(sound'Switch4ClickOn');
		PlayAnim('On');
	}

	bOn = !bOn;
}

defaultproperties
{
     bInvincible=True
     bHighlight=False
     bPushable=False
     bBlockSight=True
     Physics=PHYS_None
     Mesh=LodMesh'DeusExDeco.LifeSupportBase'
     CollisionRadius=77.000000
     CollisionHeight=46.450001
     Mass=400.000000
     Buoyancy=200.000000
}
