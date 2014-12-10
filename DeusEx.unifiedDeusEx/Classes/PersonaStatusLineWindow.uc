//=============================================================================
// PersonaStatusLineWindow
//=============================================================================

class PersonaStatusLineWindow extends TextWindow;

var int dxEnhancedGUIScaleMultiplier;

var DeusExPlayer player;
var Font         fontText;
var Float        logDuration;
var Float        logTimer;

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
	
	SetFont(fontText);
	SetWidth(238 * dxEnhancedGUIScaleMultiplier);
	SetTextMargins(2 * dxEnhancedGUIScaleMultiplier, 1 * dxEnhancedGUIScaleMultiplier);
	SetTextAlignments(HALIGN_Left, VALIGN_Top);

	StyleChanged();
}

// ----------------------------------------------------------------------
// Tick()
// ----------------------------------------------------------------------

function Tick(float deltaTime)
{
	logTimer += deltaTime;
	
	if (logTimer > logDuration)
	{
		SetText("");
		bTickEnabled = False;
	}
}

// ----------------------------------------------------------------------
// StyleChanged()
// ----------------------------------------------------------------------

event StyleChanged()
{
	local ColorTheme theme;
	local Color colText;

	theme = player.ThemeManager.GetCurrentHUDColorTheme();

	// Title colors
	colText = theme.GetColorFromName('HUDColor_ListText');

	SetTextColor(colText);
}

// ----------------------------------------------------------------------
// AddText()
// ----------------------------------------------------------------------

function AddText(String newText)
{
	SetText(newText);
	logTimer = 0.0;
	bTickEnabled = True;
}

// ----------------------------------------------------------------------
// ClearText()
// ----------------------------------------------------------------------

function ClearText()
{
	SetText("");
	bTickEnabled = False;
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     dxEnhancedGUIScaleMultiplier=1
     fontText=Font'DeusExUI.FontMenuSmall'
     logDuration=5.000000
}
