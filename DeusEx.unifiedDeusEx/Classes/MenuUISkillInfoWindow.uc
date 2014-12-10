//=============================================================================
// MenuUISkillInfoWindow
//=============================================================================

class MenuUISkillInfoWindow expands Window;

var int dxEnhancedGUIScaleMultiplier;

var DeusExPlayer player;

var Skill skill;

var Window                 winSkillIcon;
var TextWindow             winSkillName;
var MenuUIScrollAreaWindow winScroll;
var LargeTextWindow        winSkillDescription;

var Color colSkillName;
var Color colSkillDesc;

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

	SetSize(405 * dxEnhancedGUIScaleMultiplier, 130 * dxEnhancedGUIScaleMultiplier);

	// Create controls
	CreateControls();

	StyleChanged();
}

// ----------------------------------------------------------------------
// CreateControls()
// ----------------------------------------------------------------------

function CreateControls()
{
	winSkillIcon = NewChild(Class'Window');
	winSkillIcon.SetPos(3 * dxEnhancedGUIScaleMultiplier, 20 * dxEnhancedGUIScaleMultiplier);
	winSkillIcon.SetSize(24 * dxEnhancedGUIScaleMultiplier, 24 * dxEnhancedGUIScaleMultiplier);
	winSkillIcon.SetBackgroundStyle(DSTY_Masked);

	winSkillName = TextWindow(NewChild(Class'TextWindow'));
	winSkillName.SetPos(39 * dxEnhancedGUIScaleMultiplier, 2 * dxEnhancedGUIScaleMultiplier);
	winSkillName.SetSize(300 * dxEnhancedGUIScaleMultiplier, 12 * dxEnhancedGUIScaleMultiplier);
	winSkillName.SetTextMargins(0, 0);
	winSkillName.SetFont(Font'FontMenuHeaders');
	winSkillName.SetTextAlignments(HALIGN_Left, VALIGN_Top);
				
	winScroll = MenuUIScrollAreaWindow(NewChild(Class'MenuUIScrollAreaWindow'));
	winScroll.SetPos(39 * dxEnhancedGUIScaleMultiplier, 20 * dxEnhancedGUIScaleMultiplier);
	winScroll.SetSize(362 * dxEnhancedGUIScaleMultiplier, 104 * dxEnhancedGUIScaleMultiplier);

	winSkillDescription = LargeTextWindow(winScroll.clipWindow.NewChild(Class'LargeTextWindow'));
	winSkillDescription.SetTextMargins(0, 0);
	winSkillDescription.SetFont(Font'FontMenuSmall');
	winSkillDescription.SetTextAlignments(HALIGN_Left, VALIGN_Top);
}

// ----------------------------------------------------------------------
// SetSkill()
// ----------------------------------------------------------------------

function SetSkill(skill newSkill)
{
	skill = newSkill;
	
	winSkillIcon.SetBackground(skill.SkillIcon);
	winSkillName.SetText(skill.SkillName);
	winSkillDescription.SetText(skill.Description);	
}

// ----------------------------------------------------------------------
// StyleChanged()
// ----------------------------------------------------------------------

event StyleChanged()
{
	local ColorTheme theme;

	theme = player.ThemeManager.GetCurrentMenuColorTheme();

	// Title colors
	colSkillName = theme.GetColorFromName('MenuColor_ButtonFace');
	colSkillDesc = theme.GetColorFromName('MenuColor_ButtonFace');

	winSkillName.SetTextColor(colSkillName);
	winSkillDescription.SetTextColor(colSkillDesc);
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     dxEnhancedGUIScaleMultiplier=1
     colSkillName=(R=255,G=255,B=255)
     colSkillDesc=(R=200,G=200,B=200)
}
