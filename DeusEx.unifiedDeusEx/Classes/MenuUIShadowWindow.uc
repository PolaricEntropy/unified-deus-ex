//=============================================================================
// MenuUIShadowWindow
//=============================================================================

class MenuUIShadowWindow extends Window;

var DeusExPlayer player;
var int dxEnhancedGUIScaleMultiplier;

var int shadowWidth;
var int shadowHeight;
var int shadowOffsetX;
var int shadowOffsetY;

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

	shadowWidth *= dxEnhancedGUIScaleMultiplier;
	shadowHeight *= dxEnhancedGUIScaleMultiplier;
	shadowOffsetX *= dxEnhancedGUIScaleMultiplier;
	shadowOffsetY *= dxEnhancedGUIScaleMultiplier;

	SetSize(shadowWidth, shadowHeight);
}

defaultproperties
{
     dxEnhancedGUIScaleMultiplier=1
}
