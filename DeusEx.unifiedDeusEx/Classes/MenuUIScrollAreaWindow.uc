//=============================================================================
// MenuUIScrollAreaWindow
//=============================================================================

class MenuUIScrollAreaWindow extends ScrollAreaWindow;

var int dxEnhancedGUIScaleMultiplier;

var DeusExPlayer player;

var Color colButtonFace;

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
	
	EnableScrolling(False, True);
	SetAreaMargins(0, 0);
	SetScrollbarDistance(0);

	vScale.SetThumbCaps(
		Texture'MenuVScrollThumb_Top', 
		Texture'MenuVScrollThumb_Bottom', 
		9 * dxEnhancedGUIScaleMultiplier, 6 * dxEnhancedGUIScaleMultiplier, 
		9 * dxEnhancedGUIScaleMultiplier, 6 * dxEnhancedGUIScaleMultiplier);

	vScale.SetThumbTexture(Texture'MenuVScrollThumb_Center', 
						   9 * dxEnhancedGUIScaleMultiplier, 2 * dxEnhancedGUIScaleMultiplier);
	vScale.SetScaleTexture(Texture'MenuVScrollScale', 15 * dxEnhancedGUIScaleMultiplier, 
						   2 * dxEnhancedGUIScaleMultiplier, 0, 0);
	vScale.SetScaleMargins(0, 0);
	vScale.SetThumbStyle(DSTY_Masked);
	vScale.SetScaleSounds(Sound'Menu_Press', Sound'Menu_Press', Sound'Menu_Slider');
	vScale.SetSoundVolume(0.25);

	upButton.SetSize(15 * dxEnhancedGUIScaleMultiplier, 15 * dxEnhancedGUIScaleMultiplier);
	upButton.SetBackgroundStyle(DSTY_Masked);
	upButton.SetButtonTextures(
		Texture'MenuVScrollUpButton_Normal', Texture'MenuVScrollUpButton_Pressed',
		Texture'MenuVScrollUpButton_Normal', Texture'MenuVScrollUpButton_Pressed',
		Texture'MenuVScrollUpButton_Normal', Texture'MenuVScrollUpButton_Pressed');
	upButton.SetButtonSounds(None, Sound'Menu_Press');
	upButton.SetFocusSounds(Sound'Menu_Focus');
	upButton.SetSoundVolume(0.25);


	downButton.SetSize(15 * dxEnhancedGUIScaleMultiplier, 15 * dxEnhancedGUIScaleMultiplier);
	downButton.SetBackgroundStyle(DSTY_Masked);
	downButton.SetButtonTextures(
		Texture'MenuVScrollDownButton_Normal', Texture'MenuVScrollDownButton_Pressed',
		Texture'MenuVScrollDownButton_Normal', Texture'MenuVScrollDownButton_Pressed',
		Texture'MenuVScrollDownButton_Normal', Texture'MenuVScrollDownButton_Pressed');
	downButton.SetButtonSounds(None, Sound'Menu_Press');
	downButton.SetFocusSounds(Sound'Menu_Focus');
	downButton.SetSoundVolume(0.25);

	StyleChanged();
}

// ----------------------------------------------------------------------
// StyleChanged()
// ----------------------------------------------------------------------

event StyleChanged()
{
	local ColorTheme theme;

	theme = player.ThemeManager.GetCurrentMenuColorTheme();

	// Title colors
	colButtonFace = theme.GetColorFromName('MenuColor_ButtonFace');

	upButton.SetButtonColors(colButtonFace, colButtonFace, colButtonFace,
                             colButtonFace, colButtonFace, colButtonFace);

	downButton.SetButtonColors(colButtonFace, colButtonFace, colButtonFace,
	                           colButtonFace, colButtonFace, colButtonFace);

	vScale.SetScaleColor(colButtonFace);
	vScale.SetThumbColor(colButtonFace);
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     dxEnhancedGUIScaleMultiplier=1
     colButtonFace=(R=255,G=255,B=255)
}
