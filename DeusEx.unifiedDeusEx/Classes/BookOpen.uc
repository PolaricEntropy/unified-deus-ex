//=============================================================================
// BookOpen.
//=============================================================================
class BookOpen extends InformationDevices;

function bool Facelift(bool bOn)
{
	local Texture hdtpSkin;
	local Mesh hdtpMesh;

	if(bOn) {
		hdtpMesh = Mesh(DynamicLoadObject("HDTPDecos.HDTPBookOpen", class'Mesh', True));
		hdtpSkin = Texture(DynamicLoadObject("HDTPDecos.Skins.HDTPbookOpentex", class'Texture', True));
		if(hdtpMesh != None && hdtpSkin != None) {
			Mesh = hdtpMesh;
			Skin = hdtpSkin;
		}
	}

	return Super.Facelift(bOn);
}

defaultproperties
{
     bCanBeBase=True
     ItemName="Book"
     Mesh=LodMesh'DeusExDeco.BookOpen'
     CollisionRadius=15.000000
     CollisionHeight=1.420000
     Mass=10.000000
     Buoyancy=11.000000
}
