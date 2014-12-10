//=============================================================================
// MenuScreenRGB_MenuExample
//=============================================================================

class MenuScreenRGB_MenuExample expands Window;

var int dxEnhancedGUIScaleMultiplier;

var DeusExPlayer player;

var Window winTitle;
var Window winTitleBubble;
var Window winActionButtonDisabled;
var Window winActionButtonNormal;
var Window winActionButtonFocus;
var Window winActionButtonPressed;
var Window winMenuButtonDisabled;
var Window winMenuButtonNormal;
var Window winMenuButtonFocus;
var Window winMenuButtonPressed;
var Window winSmallButtonNormal;
var Window winSmallButtonPressed;
var Window winScroll;
var Window winListFocus;

var TextWindow winTextButtonMenuDisabled;
var TextWindow winTextButtonMenuNormal;
var TextWindow winTextButtonMenuFocus;
var TextWindow winTextButtonMenuPressed;
var TextWindow winTextButtonSmallNormal;
var TextWindow winTextButtonSmallPressed;
var TextWindow winTextButtonActionDisabled;
var TextWindow winTextButtonActionNormal;
var TextWindow winTextButtonActionFocus;
var TextWindow winTextButtonActionPressed;
var TextWindow winTextList;
var TextWindow winTextListFocus;
var TextWindow winTextEdit;
var TextWindow winTextTitle;

var Color   colBackground;
var Color   colListFocus;
var Font    fontMenuButtonText;
var Texture texListFocusBorders[9];

var bool bBackgroundTranslucent;

var localized String ButtonMenuDisabledLabel;
var localized String ButtonMenuNormalLabel;
var localized String ButtonMenuFocusLabel;
var localized String ButtonMenuPressedLabel;
var localized String ButtonSmallPressedLabel;
var localized String ButtonSmallNormalLabel;
var localized String ButtonActionDisabledLabel;
var localized String ButtonActionNormalLabel;
var localized String ButtonActionFocusLabel;
var localized String ButtonActionPressedLabel;
var localized String ListNormalLabel;
var localized String ListFocusLabel;
var localized String EditLabel;
var localized String TitleLabel;

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

	SetSize(423 * dxEnhancedGUIScaleMultiplier, 178 * dxEnhancedGUIScaleMultiplier);

	CreateControls();
	StyleChanged();
}

// ----------------------------------------------------------------------
// CreateControls()
// ----------------------------------------------------------------------

