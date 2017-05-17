//=============================================================================
// DeusExAmmo.
//=============================================================================

//Modified -- Y|yukichigai

class DeusExAmmo extends Ammo
	abstract;

var localized String msgInfoRounds;

// True if this ammo can be displayed in the Inventory screen
// by clicking on the "Ammo" button.

var bool bShowInfo;
var int MPMaxAmmo; //Max Ammo in multiplayer.
var bool bIsNonStandard; //For the purposes of picking it up from corpses
var String DynamicLoadIcon; //The icon we should optionally load to use in the GUI, if present

var bool isGrenade;

var int dxEnhancedGUIScaleMultiplier;

// ----------------------------------------------------------------------
// PreBeginPlay()
// ----------------------------------------------------------------------
simulated function PreBeginPlay()
{
	local bool HDTP_NotDetected;
	local PlayerPawn playerPawn;
	local DeusExPlayer localPlayer;

	Super.PreBeginPlay();
	
	HDTP_NotDetected = False;
	playerPawn = GetPlayerPawn();
	if (playerPawn != None)	localPlayer = DeusExPlayer(playerPawn);
	if (localPlayer != None)	HDTP_NotDetected = localPlayer.flagBase.GetBool('HDTP_NotDetected');
	
	if(Level.NetMode == NM_Standalone && !HDTP_NotDetected)
		Facelift(true);
}

// ----------------------------------------------------------------------
// Facelift()
//  Applies the new HDTP textures and meshes if present, stays the same
//  otherwise.  Also, the name of this function is made of win
// ----------------------------------------------------------------------
function bool Facelift(bool bOn)
{
	local PlayerPawn playerPawn;
	playerPawn = GetPlayerPawn();
	if (playerPawn != None) {
		dxEnhancedGUIScaleMultiplier = DeusExPlayer(playerPawn).dxEnhancedGUIScaleMultiplier;
		largeIconWidth = Default.largeIconWidth * dxEnhancedGUIScaleMultiplier;
		largeIconHeight = Default.largeIconHeight * dxEnhancedGUIScaleMultiplier;
	}

	//== Only do this for DeusEx classes
	if(instr(String(Class.Name), ".") > -1 && bOn)
		if(instr(String(Class.Name), "DeusEx.") <= -1)
			return false;
	else
		if((Class != Class(DynamicLoadObject("DeusEx."$ String(Class.Name), class'Class', True))) && bOn)
			return false;

	return true;
}

// ----------------------------------------------------------------------
// PostBeginPlay()
// ----------------------------------------------------------------------
function PostBeginPlay()
{
	Super.PostBeginPlay();
   if (Level.NetMode != NM_Standalone)
   {   
      if (MPMaxAmmo == 0)      
         MPMaxAmmo = AmmoAmount * 3;
      MaxAmmo = MPMaxAmmo;
   }
}

// ----------------------------------------------------------------------
// HandlePickupQuery() //== Override to display ammo count on pickup
// ----------------------------------------------------------------------
function bool HandlePickupQuery( inventory Item )
{
	if ( (class == item.class) || 
		(ClassIsChildOf(item.class, class'Ammo') && (class == Ammo(item).parentammo)) ) 
	{
		if (AmmoAmount==MaxAmmo) return true;
		if (Level.Game.LocalLog != None)
			Level.Game.LocalLog.LogPickup(Item, Pawn(Owner));
		if (Level.Game.WorldLog != None)
			Level.Game.WorldLog.LogPickup(Item, Pawn(Owner));
		if (Item.PickupMessageClass == None)
			// DEUS_EX CNN - use the itemArticle and itemName
			Pawn(Owner).ClientMessage( Item.PickupMessage @ Item.itemArticle @ Item.ItemName @ "("$Ammo(Item).AmmoAmount$")", 'Pickup' );
		else
			Pawn(Owner).ReceiveLocalizedMessage( Item.PickupMessageClass, 0, None, None, item.Class );
		item.PlaySound( item.PickupSound );
		AddAmmo(Ammo(item).AmmoAmount);
		item.SetRespawn();
		return true;				
	}
	if ( Inventory == None )
		return false;

	return Inventory.HandlePickupQuery(Item);
}

// ----------------------------------------------------------------------
// UpdateInfo()
// ----------------------------------------------------------------------

simulated function bool UpdateInfo(Object winObject)
{
	local PersonaInfoWindow winInfo;

	winInfo = PersonaInfoWindow(winObject);
	if (winInfo == None)
		return False;

	winInfo.SetTitle(itemName);
	winInfo.SetText(Description $ winInfo.CR() $ winInfo.CR());

	// number of rounds left
	winInfo.AppendText(Sprintf(msgInfoRounds, AmmoAmount));

	return True;
}

// ----------------------------------------------------------------------
// PlayLandingSound()
// ----------------------------------------------------------------------

function PlayLandingSound()
{
	if (LandSound != None)
	{
		if (Velocity.Z <= -200)
		{
			PlaySound(LandSound, SLOT_None, TransientSoundVolume,, 768);
			AISendEvent('LoudNoise', EAITYPE_Audio, TransientSoundVolume, 768);
		}
	}
}

//Justice: Allows the player to carry extra LAMS according to their demo skill
function bool AddAmmo(int AmmoToAdd)
{
	local int demoSkill;
	
	if(isGrenade)
	{
		demoSkill = DeusExPlayer(GetPlayerPawn()).SkillSystem.GetSkillLevel(class'SkillDemolition') * 2;
		
		If (AmmoAmount >= MaxAmmo + demoSkill) return false;
			AmmoAmount += AmmoToAdd;
		if (AmmoAmount > MaxAmmo + demoSkill) AmmoAmount = MaxAmmo + demoSkill;
			return true;
	}
	else
		return super.AddAmmo(AmmoToAdd);
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     msgInfoRounds="%d Rounds remaining"
     dxEnhancedGUIScaleMultiplier=1
     bDisplayableInv=False
     PickupMessage="You found"
     ItemName="DEFAULT AMMO NAME - REPORT THIS AS A BUG"
     ItemArticle=""
     LandSound=Sound'DeusExSounds.Generic.PaperHit1'
}
