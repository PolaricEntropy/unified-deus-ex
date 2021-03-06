//=============================================================================
// Smuggler.
//=============================================================================
class Smuggler extends HumanThug;

function bool Facelift(bool bOn)
{
	local int i;

	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
		Mesh = Mesh(DynamicLoadObject("HDTPCharacters.HDTPSmuggler", class'Mesh', True));

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

defaultproperties
{
     CarcassType=Class'DeusEx.SmugglerCarcass'
     WalkingSpeed=0.213333
     BaseAssHeight=-23.000000
     InitialInventory(0)=(Inventory=Class'DeusEx.WeaponJackHammer')
     InitialInventory(1)=(Inventory=Class'DeusEx.AmmoShell',Count=12)
     InitialInventory(2)=(Inventory=Class'DeusEx.WeaponCrowbar')
     GroundSpeed=180.000000
     Mesh=LodMesh'DeusExCharacters.GM_Trench'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.SmugglerTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.SmugglerTex2'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.PantsTex5'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.SmugglerTex0'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.SmugglerTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.SmugglerTex2'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.FramesTex1'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.LensesTex1'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="Smuggler"
     FamiliarName="Smuggler"
     UnfamiliarName="Smuggler"
}
