//=============================================================================
// MenuScreenRGB_HUDExample
//=============================================================================

class MenuScreenRGB_HUDExample expands Window;

var int dxEnhancedGUIScaleMultiplier;

var DeusExPlayer player;

var PersonaTitleTextWindow  winTextTitle;
var PersonaHeaderTextWindow winTextHeader;
var PersonaNormalTextWindow winTextNormal;
var TextWindow              winTextGoal;
var TextWindow              winTextListNormal;
var TextWindow              winTextListHighlight;
var TextWindow              winTextListFocus;
var TextWindow              winTextEditSelected;
var TextWindow              winTextButtonDisabled;
var TextWindow              winTextButtonNormal;
var TextWindow              winTextButtonFocus;
var TextWindow              winTextButtonPressed;

var Window winBackground;
var Window winBorder;
var Window winButtonNormal;
var Window winButtonPressed;
var Window winListHighlight;
var Window winListFocus;

var Color colBackground;
var Color colBorders;
var Color colListFocus;
var Texture texListFocusBorders[9];

var bool bBorderTranslucent;
var bool bBackgroundTranslucent;

var localized String TitleLabel;
var localized String HeaderLabel;
var localized String TextNormalLabel;
var localized String GoalCompletedLabel;
var localized String ListLabel;
var localized String ListHighlightLabel;
var localized String ListFocusLabel;
var localized String EditSelectedLabel;
var localized String ButtonDisabledLabel;
var localized String ButtonNormalLabel;
var localized String ButtonFocusLabel;
var localized String ButtonPressedLabel;

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

	SetSize(346 * dxEnhancedGUIScaleMultiplier, 153 * dxEnhancedGUIScaleMultiplier);

	CreateControls();
	StyleChanged();
}

// ----------------------------------------------------------------------
// CreateControls()
// ----------------------------------------------------------------------

function CreateControls()
{
	winButtonNormal = NewChild(Class'Window');
	winButtonNormal.SetBackgroundStyle(DSTY_Translucent);
	winButtonNormal.SetBackground(Texture'RGB_HUDButton_Normal');
	winButtonNormal.SetSize(205 * dxEnhancedGUIScaleMultiplier, 16 * dxEnhancedGUIScaleMultiplier);
	winButtonNormal.SetPos(23 * dxEnhancedGUIScaleMultiplier, 131 * dxEnhancedGUIScaleMultiplier);

	winButtonPressed = NewChild(Class'Window');
	winButtonPressed.SetBackgroundStyle(DSTY_Translucent);
	winButtonPressed.SetBackground(Texture'RGB_HUDButton_Pressed');
	winButtonPressed.SetSize(75 * dxEnhancedGUIScaleMultiplier, 16 * dxEnhancedGUIScaleMultiplier);
	winButtonPressed.SetPos(228 * dxEnhancedGUIScaleMultiplier, 131 * dxEnhancedGUIScaleMultiplier);

	winListHighlight = NewChild(Class'Window');
	winListHighlight.SetBackgroundStyle(DSTY_Normal);
	winListHighlight.SetBackground(Texture'Solid');
	winListHighlight.SetSize(290 * dxEnhancedGUIScaleMultiplier, 11 * dxEnhancedGUIScaleMultiplier);
	winListHighlight.SetPos(28 * dxEnhancedGUIScaleMultiplier, 87 * dxEnhancedGUIScaleMultiplier);

	winListFocus = NewChild(Class'Window');
	winListFocus.SetBackgroundStyle(DSTY_Normal);
	winListFocus.SetBackground(Texture'Solid');
	winListFocus.SetSize(290 * dxEnhancedGUIScaleMultiplier, 11 * dxEnhancedGUIScaleMultiplier);
	winListFocus.SetPos(28 * dxEnhancedGUIScaleMultiplier, 99 * dxEnhancedGUIScaleMultiplier);

	// Title
	winTextTitle = PersonaTitleTextWindow(NewChild(Class'PersonaTitleTextWindow'));
	winTextTitle.SetPos(23 * dxEnhancedGUIScaleMultiplier, 7 * dxEnhancedGUIScaleMultiplier);
	winTextTitle.SetText(TitleLabel);

	// Header
	winTextHeader = PersonaHeaderTextWindow(NewChild(Class'PersonaHeaderTextWindow'));
	winTextHeader.SetPos(32 * dxEnhancedGUIScaleMultiplier, 26 * dxEnhancedGUIScaleMultiplier);
	winTextHeader.SetText(HeaderLabel);

	// Normal Text
	winTextNormal = PersonaNormalTextWindow(NewChild(Class'PersonaNormalTextWindow'));
	winTextNormal.SetPos(38 * dxEnhancedGUIScaleMultiplier, 40 * dxEnhancedGUIScaleMultiplier);
	winTextNormal.SetText(TextNormalLabel);

	winTextGoal           = CreateTextWindow( 38 * dxEnhancedGUIScaleMultiplier,  52 * dxEnhancedGUIScaleMultiplier, GoalCompletedLabel, Font'FontMenuSmall');
	winTextListNormal     = CreateTextWindow( 32 * dxEnhancedGUIScaleMultiplier,  75 * dxEnhancedGUIScaleMultiplier, ListLabel, Font'FontMenuSmall');
	winTextListHighlight  = CreateTextWindow( 32 * dxEnhancedGUIScaleMultiplier,  88 * dxEnhancedGUIScaleMultiplier, ListHighlightLabel, Font'FontMenuSmall');
	winTextListFocus      = CreateTextWindow( 32 * dxEnhancedGUIScaleMultiplier, 100 * dxEnhancedGUIScaleMultiplier, ListFocusLabel, Font'FontMenuSmall');
	winTextEditSelected   = CreateTextWindow( 32 * dxEnhancedGUIScaleMultiplier, 113 * dxEnhancedGUIScaleMultiplier, EditSelectedLabel, Font'FontMenuSmall');
	winTextButtonDisabled = CreateTextWindow( 29 * dxEnhancedGUIScaleMultiplier, 134 * dxEnhancedGUIScaleMultiplier, ButtonDisabledLabel, Font'FontMenuHeaders');
	winTextButtonNormal   = CreateTextWindow(104 * dxEnhancedGUIScaleMultiplier, 134 * dxEnhancedGUIScaleMultiplier, ButtonNormalLabel, Font'FontMenuHeaders');
	winTextButtonFocus    = CreateTextWindow(169 * dxEnhancedGUIScaleMultiplier, 134 * dxEnhancedGUIScaleMultiplier, ButtonFocusLabel, Font'FontMenuHeaders');
	winTextButtonPressed  = CreateTextWindow(235 * dxEnhancedGUIScaleMultiplier, 134 * dxEnhancedGUIScaleMultiplier, ButtonPressedLabel, Font'FontMenuHeaders');
}

