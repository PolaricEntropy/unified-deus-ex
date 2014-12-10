//=============================================================================
// MenuUISliderButtonWindow
//=============================================================================

class MenuUISliderButtonWindow extends Window;

var int dxEnhancedGUIScaleMultiplier;

var DeusExPlayer player;

var ScaleWindow winSlider;
var ScaleManagerWindow winScaleManager;
var MenuUIInfoButtonWindow winScaleText;

var Texture defaultScaleTexture;
var Texture defaultThumbTexture;

var int defaultWidth;
var int defaultHeight;
var int defaultScaleWidth;
var Bool bUseScaleText;

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

    DefaultWidth = DefaultWidth * dxEnhancedGUIScaleMultiplier;
    defaultHeight = defaultHeight * dxEnhancedGUIScaleMultiplier;
    defaultScaleWidth = defaultScaleWidth * dxEnhancedGUIScaleMultiplier;

	SetSize(defaultWidth, defaultHeight);

	// Create the Scale Manager Window
	winScaleManager = ScaleManagerWindow(NewChild(Class'ScaleManagerWindow'));
	winScaleManager.SetSize(defaultScaleWidth, 21 * dxEnhancedGUIScaleMultiplier);
	winScaleManager.SetMarginSpacing(20 * dxEnhancedGUIScaleMultiplier);

	// Create the slider window 
	winSlider = ScaleWindow(winScaleManager.NewChild(Class'ScaleWindow'));
	winSlider.SetScaleOrientation(ORIENT_Horizontal);
	winSlider.SetThumbSpan(0);
	winSlider.SetScaleTexture(defaultScaleTexture, defaultScaleWidth, 
							  21 * dxEnhancedGUIScaleMultiplier, 8 * dxEnhancedGUIScaleMultiplier, 
							   8 * dxEnhancedGUIScaleMultiplier);
	winSlider.SetThumbTexture(defaultThumbTexture, 9 * dxEnhancedGUIScaleMultiplier, 
							  15 * dxEnhancedGUIScaleMultiplier);
	winSlider.SetScaleSounds(Sound'Menu_Press', None, Sound'Menu_Slider');
	winSlider.SetSoundVolume(0.25);

	// Create the text window
	if (bUseScaleText)
	{
		winScaleText = MenuUIInfoButtonWindow(NewChild(Class'MenuUIInfoButtonWindow'));
		winScaleText.SetSelectability(False);
		winScaleText.SetWidth(60 * dxEnhancedGUIScaleMultiplier);
		winScaleText.SetPos(184 * dxEnhancedGUIScaleMultiplier, 1 * dxEnhancedGUIScaleMultiplier);
	}

	// Tell the Scale Manager wazzup.
	winScaleManager.SetScale(winSlider);

	StyleChanged();
}

// ----------------------------------------------------------------------
// SetTicks()
// ----------------------------------------------------------------------

function SetTicks( int numTicks, int startValue, int endValue)
{
	winSlider.SetValueRange(startValue, endValue);
	winSlider.SetNumTicks(numTicks);
}

// ----------------------------------------------------------------------
// ScalePositionChanged() : Called when an ancestor scale window's
//                          position is moved
// ----------------------------------------------------------------------

event bool ScalePositionChanged(Window scale, int newTickPosition,
                                float newValue, bool bFinal)
{
	if (winScaleText != None)
		winScaleText.SetButtonText(winSlider.GetValueString());

	return False;
}

// ----------------------------------------------------------------------
// StyleChanged()
// ----------------------------------------------------------------------

event StyleChanged()
{
	local ColorTheme theme;
	local Color colButtonFace;

	theme = player.ThemeManager.GetCurrentMenuColorTheme();

	// Title colors
	colButtonFace = theme.GetColorFromName('MenuColor_ButtonFace');

	winSlider.SetThumbColor(colButtonFace);
	winSlider.SetScaleColor(colButtonFace);
	winSlider.SetTickColor(colButtonFace);
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     dxEnhancedGUIScaleMultiplier=1
     defaultScaleTexture=Texture'DeusExUI.UserInterface.MenuSliderBar'
     defaultThumbTexture=Texture'DeusExUI.UserInterface.MenuSlider'
     DefaultWidth=243
     defaultHeight=21
     defaultScaleWidth=177
     bUseScaleText=True
}