function CreateControls()
{
	local Window winIcon;

	// Load the menu font from the DXFonts package
	fontMenuButtonText = Font(DynamicLoadObject("DXFonts.MainMenuTrueType", Class'Font'));

	// Title bar graphic
	winTitle = NewChild(Class'Window');
	winTitle.SetPos(0, 0);
	winTitle.SetSize(195 * dxEnhancedGUIScaleMultiplier, 75 * dxEnhancedGUIScaleMultiplier);
	winTitle.SetBackgroundStyle(DSTY_Masked);
	winTitle.SetBackground(Texture'RGB_MenuTitleBarBackground');

	// Title bar bubble
	winTitleBubble = NewChild(Class'Window');
	winTitleBubble.SetPos(3 * dxEnhancedGUIScaleMultiplier, 2 * dxEnhancedGUIScaleMultiplier);
	winTitleBubble.SetSize(168 * dxEnhancedGUIScaleMultiplier, 18 * dxEnhancedGUIScaleMultiplier);
	winTitleBubble.SetBackgroundStyle(DSTY_Masked);
	winTitleBubble.SetBackground(Texture'RGB_MenuTitleBar');

	// Title Text
	winTextTitle = CreateActionText(32 * dxEnhancedGUIScaleMultiplier, 5 * dxEnhancedGUIScaleMultiplier, TitleLabel);

	// Title bar icon
	winIcon = NewChild(Class'Window');
	winIcon.SetPos(12 * dxEnhancedGUIScaleMultiplier, 3 * dxEnhancedGUIScaleMultiplier);
	winIcon.SetSize(16 * dxEnhancedGUIScaleMultiplier, 16 * dxEnhancedGUIScaleMultiplier);
	winIcon.SetBackground(Texture'MenuIcon_DeusEx');

	// List focus
	winListFocus = NewChild(Class'Window');
	winListFocus.SetBackgroundStyle(DSTY_Normal);
	winListFocus.SetBackground(Texture'Solid');
	winListFocus.SetSize(148 * dxEnhancedGUIScaleMultiplier, 11 * dxEnhancedGUIScaleMultiplier);
	winListFocus.SetPos(252 * dxEnhancedGUIScaleMultiplier, 64 * dxEnhancedGUIScaleMultiplier);

	// List Text
	winTextList      = CreateListText(255 * dxEnhancedGUIScaleMultiplier, 53 * dxEnhancedGUIScaleMultiplier, ListNormalLabel);
	winTextListFocus = CreateListText(255 * dxEnhancedGUIScaleMultiplier, 65 * dxEnhancedGUIScaleMultiplier, ListFocusLabel);
	winTextEdit      = CreateListText(255 * dxEnhancedGUIScaleMultiplier, 77 * dxEnhancedGUIScaleMultiplier, EditLabel);

	// Scroll bar graphics
	winScroll = NewChild(Class'Window');
	winScroll.SetPos(401 * dxEnhancedGUIScaleMultiplier, 50 * dxEnhancedGUIScaleMultiplier);
	winScroll.SetSize(15 * dxEnhancedGUIScaleMultiplier, 93 * dxEnhancedGUIScaleMultiplier);
	winScroll.SetBackgroundStyle(DSTY_Masked);
	winScroll.SetBackground(Texture'RGB_MenuScrollBar');

	// Button Menu Backgrounds
	winMenuButtonDisabled = CreateMenuButton(17 * dxEnhancedGUIScaleMultiplier,  31 * dxEnhancedGUIScaleMultiplier, Texture'RGB_MenuButtonLarge_Normal');
	winMenuButtonNormal   = CreateMenuButton(17 * dxEnhancedGUIScaleMultiplier,  61 * dxEnhancedGUIScaleMultiplier, Texture'RGB_MenuButtonLarge_Normal');
	winMenuButtonFocus    = CreateMenuButton(17 * dxEnhancedGUIScaleMultiplier,  91 * dxEnhancedGUIScaleMultiplier, Texture'RGB_MenuButtonLarge_Focus');
	winMenuButtonPressed  = CreateMenuButton(17 * dxEnhancedGUIScaleMultiplier, 121 * dxEnhancedGUIScaleMultiplier, Texture'RGB_MenuButtonLarge_Pressed');

	// Button Menu Text
	winTextButtonMenuDisabled = CreateMenuText(32 * dxEnhancedGUIScaleMultiplier,  32 * dxEnhancedGUIScaleMultiplier, ButtonMenuDisabledLabel);
	winTextButtonMenuNormal   = CreateMenuText(32 * dxEnhancedGUIScaleMultiplier,  62 * dxEnhancedGUIScaleMultiplier, ButtonMenuNormalLabel);
	winTextButtonMenuFocus    = CreateMenuText(32 * dxEnhancedGUIScaleMultiplier,  92 * dxEnhancedGUIScaleMultiplier, ButtonMenuFocusLabel);
	winTextButtonMenuPressed  = CreateMenuText(32 * dxEnhancedGUIScaleMultiplier, 123 * dxEnhancedGUIScaleMultiplier, ButtonMenuPressedLabel);

	// Action Buttons
	winActionButtonDisabled = CreateActionButton( 11 * dxEnhancedGUIScaleMultiplier, 158 * dxEnhancedGUIScaleMultiplier, Texture'RGB_MenuButtonSmall_Normal');
	winActionButtonNormal   = CreateActionButton(172 * dxEnhancedGUIScaleMultiplier, 158 * dxEnhancedGUIScaleMultiplier, Texture'RGB_MenuButtonSmall_Normal');
	winActionButtonFocus    = CreateActionButton(256 * dxEnhancedGUIScaleMultiplier, 158 * dxEnhancedGUIScaleMultiplier, Texture'RGB_MenuButtonSmall_Normal');
	winActionButtonPressed  = CreateActionButton(340 * dxEnhancedGUIScaleMultiplier, 158 * dxEnhancedGUIScaleMultiplier, Texture'RGB_MenuButtonSmall_Pressed');

	// Action Button Text
	winTextButtonActionDisabled = CreateActionText( 19 * dxEnhancedGUIScaleMultiplier, 162 * dxEnhancedGUIScaleMultiplier, ButtonActionDisabledLabel);
	winTextButtonActionNormal   = CreateActionText(181 * dxEnhancedGUIScaleMultiplier, 162 * dxEnhancedGUIScaleMultiplier, ButtonActionNormalLabel);
	winTextButtonActionFocus    = CreateActionText(265 * dxEnhancedGUIScaleMultiplier, 162 * dxEnhancedGUIScaleMultiplier, ButtonActionFocusLabel);
	winTextButtonActionPressed  = CreateActionText(349 * dxEnhancedGUIScaleMultiplier, 162 * dxEnhancedGUIScaleMultiplier, ButtonActionPressedLabel);

	// Small Buttons
	winSmallButtonNormal  = CreateSmallButton(252 * dxEnhancedGUIScaleMultiplier, 31 * dxEnhancedGUIScaleMultiplier, Texture'RGB_MenuButtonHeader_Normal');
	winSmallButtonPressed = CreateSmallButton(312 * dxEnhancedGUIScaleMultiplier, 31 * dxEnhancedGUIScaleMultiplier, Texture'RGB_MenuButtonHeader_Pressed');
	winSmallButtonPressed.SetWidth(74);

	// Small Button Text
	winTextButtonSmallNormal  = CreateSmallText(257 * dxEnhancedGUIScaleMultiplier, 34 * dxEnhancedGUIScaleMultiplier, ButtonSmallNormalLabel);
	winTextButtonSmallPressed = CreateSmallText(319 * dxEnhancedGUIScaleMultiplier, 34 * dxEnhancedGUIScaleMultiplier, ButtonSmallPressedLabel);
}

