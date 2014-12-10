//=============================================================================
// PersonaCheckboxWindow
//=============================================================================

class PersonaCheckboxWindow expands CheckboxWindow;

var int dxEnhancedGUIScaleMultiplier;

var DeusExPlayer player;

// Defaults
var Color colText;
var Color colButtonFace;
var Font  fontText;
var int   fontBaseLine;
var int   fontAcceleratorLineHeight;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();

	// Get a pointer to the player
	player = DeusExPlayer(GetRootWindow().parentPawn);
	dxEnhancedGUIScaleMultiplier = player.dxEnhancedGUIScaleMultiplier;

    fontBaseLine = 1 * dxEnhancedGUIScaleMultiplier;
    fontAcceleratorLineHeight = 1 * dxEnhancedGUIScaleMultiplier;
	
	SetFont(fontText);
	SetTextAlignments(HALIGN_Left, VALIGN_Center);
	SetTextMargins(0, 0);
	SetCheckboxTextures(Texture'PersonaCheckBox_Off', Texture'PersonaCheckBox_On', 12 * dxEnhancedGUIScaleMultiplier, 12 * dxEnhancedGUIScaleMultiplier);
	SetCheckboxSpacing(6 * dxEnhancedGUIScaleMultiplier);
	SetCheckboxStyle(DSTY_Masked);
	SetBaselineData(fontBaseLine, fontAcceleratorLineHeight);

	// TODO: Unique HUD sounds
	SetButtonSounds(None, Sound'Menu_Press');
	SetSoundVolume(0.25);

	StyleChanged();
}

// ----------------------------------------------------------------------
// StyleChanged()
// ----------------------------------------------------------------------

event StyleChanged()
{
	local ColorTheme theme;

	theme = player.ThemeManager.GetCurrentHUDColorTheme();

	colText       = theme.GetColorFromName('HUDColor_ButtonTextNormal');
	colButtonFace = theme.GetColorFromName('HUDColor_ButtonFace');

	SetTextColors(colText, colText, colText, colText, colText, colText);
	SetCheckboxColor(colText);
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     dxEnhancedGUIScaleMultiplier=1
     colText=(R=255,G=255,B=255)
     fontText=Font'DeusExUI.FontMenuHeaders'
     fontBaseLine=1
     fontAcceleratorLineHeight=1
}
