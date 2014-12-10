//=============================================================================
// MachineGunBase.
//=============================================================================
class MachineGunBase expands DeusExDecoration;


var() float fireRate;
var float fireTimer;
var() float gunAccuracy;
var() int gunDamage;     
var() int ammoAmount;                                     
var Rotator origRot;  
var Rotator AdjustedAim;
var vector FireOffset;

defaultproperties
{
     fireRate=0.100000
     gunAccuracy=0.200000
     gunDamage=35
     AmmoAmount=1000
     Mesh=LodMesh'DeusExDeco.AutoTurretBase'
     DrawScale=1.200000
     CollisionRadius=14.000000
     CollisionHeight=23.200001
}
