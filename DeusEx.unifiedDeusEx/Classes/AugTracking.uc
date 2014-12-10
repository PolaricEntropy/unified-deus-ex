//=============================================================================
// AugTracking.
//=============================================================================
class AugTracking extends AugTarget;

var Actor targets[6];
var Actor curtarget;
var int targetSelect;
var int oldLevel;

state Active
{

Begin:
	oldLevel = currentLevel;

	SetTargetingAugStatus(CurrentLevel,True);
	curTarget = targets[targetSelect];
}

function Deactivate()
{
   local DeusExWeapon W;

	if(targetSelect <= currentLevel && currentLevel == oldLevel) //Justice: Make sure to shut down properly if the aug was upgraded
	{
		targetSelect++;
		
		while(targets[targetSelect] == None && targetSelect <= currentLevel) //Cycle through empty targets until a live one is found
			targetSelect++;
		if(targetSelect > currentLevel + 1 || targets[targetSelect] == None) //There's probably a more elegant way to do this, but I'm tired and this works, so there you go
		{
			targetSelect = 0;
			curTarget = None;
			Super.Deactivate();
			SetTargetingAugStatus(CurrentLevel,False);
		}

		curTarget = targets[targetSelect];
		
		if(targetSelect > 0)
			Player.ClientMessage(Sprintf("Target %d selected", targetSelect));
	}
	else
	{
		targetSelect = 0;
		curTarget = None;
		Super.Deactivate();
		SetTargetingAugStatus(CurrentLevel,False);
	}

}

function setTarget(Actor target)
{
	local int i;
	
	for(i = 1; i <= CurrentLevel + 1; i++)
	{
		if(targets[i] == None)
		{
			targets[i] = target;
			curTarget = targets[i];
			targetSelect = i;
			return;
		}
	}
	
	if(targetSelect == 0)
		targetSelect++;
	
	targets[targetSelect] = target;
	curTarget = target;
	
	DeusExRootWindow(Player.rootWindow).hud.augDisplay.setCameraOnce = False;
}

//Justice: Cleans out the targets to avoid crashes on map change
function clearTargets()
{
	local int i;
	
	for(i = 0; i < 6; i++)
		targets[i] = None;
		
	curTarget = None;
	targetSelect = 0;
}

function removeTarget(Actor target)
{
	local int i;
	
	for(i = 0; i < 6; i++)
		if(targets[i] == target)
		{
			targets[i] = None;
			if(targetSelect == i)
			{
				targetSelect = 0;
				curTarget = None;
			}
		}
}

defaultproperties
{
     EnergyRate=0.000000
     EnergyRateLabel="Energy Rate: 10 Units/Dart"
     AugmentationName="Tracking"
     Description="Nanofactories can produce and fire intelligence gathering micro darts, which, when attached, deliver limited situational info about a target.|n|nTECH ONE: General information is given about one target.|n|nTECH TWO: More information is given about up to two targets.|n|nTECH THREE: Specific information is given about up to three targets.|n|nTECH FOUR: Video feed is transmitted from up to four targets."
     AugType=automatic
}
