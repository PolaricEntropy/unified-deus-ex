//=============================================================================
// BloodPool.
//=============================================================================
class BloodPool extends DeusExDecal;

var float spreadTime;
var float maxDrawScale;
var float time;

function bool Facelift(bool bOn)
{
	if(!Super.Facelift(bOn))
		return false;

	if(bOn) {
		Texture = Texture(DynamicLoadObject("HDTPItems.Skins.HDTPFlatFXTex1", class'Texture', True));
		maxDrawScale=0.093750;
	}

	if(Texture == None || !bOn)
	{
		Texture = Default.Texture;
		maxDrawScale = Default.maxDrawScale;
	}

	return true;
} 

function BeginPlay()
{
	// Gore check
	if (Level.Game.bLowGore || Level.Game.bVeryLowGore)
	{
		Destroy();
		return;
	}
	Super.BeginPlay();
}

function Tick(float deltaTime)
{
	time += deltaTime;
	if (time <= spreadTime)
	{
		DrawScale = maxDrawScale * time / spreadTime;
		ReattachDecal(vect(0.1,0.1,0));
	}
}

defaultproperties
{
     spreadTime=5.000000
     maxDrawScale=1.500000
     Texture=Texture'DeusExItems.Skins.FlatFXTex1'
}