// ----------------------------------------------------------------------
// DrawWindow()
// ----------------------------------------------------------------------

event DrawWindow(GC gc)
{	
	// Draw the borders then the background
	if (bBorderTranslucent)
		gc.SetStyle(DSTY_Translucent);
	else
		gc.SetStyle(DSTY_Masked);

	gc.SetTileColor(colBorders);
	gc.DrawTexture(  0, 0, 256 * dxEnhancedGUIScaleMultiplier, 153 * dxEnhancedGUIScaleMultiplier, 0, 0, Texture'RGB_HUDSampleBorder_1');
	gc.DrawTexture(256 * dxEnhancedGUIScaleMultiplier, 0,  90 * dxEnhancedGUIScaleMultiplier, 153 * dxEnhancedGUIScaleMultiplier, 0, 0, Texture'RGB_HUDSampleBorder_2');		

	// Background
	if (bBackgroundTranslucent)
		gc.SetStyle(DSTY_Translucent);
	else
		gc.SetStyle(DSTY_Masked);

	gc.SetTileColor(colBackground);
	gc.DrawTexture( 13 * dxEnhancedGUIScaleMultiplier, 2 * dxEnhancedGUIScaleMultiplier, 256 * dxEnhancedGUIScaleMultiplier, 146 * dxEnhancedGUIScaleMultiplier, 0, 0, Texture'RGB_HUDSampleBackground_1');		
	gc.DrawTexture(269 * dxEnhancedGUIScaleMultiplier, 2 * dxEnhancedGUIScaleMultiplier,  62 * dxEnhancedGUIScaleMultiplier, 146 * dxEnhancedGUIScaleMultiplier, 0, 0, Texture'RGB_HUDSampleBackground_2');		
}

// ----------------------------------------------------------------------
// PostDrawWindow()
// ----------------------------------------------------------------------

event PostDrawWindow(GC gc)
{
	// List focus border
	gc.SetTileColor(colListFocus);
	gc.SetStyle(DSTY_Normal);
	gc.DrawBorders(28 * dxEnhancedGUIScaleMultiplier, 99 * dxEnhancedGUIScaleMultiplier, 290 * dxEnhancedGUIScaleMultiplier, 12 * dxEnhancedGUIScaleMultiplier, 0, 0, 0, 0, texListFocusBorders);
}

// ----------------------------------------------------------------------
// CreateTextWindow()
// ----------------------------------------------------------------------

