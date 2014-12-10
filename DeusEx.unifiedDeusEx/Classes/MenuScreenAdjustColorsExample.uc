//=============================================================================
// MenuScreenAdjustColorsExample
//=============================================================================

class MenuScreenAdjustColorsExample expands Window;

var int dxEnhancedGUIScaleMultiplier;

var DeusExPlayer player;

var Color colBackground;      
var Color colBorders;         
var Color colTitleText;       
var Color colHeaderText;     
var Color colNormalText;      
var Color colButtonTextNormal;
var Color colButtonTextFocus; 
var Color colButtonFace;

var Bool  bBackgroundTranslucent;
var Bool  bBordersTranslucent;
var Bool  bBordersVisible;

var localized string TitleBarLabel;
var localized string TextHeaderLabel;
var localized string TextNormalLabel;
var localized string ButtonPressedLabel;
var localized string ButtonNormalLabel;

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

	SetSize(207 * dxEnhancedGUIScaleMultiplier, 135 * dxEnhancedGUIScaleMultiplier);

	StyleChanged();
}

// ----------------------------------------------------------------------
// DrawWindow()
// ----------------------------------------------------------------------

event DrawWindow(GC gc)
{	
	// Draw Background
	if (bBackgroundTranslucent)
		gc.SetStyle(DSTY_Translucent);
	else
		gc.SetStyle(DSTY_Masked);

	gc.SetTileColor(colBackground);
	gc.DrawTexture(0, 0, 256 * dxEnhancedGUIScaleMultiplier, 135 * dxEnhancedGUIScaleMultiplier, 0, 0, Texture'MenuColorHUDBackground');

	// Draw Borders
	if (bBordersVisible)
	{
		if (bBordersTranslucent)
			gc.SetStyle(DSTY_Translucent);
		else
			gc.SetStyle(DSTY_Masked);

		gc.SetTileColor(colBorders);
		gc.DrawTexture(0, 0, 256 * dxEnhancedGUIScaleMultiplier, 135 * dxEnhancedGUIScaleMultiplier, 0, 0, Texture'MenuColorHUDBorders');
	}

	// Draw Text
	gc.SetTextColor(colTitleText);
	gc.SetFont(Font'FontMenuHeaders');
	gc.DrawText(23 * dxEnhancedGUIScaleMultiplier, 19 * dxEnhancedGUIScaleMultiplier, 90 * dxEnhancedGUIScaleMultiplier, 11 * dxEnhancedGUIScaleMultiplier, TitleBarLabel);

	gc.SetTextColor(colHeaderText);
	gc.SetFont(Font'FontMenuHeaders');
	gc.DrawText(27 * dxEnhancedGUIScaleMultiplier, 37 * dxEnhancedGUIScaleMultiplier, 90 * dxEnhancedGUIScaleMultiplier, 11 * dxEnhancedGUIScaleMultiplier, TextHeaderLabel);

	gc.SetTextColor(colNormalText);
	gc.SetFont(Font'FontMenuSmall');
	gc.DrawText(27 * dxEnhancedGUIScaleMultiplier, 56 * dxEnhancedGUIScaleMultiplier, 90 * dxEnhancedGUIScaleMultiplier, 11 * dxEnhancedGUIScaleMultiplier, TextNormalLabel);

	gc.SetTextColor(colButtonTextNormal);
	gc.SetFont(Font'FontMenuHeaders');
	gc.DrawText(28 * dxEnhancedGUIScaleMultiplier, 110 * dxEnhancedGUIScaleMultiplier, 54 * dxEnhancedGUIScaleMultiplier, 10 * dxEnhancedGUIScaleMultiplier, ButtonPressedLabel);

	gc.SetTextColor(colButtonTextFocus);
	gc.SetFont(Font'FontMenuHeaders');
	gc.DrawText(94 * dxEnhancedGUIScaleMultiplier, 110 * dxEnhancedGUIScaleMultiplier, 54 * dxEnhancedGUIScaleMultiplier, 10 * dxEnhancedGUIScaleMultiplier, ButtonNormalLabel);
}

// ----------------------------------------------------------------------
// StyleChanged()
// ----------------------------------------------------------------------

event StyleChanged()
{
	local ColorTheme theme;

	theme = player.ThemeManager.GetCurrentHUDColorTheme();

	// Title colors
	colBackground       = theme.GetColorFromName('HUDColor_Background');
	colBorders          = theme.GetColorFromName('HUDColor_Borders');
	colTitleText        = theme.GetColorFromName('HUDColor_TitleText');
	colHeaderText       = theme.GetColorFromName('HUDColor_HeaderText');
	colNormalText       = theme.GetColorFromName('HUDColor_NormalText');
	colButtonTextNormal = theme.GetColorFromName('HUDColor_ButtonTextNormal');
	colButtonTextFocus  = theme.GetColorFromName('HUDColor_ButtonTextFocus');
	colButtonFace       = theme.GetColorFromName('HUDColor_ButtonFace');

	bBackgroundTranslucent = player.GetHUDBackgroundTranslucency();
	bBordersTranslucent    = player.GetHUDBorderTranslucency();
	bBordersVisible        = player.GetHUDBordersVisible();
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     dxEnhancedGUIScaleMultiplier=1
     TitleBarLabel="Title Bar"
     TextHeaderLabel="Sample Text"
     TextNormalLabel="Sample Text"
     ButtonPressedLabel="Pressed"
     ButtonNormalLabel="Normal"
}
