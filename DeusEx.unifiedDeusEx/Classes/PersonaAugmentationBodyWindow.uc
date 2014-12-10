//=============================================================================
// PersonaAugmentationBodyWindow
//=============================================================================

class PersonaAugmentationBodyWindow extends Window;

var DeusExPlayer player;
var int dxEnhancedGUIScaleMultiplier;

var Texture bodyTextures[2];

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();
	
	player = DeusExPlayer(GetRootWindow().parentPawn);
	dxEnhancedGUIScaleMultiplier = player.dxEnhancedGUIScaleMultiplier;

	SetSize(174 * dxEnhancedGUIScaleMultiplier, 359 * dxEnhancedGUIScaleMultiplier);
}

// ----------------------------------------------------------------------
// DrawWindow()
// ----------------------------------------------------------------------

event DrawWindow(GC gc)
{	
	// Draw window background
	gc.SetStyle(DSTY_Masked);

	gc.DrawTexture(0, 0, 174 * dxEnhancedGUIScaleMultiplier, 256 * dxEnhancedGUIScaleMultiplier, 0, 0, bodyTextures[0]);
	gc.DrawTexture(0,	 256 * dxEnhancedGUIScaleMultiplier, 174 * dxEnhancedGUIScaleMultiplier, 103 * dxEnhancedGUIScaleMultiplier, 0, 0, bodyTextures[1]);
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     dxEnhancedGUIScaleMultiplier=1
     bodyTextures(0)=Texture'DeusExUI.UserInterface.AugmentationsBody_1'
     bodyTextures(1)=Texture'DeusExUI.UserInterface.AugmentationsBody_2'
}
