//=============================================================================
// MaggieChow.
//=============================================================================
class MaggieChow extends HumanCivilian;

function bool Facelift(bool bOn)
{
	local int i;

	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = Mesh(DynamicLoadObject("HDTPCharacters.HDTPMaggieChow", class'Mesh', True));

	if(Mesh == None || !bOn)
	{
		Mesh = Default.Mesh;

		for(i = 0; i < 8; ++i)
			MultiSkins[i] = Default.MultiSkins[i];
	}
	else
	{
		for(i = 0; i < 8; ++i)
			MultiSkins[i] = None;
	}

	return true;
}

function GotoDisabledState(name damageType, EHitLocation hitPos)
{
	if (!bCollideActors && !bBlockActors && !bBlockPlayers)
		return;
	if (CanShowPain())
		TakeHit(hitPos);
	else
		GotoNextState();
}

function InitializeInventory()
{
	local DeusExLevelInfo info;
	info = DeusExPlayer(GetPlayerPawn()).GetLevelInfo();

	if(caps(info.mapName) == "15_AREA51_BUNKER")
	{
		InitialInventory[0].Inventory = Class'WeaponPlasmaRifle';
		InitialInventory[1].Inventory = Class'AmmoPlasma';
		InitialInventory[1].Count = 40;
	}

	Super.InitializeInventory();
}

defaultproperties
{
     CarcassType=Class'DeusEx.MaggieChowCarcass'
     WalkingSpeed=0.320000
     bImportant=True
     BaseAssHeight=-18.000000
     walkAnimMult=0.650000
     bIsFemale=True
     GroundSpeed=120.000000
     BaseEyeHeight=38.000000
     Mesh=LodMesh'DeusExCharacters.GFM_SuitSkirt'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.SkinTex5'
     MultiSkins(1)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.SkinTex5'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.LegsTex2'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.MaggieChowTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.MaggieChowTex1'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
     CollisionRadius=20.000000
     CollisionHeight=43.000000
     BindName="MaggieChow"
     FamiliarName="Maggie Chow"
     UnfamiliarName="Maggie Chow"
}
