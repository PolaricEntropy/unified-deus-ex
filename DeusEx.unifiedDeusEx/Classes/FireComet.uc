//=============================================================================
// FireComet.
//=============================================================================
class FireComet extends DeusExFragment;

auto simulated state Flying
{
	simulated function HitWall(vector HitNormal, actor Wall)
	{	
		local bool HDTP_NotDetected;
		local PlayerPawn playerPawn;
		local DeusExPlayer localPlayer;
		
		local BurnMark mark;

		mark = spawn(class'BurnMark',,, Location, Rotator(HitNormal));
		if (mark != None)
		{
			HDTP_NotDetected = False;
			playerPawn = GetPlayerPawn();
			if (playerPawn != None)	localPlayer = DeusExPlayer(playerPawn);
			if (localPlayer != None)	HDTP_NotDetected = localPlayer.flagBase.GetBool('HDTP_NotDetected');
	
			if (HDTP_NotDetected)
				mark.DrawScale = 0.4*DrawScale;
			else
				mark.DrawScale *= 0.4*DrawScale;
			mark.ReattachDecal();
		}
		Destroy();
	}
	simulated function BeginState()
	{
		Velocity = VRand() * 300;
		Velocity.Z = FRand() * 200 + 200;
		DrawScale = 0.3 + FRand();
		SetRotation(Rotator(Velocity));
	}
}

simulated function Tick(float deltaTime)
{
	if (Velocity == vect(0,0,0))
	{
		spawn(class'BurnMark',,, Location, rot(16384,0,0));
		Destroy();
	}
	else
		SetRotation(Rotator(Velocity));
}

defaultproperties
{
     Style=STY_Translucent
     Mesh=LodMesh'DeusExItems.FireComet'
     ScaleGlow=2.000000
     bUnlit=True
     CollisionRadius=0.000000
     CollisionHeight=0.000000
     bBounce=False
}
