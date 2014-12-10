//=============================================================================
// MaggieChowCarcass.
//=============================================================================
class MaggieChowCarcass extends DeusExCarcass;

function bool Facelift(bool bOn)
{
	local int i;
	if(!Super.Facelift(bOn))
		return false;

	if(bOn)
	{
		Mesh = Mesh(DynamicLoadObject("HDTPCharacters.HDTPMaggieChowCarcass", class'Mesh', True));
		Mesh2 = Mesh(DynamicLoadObject("HDTPCharacters.HDTPMaggieChowCarcassB", class'Mesh', True));
		Mesh3 = Mesh(DynamicLoadObject("HDTPCharacters.HDTPMaggieChowCarcassC", class'Mesh', True));
	}

	if(Mesh == None || Mesh2 == None || Mesh3 == None || !bOn)
	{
		Mesh = Default.Mesh;
		Mesh2 = Default.Mesh2;
		Mesh3 = Default.Mesh3;

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
     Mesh2=LodMesh'DeusExCharacters.GFM_SuitSkirt_CarcassB'
     Mesh3=LodMesh'DeusExCharacters.GFM_SuitSkirt_CarcassC'
     Mesh=LodMesh'DeusExCharacters.GFM_SuitSkirt_Carcass'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.SkinTex5'
     MultiSkins(1)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.SkinTex5'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.LegsTex2'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.MaggieChowTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.MaggieChowTex1'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
}