function TextWindow CreateTextWindow(int posX, int posY, String label, Font font)
{
	local TextWindow winText;

	winText = TextWindow(NewChild(Class'TextWindow'));
	winText.SetPos(posX, posY);
	winText.SetText(label);
	winText.SetFont(font);
	winText.SetTextMargins(0, 0);
	winText.SetTextAlignments(HALIGN_Left, VALIGN_Top);

	return winText;
}

// ----------------------------------------------------------------------
// StyleChanged()
// ----------------------------------------------------------------------

event StyleChanged()
{
	local ColorTheme theme;
	local Color colText;
	local Color colCursor;

	theme = player.ThemeManager.GetCurrentHUDColorTheme();

	colBackground = theme.GetColorFromName('HUDColor_Background');
	colBorders    = theme.GetColorFromName('HUDColor_Borders');

	winButtonNormal.SetTileColor(theme.GetColorFromName('HUDColor_ButtonFace'));
	winButtonPressed.SetTileColor(theme.GetColorFromName('HUDColor_ButtonFace'));

	winListHighlight.SetTileColor(theme.GetColorFromName('HUDColor_ListHighlight'));
	winListFocus.SetTileColor(theme.GetColorFromName('HUDColor_ListHighlight'));
	colListFocus = theme.GetColorFromName('HUDColor_ListFocus');

	winTextTitle.SetTextColor(theme.GetColorFromName('HUDColor_TitleText'));
	winTextHeader.SetTextColor(theme.GetColorFromName('HUDColor_HeaderText'));
	winTextNormal.SetTextColor(theme.GetColorFromName('HUDColor_NormalText'));
	
	colText = theme.GetColorFromName('HUDColor_NormalText');
	winTextGoal.SetTextColorRGB(colText.r / 2, colText.g / 2, colText.b / 2);

	winTextListNormal.SetTextColor(theme.GetColorFromName('HUDColor_ListText'));
	winTextListHighlight.SetTextColor(theme.GetColorFromName('HUDColor_ListTextHighlight'));
	winTextListFocus.SetTextColor(theme.GetColorFromName('HUDColor_ListTextHighlight'));
	winTextEditSelected.SetTextColor(theme.GetColorFromName('HUDColor_ListText'));
	winTextButtonDisabled.SetTextColor(theme.GetColorFromName('HUDColor_ButtonTextDisabled'));
	winTextButtonNormal.SetTextColor(theme.GetColorFromName('HUDColor_ButtonTextNormal'));
	winTextButtonFocus.SetTextColor(theme.GetColorFromName('HUDColor_ButtonTextFocus'));
	winTextButtonPressed.SetTextColor(theme.GetColorFromName('HUDColor_ButtonTextNormal'));

	// Cursor!
	colCursor = theme.GetColorFromName('HUDColor_Cursor');
	SetDefaultCursor(Texture'DeusExCursor2', Texture'DeusExCursor2_Shadow', 32 * dxEnhancedGUIScaleMultiplier, 32 * dxEnhancedGUIScaleMultiplier, colCursor);

	bBorderTranslucent     = player.GetHUDBorderTranslucency();
	bBackgroundTranslucent = player.GetHUDBackgroundTranslucency();
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     dxEnhancedGUIScaleMultiplier=1
     texListFocusBorders(0)=Texture'DeusExUI.UserInterface.RGB_ListSelectionBorder'
     texListFocusBorders(1)=Texture'DeusExUI.UserInterface.RGB_ListSelectionBorder'
     texListFocusBorders(2)=Texture'DeusExUI.UserInterface.RGB_ListSelectionBorder'
     texListFocusBorders(3)=Texture'DeusExUI.UserInterface.RGB_ListSelectionBorder'
     texListFocusBorders(4)=Texture'DeusExUI.UserInterface.RGB_ListSelectionBorder'
     texListFocusBorders(5)=Texture'DeusExUI.UserInterface.RGB_ListSelectionBorder'
     texListFocusBorders(6)=Texture'DeusExUI.UserInterface.RGB_ListSelectionBorder'
     texListFocusBorders(7)=Texture'DeusExUI.UserInterface.RGB_ListSelectionBorder'
     TitleLabel="Title"
     HeaderLabel="Header"
     TextNormalLabel="Normal"
     GoalCompletedLabel="Completed Goal"
     ListLabel="List Item"
     ListHighlightLabel="List Highlight"
     ListFocusLabel="List Focus"
     EditSelectedLabel="Edit Text"
     ButtonDisabledLabel="Disabled"
     ButtonNormalLabel="Normal"
     ButtonFocusLabel="Focus"
     ButtonPressedLabel="Pressed"
}
