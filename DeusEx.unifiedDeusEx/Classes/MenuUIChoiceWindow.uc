//=============================================================================
// MenuUIChoiceWindow
//=============================================================================

class MenuUIChoiceWindow extends Window;

var DeusExPlayer player;
var int dxEnhancedGUIScaleMultiplier;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();

	player = DeusExPlayer(DeusExRootWindow(GetRootWindow()).parentPawn);
	dxEnhancedGUIScaleMultiplier = player.dxEnhancedGUIScaleMultiplier;	
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     dxEnhancedGUIScaleMultiplier=1
}
