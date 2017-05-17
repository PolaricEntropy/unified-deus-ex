//=============================================================================
// AmmoGasGrenade.
//=============================================================================
class AmmoGasGrenade extends DeusExAmmo;

//Justice: Modified for new demo skill

defaultproperties
{
     isGrenade=True
     AmmoAmount=1
     MaxAmmo=8
     PickupViewMesh=LodMesh'DeusExItems.TestBox'
     Icon=Texture'DeusExUI.Icons.BeltIconGasGrenade'
     beltDescription="GAS GREN"
     Mesh=LodMesh'DeusExItems.TestBox'
     CollisionRadius=22.500000
     CollisionHeight=16.000000
     bCollideActors=True
}