// ----------------------------------------------------------------------
// DrawWindow()
// ----------------------------------------------------------------------

event DrawWindow(GC gc)
{	
	// Draw client area
	if (bBackgroundTranslucent)
		gc.SetStyle(DSTY_Translucent);
	else
		gc.SetStyle(DSTY_Masked);

	gc.SetTileColor(colBackground);
	gc.DrawTexture( 10 * dxEnhancedGUIScaleMultiplier, 23 * dxEnhancedGUIScaleMultiplier, 256 * dxEnhancedGUIScaleMultiplier, 134 * dxEnhancedGUIScaleMultiplier, 0, 0, Texture'RGB_MenuSampleBackground_1');		
	gc.DrawTexture(266 * dxEnhancedGUIScaleMultiplier, 23 * dxEnhancedGUIScaleMultiplier, 157 * dxEnhancedGUIScaleMultiplier, 134 * dxEnhancedGUIScaleMultiplier, 0, 0, Texture'RGB_MenuSampleBackground_2');		
}

// ----------------------------------------------------------------------
// PostDrawWindow()
// ----------------------------------------------------------------------

event PostDrawWindow(GC gc)
{
	// List focus border
	gc.SetTileColor(colListFocus);
	gc.SetStyle(DSTY_Normal);
	gc.DrawBorders(252 * dxEnhancedGUIScaleMultiplier, 64 * dxEnhancedGUIScaleMultiplier, 148 * dxEnhancedGUIScaleMultiplier, 11 * dxEnhancedGUIScaleMultiplier, 0, 0, 0, 0, texListFocusBorders);
}

// ----------------------------------------------------------------------
// CreateMenuButton()
// ----------------------------------------------------------------------

