//=============================================================================
// PersonaBaseWindow
//=============================================================================
class PersonaBaseWindow extends Window;

var int dxEnhancedGUIScaleMultiplier;

var DeusExRootWindow root;
var DeusExPlayer player;

// Border and Background Translucency
var bool bDrawBorder;
var EDrawStyle borderDrawStyle;
var EDrawStyle backgroundDrawStyle;

// Default Colors
var Color colBackground;
var Color colBorder;
var Color colHeaderText;
var Color colText;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();

	// Get a pointer to the root window
	root = DeusExRootWindow(GetRootWindow());
	
	// Get a pointer to the player
	player = DeusExPlayer(root.parentPawn);
	ScaleDimensions();

	StyleChanged();
}

function ScaleDimensions() {
	dxEnhancedGUIScaleMultiplier = player.dxEnhancedGUIScaleMultiplier;
}

// ----------------------------------------------------------------------
// DrawWindow()
// ----------------------------------------------------------------------

event DrawWindow(GC gc)
{
	// First draw the background then the border
	DrawBackground(gc);

	// Don't call the DrawBorder routines if 
	// they are disabled
	if (bDrawBorder)
		DrawBorder(gc);
}

// ----------------------------------------------------------------------
// DrawBackground()
// ----------------------------------------------------------------------

function DrawBackground(GC gc)
{
}

// ----------------------------------------------------------------------
// DrawBorder()
// ----------------------------------------------------------------------

function DrawBorder(GC gc)
{
}

// ----------------------------------------------------------------------
// StyleChanged()
// ----------------------------------------------------------------------

event StyleChanged()
{
	local ColorTheme theme;

	theme = player.ThemeManager.GetCurrentHUDColorTheme();

	colBackground = theme.GetColorFromName('HUDColor_Background');
	colBorder     = theme.GetColorFromName('HUDColor_Borders');
	colText       = theme.GetColorFromName('HUDColor_NormalText');
	colHeaderText = theme.GetColorFromName('HUDColor_HeaderText');

	bDrawBorder            = player.GetHUDBordersVisible();

	if (player.GetHUDBorderTranslucency())
		borderDrawStyle = DSTY_Translucent;
	else
		borderDrawStyle = DSTY_Masked;

	if (player.GetHUDBackgroundTranslucency())
		backgroundDrawStyle = DSTY_Translucent;
	else
		backgroundDrawStyle = DSTY_Masked;
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     dxEnhancedGUIScaleMultiplier=1
     bDrawBorder=True
}
