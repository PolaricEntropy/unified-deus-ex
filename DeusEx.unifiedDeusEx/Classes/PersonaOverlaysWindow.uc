//=============================================================================
// PersonaOverlaysWindow
//=============================================================================

class PersonaOverlaysWindow extends PersonaBaseWindow
	abstract;

var int defaultSizeX;
var int defaultSizeY;

var Texture overlayTextures[2];

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();
	
	SetSize(defaultSizeX, defaultSizeY);
}

function ScaleDimensions() {
	defaultSizeX = defaultSizeX * dxEnhancedGUIScaleMultiplier;
	defaultSizeY = defaultSizeY * dxEnhancedGUIScaleMultiplier;
}

// ----------------------------------------------------------------------
// DrawBackground()
// ----------------------------------------------------------------------

event DrawBackground(GC gc)
{	
	// Draw window background
	gc.SetStyle(backgroundDrawStyle);
	gc.SetTileColor(colBackground);
	gc.DrawTexture(0,   0, defaultSizeX, 256 * dxEnhancedGUIScaleMultiplier, 0, 0, overlayTextures[0]);
	gc.DrawTexture(0, 256 * dxEnhancedGUIScaleMultiplier, defaultSizeX, defaultSizeY - (256 * dxEnhancedGUIScaleMultiplier), 0, 0, overlayTextures[1]);
	
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
}
