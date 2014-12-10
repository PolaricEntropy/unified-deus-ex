//=============================================================================
// PersonaInfoItemWindow
//=============================================================================
class PersonaInfoItemWindow expands AlignWindow;

var int dxEnhancedGUIScaleMultiplier;

var DeusExPlayer player;
var TextWindow winLabel;
var TextWindow winText;
var Font fontText;
var Font fontTextHighlight;
var bool bHighlight;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();

	// Get a pointer to the player
	player = DeusExPlayer(GetPlayerPawn());
	dxEnhancedGUIScaleMultiplier = player.dxEnhancedGUIScaleMultiplier;
	
	// Defaults for tile window
	SetChildVAlignment(VALIGN_Top);
	SetChildSpacing(10 * dxEnhancedGUIScaleMultiplier);

	winLabel = TextWindow(NewChild(Class'TextWindow'));
	winLabel.SetFont(fontText);
	winLabel.SetTextAlignments(HALIGN_Right, VALIGN_Top);
	winLabel.SetTextMargins(0, 0);
	winLabel.SetWidth(70 * dxEnhancedGUIScaleMultiplier);

	winText = TextWindow(NewChild(Class'TextWindow'));
	winText.SetTextAlignments(HALIGN_Left, VALIGN_Top);
	winText.SetFont(fontText);
	winText.SetTextMargins(0, 0);
	winText.SetWordWrap(True);

	StyleChanged();
}

// ----------------------------------------------------------------------
// SetItemInfo()
// ----------------------------------------------------------------------

function SetItemInfo(coerce String newLabel, coerce String newText, optional bool bNewHighlight)
{
	winLabel.SetText(newLabel);
	winText.SetText(newText);
	SetHighlight(bNewHighlight);
}

// ----------------------------------------------------------------------
// SetItemText()
// ----------------------------------------------------------------------

function SetItemText(coerce string newText)
{
	winText.SetText(newText);
}

// ----------------------------------------------------------------------
// SetHighlight()
// ----------------------------------------------------------------------

function SetHighlight(bool bNewHighlight)
{
	bHighlight = bNewHighlight;

	if (bHighlight)
		winText.SetFont(fontTextHighlight);
	else
		winText.SetFont(fontText);

	StyleChanged();
}

// ----------------------------------------------------------------------
// StyleChanged()
// ----------------------------------------------------------------------

event StyleChanged()
{
	local ColorTheme theme;

	theme = player.ThemeManager.GetCurrentHUDColorTheme();

	winLabel.SetTextColor(theme.GetColorFromName('HUDColor_NormalText'));

	if (bHighlight)
		winText.SetTextColor(theme.GetColorFromName('HUDColor_HeaderText'));
	else
		winText.SetTextColor(theme.GetColorFromName('HUDColor_NormalText'));
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     dxEnhancedGUIScaleMultiplier=1
     fontText=Font'DeusExUI.FontMenuSmall'
     fontTextHighlight=Font'DeusExUI.FontMenuHeaders'
}
