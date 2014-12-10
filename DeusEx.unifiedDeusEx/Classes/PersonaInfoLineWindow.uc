//=============================================================================
// PersonaInfoLineWindow
//=============================================================================

class PersonaInfoLineWindow expands PersonaBaseWindow;

var Color colLine;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();

	SetHeight(5 * dxEnhancedGUIScaleMultiplier);
}

// ----------------------------------------------------------------------
// DrawWindow()
// ----------------------------------------------------------------------

event DrawWindow(GC gc)
{
	Super.DrawWindow(gc);

	gc.SetStyle(DSTY_Normal);
	gc.SetTileColor(colLine);
	gc.DrawPattern(0, 2 * dxEnhancedGUIScaleMultiplier, width, 1 * dxEnhancedGUIScaleMultiplier, 0, 0, Texture'Solid' );
}

// ----------------------------------------------------------------------
// StyleChanged()
// ----------------------------------------------------------------------

event StyleChanged()
{
	local ColorTheme theme;

	Super.StyleChanged();

	theme = player.ThemeManager.GetCurrentHUDColorTheme();

	// Title colors
	colLine = theme.GetColorFromName('HUDColor_NormalText');
}

defaultproperties
{
}