function Window CreateMenuButton(int posX, int posY, Texture buttonBackground)
{
	local Window winButton;

	winButton = NewChild(Class'Window');
	winButton.SetPos(posX, posY);
	winButton.SetSize(204 * dxEnhancedGUIScaleMultiplier, 27 * dxEnhancedGUIScaleMultiplier);
	winButton.SetBackgroundStyle(DSTY_Translucent);
	winButton.SetBackground(buttonBackground);

	return winButton;
}

// ----------------------------------------------------------------------
// CreateMenuText()
// ----------------------------------------------------------------------

function TextWindow CreateMenuText(int posX, int posY, String label)
{
	local TextWindow winText;

	winText = TextWindow(NewChild(Class'TextWindow'));
	winText.SetPos(posX, posY);
	winText.SetTextMargins(0, 0);
	winText.SetTextAlignments(HALIGN_Left, VALIGN_Top);
	winText.SetText(label);
	winText.SetFont(fontMenuButtonText);
	winText.EnableTranslucentText(True);

	return winText;
}

// ----------------------------------------------------------------------
// CreateActionButton()
// ----------------------------------------------------------------------

function Window CreateActionButton(int posX, int posY, Texture buttonBackground)
{
	local Window winButton;

	winButton = NewChild(Class'Window');
	winButton.SetPos(posX, posY);
	winButton.SetSize(83 * dxEnhancedGUIScaleMultiplier, 19 * dxEnhancedGUIScaleMultiplier);
	winButton.SetBackgroundStyle(DSTY_Masked);
	winButton.SetBackground(buttonBackground);

	return winButton;
}

// ----------------------------------------------------------------------
// CreateActionText()
// ----------------------------------------------------------------------

function TextWindow CreateActionText(int posX, int posY, String label)
{
	local TextWindow winText;

	winText = TextWindow(NewChild(Class'TextWindow'));
	winText.SetPos(posX, posY);
	winText.SetTextMargins(0, 0);
	winText.SetTextAlignments(HALIGN_Left, VALIGN_Top);
	winText.SetText(label);
	winText.SetFont(Font'FontMenuTitle');

	return winText;
}

// ----------------------------------------------------------------------
// CreateSmallButton()
// ----------------------------------------------------------------------

function Window CreateSmallButton(int posX, int posY, Texture buttonBackground)
{
	local Window winButton;

	winButton = NewChild(Class'Window');
	winButton.SetPos(posX, posY);
	winButton.SetSize(59 * dxEnhancedGUIScaleMultiplier, 15 * dxEnhancedGUIScaleMultiplier);
	winButton.SetBackgroundStyle(DSTY_Masked);
	winButton.SetBackground(buttonBackground);

	return winButton;
}

// ----------------------------------------------------------------------
// CreateSmallText()
// ----------------------------------------------------------------------

function TextWindow CreateSmallText(int posX, int posY, String label)
{
	local TextWindow winText;

	winText = TextWindow(NewChild(Class'TextWindow'));
	winText.SetPos(posX, posY);
	winText.SetTextMargins(0, 0);
	winText.SetTextAlignments(HALIGN_Left, VALIGN_Top);
	winText.SetText(label);
	winText.SetFont(Font'FontMenuHeaders');

	return winText;
}

// ----------------------------------------------------------------------
// CreateListText()
// ----------------------------------------------------------------------

function TextWindow CreateListText(int posX, int posY, String label)
{
	local TextWindow winText;

	winText = TextWindow(NewChild(Class'TextWindow'));
	winText.SetPos(posX, posY);
	winText.SetTextMargins(0, 0);
	winText.SetTextAlignments(HALIGN_Left, VALIGN_Top);
	winText.SetText(label);
	winText.SetFont(Font'FontMenuSmall');

	return winText;
}

// ----------------------------------------------------------------------
// StyleChanged()
// ----------------------------------------------------------------------

