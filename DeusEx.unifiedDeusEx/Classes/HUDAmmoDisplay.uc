//=============================================================================
// HUDAmmoDisplay
//=============================================================================
class HUDAmmoDisplay expands HUDBaseWindow;

var Bool			bVisible;
var Color			colAmmoText;		// Ammo count text color
var Color			colAmmoLowText;		// Color when ammo low
var Color			colNormalText;		// color for normal weapon messages
var Color			colTrackingText;	// color when weapon is tracking
var Color			colLockedText;		// color when weapon is locked
var int             infoX;

var localized String NotAvailable;
var localized String msgReloading;
var localized String AmmoLabel;
var localized String ClipsLabel;

// Used by DrawWindow
var int clipsRemaining;
var int ammoRemaining;
var int ammoInClip;
var DeusExWeapon weapon;
		
// Defaults
var Texture texBackground;
var Texture texBorder;

// ----------------------------------------------------------------------
// InitWindow()
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();

	bTickEnabled = TRUE;

	Hide();

	SetSize(95 * dxEnhancedGUIScaleMultiplier, 77 * dxEnhancedGUIScaleMultiplier);
}

function ScaleDimensions() {
	Super.ScaleDimensions();
	
	infoX *= dxEnhancedGUIScaleMultiplier;	
}
 
// ----------------------------------------------------------------------
// Tick()
// ----------------------------------------------------------------------

event Tick(float deltaSeconds)
{
	if ((player.Weapon != None) && ( bVisible ))
		Show();
	else
		Hide();
}

// ----------------------------------------------------------------------
// DrawWindow()
// ----------------------------------------------------------------------

event DrawWindow(GC gc)
{
	Super.DrawWindow(gc);

	// No need to draw anything if the player doesn't have
	// a weapon selected

	if (player != None)
		weapon = DeusExWeapon(player.Weapon);

	if ( weapon != None )
	{
		// Draw the weapon icon
		gc.SetStyle(DSTY_Masked);
		gc.SetTileColorRGB(255, 255, 255);
		gc.DrawTexture(22 * dxEnhancedGUIScaleMultiplier, 20 * dxEnhancedGUIScaleMultiplier, 
					   40 * dxEnhancedGUIScaleMultiplier, 35 * dxEnhancedGUIScaleMultiplier, 0, 0, weapon.icon);
		
		// Draw the ammo count
		gc.SetFont(Font'FontTiny');
		gc.SetAlignments(HALIGN_Center, VALIGN_Center);
		gc.EnableWordWrap(false);

		// how much ammo of this type do we have left?
		if (weapon.AmmoType != None)
		{
			ammoRemaining = weapon.AmmoType.AmmoAmount;
			if(weapon.AmmoUseModifier > 1)
				ammoRemaining = ammoRemaining/weapon.AmmoUseModifier;
		}
		else
			ammoRemaining = 0;

		if ( ammoRemaining < weapon.LowAmmoWaterMark )
			gc.SetTextColor(colAmmoLowText);
		else
			gc.SetTextColor(colAmmoText);

		// Ammo count drawn differently depending on user's setting
		if (weapon.ReloadCount > 1 )
		{
			// how much ammo is left in the current clip?
			ammoInClip = weapon.AmmoLeftInClip();
			clipsRemaining = weapon.NumClips();

			if (weapon.IsInState('Reload'))
				gc.DrawText(infoX, 26 * dxEnhancedGUIScaleMultiplier, 20 * dxEnhancedGUIScaleMultiplier, 
									9 * dxEnhancedGUIScaleMultiplier, msgReloading);
			else
				gc.DrawText(infoX, 26 * dxEnhancedGUIScaleMultiplier, 20 * dxEnhancedGUIScaleMultiplier, 
									9 * dxEnhancedGUIScaleMultiplier, ammoInClip);

			// if there are no clips (or a partial clip) remaining, color me red
			if (( clipsRemaining == 0 ) || (( clipsRemaining == 1 ) && ( ammoRemaining < 2 * weapon.ReloadCount )))
				gc.SetTextColor(colAmmoLowText);
			else
				gc.SetTextColor(colAmmoText);

			if (weapon.IsInState('Reload'))
				gc.DrawText(infoX, 38 * dxEnhancedGUIScaleMultiplier, 20 * dxEnhancedGUIScaleMultiplier, 9 * dxEnhancedGUIScaleMultiplier, msgReloading);
			else
				gc.DrawText(infoX, 38 * dxEnhancedGUIScaleMultiplier, 20 * dxEnhancedGUIScaleMultiplier, 
									9 * dxEnhancedGUIScaleMultiplier, clipsRemaining);
		}
		else
		{
			gc.DrawText(infoX, 38 * dxEnhancedGUIScaleMultiplier, 20 * dxEnhancedGUIScaleMultiplier, 
								9 * dxEnhancedGUIScaleMultiplier, NotAvailable);

			if (weapon.ReloadCount == 0)
			{
				gc.DrawText(infoX, 26 * dxEnhancedGUIScaleMultiplier, 20 * dxEnhancedGUIScaleMultiplier, 
									9 * dxEnhancedGUIScaleMultiplier, NotAvailable);
			}
			else
			{
				if (weapon.IsInState('Reload'))
					gc.DrawText(infoX, 26 * dxEnhancedGUIScaleMultiplier, 20 * dxEnhancedGUIScaleMultiplier, 
										9 * dxEnhancedGUIScaleMultiplier, msgReloading);
				else
					gc.DrawText(infoX, 26 * dxEnhancedGUIScaleMultiplier, 20 * dxEnhancedGUIScaleMultiplier, 
										9 * dxEnhancedGUIScaleMultiplier, ammoRemaining);
			}
		}

		// Now, let's draw the targetting information
		if (weapon.bCanTrack || weapon.bLasing)
		{
			if (weapon.LockMode == LOCK_Locked)
				gc.SetTextColor(colLockedText);
			else if (weapon.LockMode == LOCK_Acquire)
				gc.SetTextColor(colTrackingText);
			else
				gc.SetTextColor(colNormalText);
			gc.DrawText(25 * dxEnhancedGUIScaleMultiplier, 56 * dxEnhancedGUIScaleMultiplier, 
						65 * dxEnhancedGUIScaleMultiplier,  8 * dxEnhancedGUIScaleMultiplier, weapon.TargetMessage);
		}
	}
}

