//=============================================================================
// MenuUISpecialButtonWindow
//=============================================================================

class MenuUISpecialButtonWindow extends ButtonWindow;

var int dxEnhancedGUIScaleMultiplier;

var DeusExPlayer player;

var Texture texNormal;
var Texture texFocus;

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

	SetSize(25 * dxEnhancedGUIScaleMultiplier, 19 * dxEnhancedGUIScaleMultiplier);

	StyleChanged();
}

// ----------------------------------------------------------------------
// StyleChanged()
// ----------------------------------------------------------------------

event StyleChanged()
{
	local ColorTheme theme;
	local Color colButtonFace;

	theme         = player.ThemeManager.GetCurrentMenuColorTheme();
	colButtonFace = theme.GetColorFromName('MenuColor_ButtonFace');

	SetButtonColors(
		colButtonFace, colButtonFace, colButtonFace,
		colButtonFace, colButtonFace, colButtonFace);
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     dxEnhancedGUIScaleMultiplier=1
}