event StyleChanged()
{
	local ColorTheme theme;

	theme = player.ThemeManager.GetCurrentMenuColorTheme();

	colBackground = theme.GetColorFromName('MenuColor_Background');

	winTitle.SetTileColor(theme.GetColorFromName('MenuColor_ButtonFace'));
	winTitleBubble.SetTileColor(theme.GetColorFromName('MenuColor_TitleBackground'));

	colListFocus = theme.GetColorFromName('MenuColor_ListFocus');
	winListFocus.SetTileColor(theme.GetColorFromName('MenuColor_ListHighlight'));

	winMenuButtonDisabled.SetTileColor(theme.GetColorFromName('MenuColor_ButtonFace'));
	winMenuButtonNormal.SetTileColor(theme.GetColorFromName('MenuColor_ButtonFace'));
	winMenuButtonFocus.SetTileColor(theme.GetColorFromName('MenuColor_ButtonFace'));
	winMenuButtonPressed.SetTileColor(theme.GetColorFromName('MenuColor_ButtonFace'));
	winActionButtonDisabled.SetTileColor(theme.GetColorFromName('MenuColor_ButtonFace'));
	winActionButtonNormal.SetTileColor(theme.GetColorFromName('MenuColor_ButtonFace'));
	winActionButtonFocus.SetTileColor(theme.GetColorFromName('MenuColor_ButtonFace'));
	winActionButtonPressed.SetTileColor(theme.GetColorFromName('MenuColor_ButtonFace'));
	winSmallButtonNormal.SetTileColor(theme.GetColorFromName('MenuColor_ButtonFace'));
	winSmallButtonPressed.SetTileColor(theme.GetColorFromName('MenuColor_ButtonFace'));
	winScroll.SetTileColor(theme.GetColorFromName('MenuColor_ButtonFace'));

	winTextButtonMenuDisabled.SetTextColor(theme.GetColorFromName('MenuColor_ButtonTextDisabled'));
	winTextButtonMenuNormal.SetTextColor(theme.GetColorFromName('MenuColor_ButtonTextNormal'));
	winTextButtonMenuFocus.SetTextColor(theme.GetColorFromName('MenuColor_ButtonTextFocus'));
	winTextButtonMenuPressed.SetTextColor(theme.GetColorFromName('MenuColor_ButtonTextNormal'));
	winTextButtonSmallNormal.SetTextColor(theme.GetColorFromName('MenuColor_ButtonTextNormal'));
	winTextButtonSmallPressed.SetTextColor(theme.GetColorFromName('MenuColor_ButtonTextNormal'));
	winTextButtonActionDisabled.SetTextColor(theme.GetColorFromName('MenuColor_ButtonTextDisabled'));
	winTextButtonActionNormal.SetTextColor(theme.GetColorFromName('MenuColor_ButtonTextNormal'));
	winTextButtonActionFocus.SetTextColor(theme.GetColorFromName('MenuColor_ButtonTextFocus'));
	winTextButtonActionPressed.SetTextColor(theme.GetColorFromName('MenuColor_ButtonTextNormal'));
	winTextList.SetTextColor(theme.GetColorFromName('MenuColor_ListText'));
	winTextListFocus.SetTextColor(theme.GetColorFromName('MenuColor_ListTextHighlight'));
	winTextEdit.SetTextColor(theme.GetColorFromName('MenuColor_ListText'));
	winTextTitle.SetTextColor(theme.GetColorFromName('MenuColor_TitleText'));

	bBackgroundTranslucent = player.GetMenuTranslucency();
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
     ButtonMenuDisabledLabel="Disabled"
     ButtonMenuNormalLabel="Normal"
     ButtonMenuFocusLabel="Focus"
     ButtonMenuPressedLabel="Pressed"
     ButtonSmallPressedLabel="Pressed"
     ButtonSmallNormalLabel="Normal"
     ButtonActionDisabledLabel="Disabled"
     ButtonActionNormalLabel="Normal"
     ButtonActionFocusLabel="Focus"
     ButtonActionPressedLabel="Pressed"
     ListNormalLabel="Normal"
     ListFocusLabel="Focus"
     EditLabel="Edit"
     TitleLabel="Title"
}