// ----------------------------------------------------------------------
// DrawBackground()
// ----------------------------------------------------------------------

function DrawBackground(GC gc)
{
	gc.SetStyle(backgroundDrawStyle);
	gc.SetTileColor(colBackground);
	gc.DrawTexture(13 * dxEnhancedGUIScaleMultiplier, 13 * dxEnhancedGUIScaleMultiplier, 
				   80 * dxEnhancedGUIScaleMultiplier, 54 * dxEnhancedGUIScaleMultiplier, 0, 0, texBackground);

	// Draw the Ammo and Clips text labels
	gc.SetFont(Font'FontTiny');
	gc.SetTextColor(colText);
	gc.SetAlignments(HALIGN_Center, VALIGN_Top);

	gc.DrawText(66 * dxEnhancedGUIScaleMultiplier, 17 * dxEnhancedGUIScaleMultiplier, 
				21 * dxEnhancedGUIScaleMultiplier,  8 * dxEnhancedGUIScaleMultiplier, AmmoLabel);
	gc.DrawText(66 * dxEnhancedGUIScaleMultiplier, 48 * dxEnhancedGUIScaleMultiplier, 
				21 * dxEnhancedGUIScaleMultiplier,  8 * dxEnhancedGUIScaleMultiplier, ClipsLabel);
}

// ----------------------------------------------------------------------
// DrawBorder()
// ----------------------------------------------------------------------

function DrawBorder(GC gc)
{
	if (bDrawBorder)
	{
		gc.SetStyle(borderDrawStyle);
		gc.SetTileColor(colBorder);
		gc.DrawTexture(0, 0, 95 * dxEnhancedGUIScaleMultiplier, 77 * dxEnhancedGUIScaleMultiplier, 0, 0, texBorder);
	}
}

// ----------------------------------------------------------------------
// SetVisibility()
// ----------------------------------------------------------------------

function SetVisibility( bool bNewVisibility )
{
	bVisible = bNewVisibility;
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     colAmmoText=(G=255)
     colAmmoLowText=(R=255)
     colNormalText=(G=255)
     colTrackingText=(R=255,G=255)
     colLockedText=(R=255)
     infoX=66
     NotAvailable="N/A"
     msgReloading="---"
     AmmoLabel="AMMO"
     ClipsLabel="CLIPS"
     texBackground=Texture'DeusExUI.UserInterface.HUDAmmoDisplayBackground_1'
     texBorder=Texture'DeusExUI.UserInterface.HUDAmmoDisplayBorder_1'
}
