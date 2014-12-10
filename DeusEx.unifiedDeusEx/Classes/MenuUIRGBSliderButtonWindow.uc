//=============================================================================
// MenuUIRGBSliderButtonWindow
//=============================================================================

class MenuUIRGBSliderButtonWindow extends Window;

var int dxEnhancedGUIScaleMultiplier;

var DeusExPlayer player;

var ScaleWindow            winSlider;
var ScaleManagerWindow     winScaleManager;
var MenuUIEditWindow       editScaleText;
var MenuUIInfoButtonWindow winEditBorder;

var Texture defaultScaleTexture;
var Texture defaultThumbTexture;

var int defaultWidth;
var int defaultHeight;

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

    DefaultWidth = 230 * dxEnhancedGUIScaleMultiplier;
    defaultHeight = 21 * dxEnhancedGUIScaleMultiplier;
	SetSize(defaultWidth, defaultHeight);

	// Create the Scale Manager Window
	winScaleManager = ScaleManagerWindow(NewChild(Class'ScaleManagerWindow'));
	winScaleManager.SetSize(177 * dxEnhancedGUIScaleMultiplier, 21 * dxEnhancedGUIScaleMultiplier);
	winScaleManager.SetMarginSpacing(20 * dxEnhancedGUIScaleMultiplier);

	// Create the slider window 
	winSlider = ScaleWindow(winScaleManager.NewChild(Class'ScaleWindow'));
	winSlider.SetScaleOrientation(ORIENT_Horizontal);
	winSlider.SetThumbSpan(0);
	winSlider.SetScaleTexture(defaultScaleTexture, 177 * dxEnhancedGUIScaleMultiplier, 21 * dxEnhancedGUIScaleMultiplier, 
							  8 * dxEnhancedGUIScaleMultiplier, 8 * dxEnhancedGUIScaleMultiplier);
	winSlider.SetThumbTexture(defaultThumbTexture, 9 * dxEnhancedGUIScaleMultiplier, 
							  15 * dxEnhancedGUIScaleMultiplier);

	winEditBorder = MenuUIInfoButtonWindow(NewChild(Class'MenuUIInfoButtonWindow'));
	winEditBorder.SetWidth(43 * dxEnhancedGUIScaleMultiplier);
	winEditBorder.SetPos(185 * dxEnhancedGUIScaleMultiplier, 1 * dxEnhancedGUIScaleMultiplier);
	winEditBorder.SetSensitivity(False);

	// Create the text window
	editScaleText = MenuUIEditWindow(NewChild(Class'MenuUIEditWindow'));
	editScaleText.SetSize(39 * dxEnhancedGUIScaleMultiplier, 10 * dxEnhancedGUIScaleMultiplier);
	editScaleText.SetPos(187 * dxEnhancedGUIScaleMultiplier, 6 * dxEnhancedGUIScaleMultiplier);
	editScaleText.SetMaxSize(3 * dxEnhancedGUIScaleMultiplier);

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
// ScalePositionChanged() 
// ----------------------------------------------------------------------

event bool ScalePositionChanged(Window scale, int newTickPosition,
                                float newValue, bool bFinal)
{
	editScaleText.SetText(winSlider.GetValueString());
	editScaleText.SetInsertionPoint(Len(editScaleText.GetText()));
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
     DefaultWidth=230
     defaultHeight=21
}
