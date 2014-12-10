//=============================================================================
// MenuScreenPlayerSetup (multiplayer)
//=============================================================================

class MenuScreenPlayerSetup expands MenuUIScreenWindow;

var MenuUIEditWindow         PlayerNameEditor;

var localized string HeaderPlayerNameLabel;
var string FilterString;

var MenuChoice_Connection ConnectionChoice;
var MenuChoice_Team TeamChoice;
var MenuChoice_Class ClassChoice;
var MenuChoice_MultiHelp HelpChoice;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();

   winHelp.Hide();
}

// ----------------------------------------------------------------------
// CreateControls()
// ----------------------------------------------------------------------

function CreateControls()
{
	Super.CreateControls();
      
   CreateClassChoice();

   CreateTeamChoice();

   CreatePlayerNameHeader();

   CreateConnectionChoice();

   CreateHelpChoice();

   CreatePlayerNameEditor();
}

// ----------------------------------------------------------------------
// CreatePlayerNameHeader()
// ----------------------------------------------------------------------

function CreatePlayerNameHeader()
{
	CreateMenuLabel( 7 * dxEnhancedGUIScaleMultiplier, 31 * dxEnhancedGUIScaleMultiplier, HeaderPlayerNameLabel, winClient );
}

// ----------------------------------------------------------------------
// CreatePlayerNameEditor()
// ----------------------------------------------------------------------

function CreatePlayerNameEditor()
{ 
  	PlayerNameEditor = CreateMenuEditWindow(177 * dxEnhancedGUIScaleMultiplier, 27 * dxEnhancedGUIScaleMultiplier, 
											153 * dxEnhancedGUIScaleMultiplier, 18 * dxEnhancedGUIScaleMultiplier, winClient);

	PlayerNameEditor.SetText(GetMultiplayerName());
	PlayerNameEditor.MoveInsertionPoint(MOVEINSERT_End);
	PlayerNameEditor.SetFilter(filterString);
}

// ----------------------------------------------------------------------
// CreateConnectionChoice()
// ----------------------------------------------------------------------

function CreateConnectionChoice()
{
	ConnectionChoice = MenuChoice_Connection(winClient.NewChild(Class'MenuChoice_Connection'));
	ConnectionChoice.SetPos(6 * dxEnhancedGUIScaleMultiplier, 54 * dxEnhancedGUIScaleMultiplier);
}

// ----------------------------------------------------------------------
// CreateHelpChoice()
// ----------------------------------------------------------------------

function CreateHelpChoice()
{
	HelpChoice = MenuChoice_MultiHelp(winClient.NewChild(Class'MenuChoice_MultiHelp'));
	HelpChoice.SetPos(6 * dxEnhancedGUIScaleMultiplier, 81 * dxEnhancedGUIScaleMultiplier);
}

// ----------------------------------------------------------------------
// CreateTeamChoice()
// ----------------------------------------------------------------------

function CreateTeamChoice()
{
	TeamChoice = MenuChoice_Team(winClient.NewChild(Class'MenuChoice_Team'));
	TeamChoice.SetPos(176 * dxEnhancedGUIScaleMultiplier, 120 * dxEnhancedGUIScaleMultiplier);
   TeamChoice.SetSize(153 * dxEnhancedGUIScaleMultiplier, 213 * dxEnhancedGUIScaleMultiplier);
}

// ----------------------------------------------------------------------
// CreateClassChoice()
// ----------------------------------------------------------------------

function CreateClassChoice()
{
	ClassChoice = MenuChoice_Class(winClient.NewChild(Class'MenuChoice_Class'));
	ClassChoice.SetPos(6 * dxEnhancedGUIScaleMultiplier, 120 * dxEnhancedGUIScaleMultiplier);
   ClassChoice.SetSize(153 * dxEnhancedGUIScaleMultiplier, 213 * dxEnhancedGUIScaleMultiplier);
}

// ----------------------------------------------------------------------
// FocusEnteredDescendant() : Called when a descendant window gets focus
// ----------------------------------------------------------------------

event FocusEnteredDescendant(Window enterWindow)
{
	if (enterWindow.IsA('MenuUIChoiceButton'))
	{
      if ((winHelp != None) && (MenuUIChoiceButton(enterWindow).helpText != ""))
      {
         winHelp.Show();
         winHelp.SetText(MenuUIChoiceButton(enterWindow).helpText);
      }
   }
}


// ----------------------------------------------------------------------
// FocusLeftDescendant() : Called when a descendant window loses focus
// ----------------------------------------------------------------------

event FocusLeftDescendant(Window leaveWindow)
{
	if ((winHelp != None) && (!bHelpAlwaysOn))
		winHelp.Hide();
}

// ----------------------------------------------------------------------
// SaveSettings()
// ----------------------------------------------------------------------

function SaveSettings()
{
   Super.SaveSettings();

   SetMultiplayerName(PlayerNameEditor.GetText());

   player.SaveConfig();
}

// ----------------------------------------------------------------------
// ResetToDefaults()
// ----------------------------------------------------------------------

function ResetToDefaults()
{
   Super.ResetToDefaults();

   //Setting "" will set to default.
   SetMultiplayerName("");

   PlayerNameEditor.SetText(GetMultiplayerName());

   player.SaveConfig();
}

// ----------------------------------------------------------------------
// GetMultiplayerName()
// ----------------------------------------------------------------------

function string GetMultiplayerName()
{
   local string mpname;

   mpname = player.PlayerReplicationInfo.PlayerName;

   if (mpname == "")
   {
      mpname = "Player";
      SetMultiplayerName(mpname);
   }

   return mpname;
}

// ----------------------------------------------------------------------
// SetMultiplayerName()
// ----------------------------------------------------------------------

function SetMultiplayerName(string newname)
{
   local string mpname;

   if (newname == "")
      mpname = "Player";
   else
      mpname = newname;

   player.SetName(mpname);
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     HeaderPlayerNameLabel="Player Name"
     filterString="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890[]()"
     actionButtons(0)=(Align=HALIGN_Right,Action=AB_Cancel)
     actionButtons(1)=(Align=HALIGN_Right,Action=AB_Reset)
     actionButtons(2)=(Action=AB_OK)
     Title="Multiplayer Player Setup"
     ClientWidth=343
     ClientHeight=415
     clientTextures(0)=Texture'DeusExUI.UserInterface.MenuPlayerSetupBackground_1'
     clientTextures(1)=Texture'DeusExUI.UserInterface.MenuPlayerSetupBackground_2'
     clientTextures(2)=Texture'DeusExUI.UserInterface.MenuPlayerSetupBackground_3'
     clientTextures(3)=Texture'DeusExUI.UserInterface.MenuPlayerSetupBackground_4'
     textureCols=2
     helpPosY=353
}
