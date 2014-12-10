//=============================================================================
// ComputerScreenEmail
//=============================================================================

class ComputerScreenEmail expands ComputerUIWindow;

var MenuUIActionButtonWindow     btnSpecial;
var MenuUIActionButtonWindow     btnLogout;
var MenuUIListWindow             lstEmail;
var MenuUINormalLargeTextWindow  winEmail;
var MenuUIListHeaderButtonWindow btnHeaderFrom;
var MenuUIListHeaderButtonWindow btnHeaderSubject;

// Header vars
var MenuUISmallLabelWindow winEmailFrom;
var MenuUISmallLabelWindow winEmailTo;
var MenuUISmallLabelWindow winEmailSubject;
var MenuUISmallLabelWindow winEmailCC;
var MenuUILabelWindow      winEmailCCHeader;

var bool bFromSortOrder;
var bool bSubjectSortOrder;

var localized String NoEmailTodayText;
var localized String EmailFromHeader;
var localized String EmailToHeader;
var localized String EmailCarbonCopyHeader;
var localized String EmailSubjectHeader;
var localized String HeaderFromLabel;
var localized String HeaderSubjectLabel;

// ----------------------------------------------------------------------
// CloseScreen()
// ----------------------------------------------------------------------

function CloseScreen(String action)
{
	if (winTerm != None)
		winTerm.CloseHackAccountsWindow();

	Super.CloseScreen(action);
}

// ----------------------------------------------------------------------
// CreateControls()
// ----------------------------------------------------------------------

function CreateControls()
{
	Super.CreateControls();

	btnLogout = winButtonBar.AddButton(ButtonLabelLogout, HALIGN_Right);

	CreateEmailListWindow();
	CreateEmailViewWindow();
	CreateEmailHeaders();
	CreateHeaderButtons();
}

// ----------------------------------------------------------------------
// WindowReady()
// ----------------------------------------------------------------------

event WindowReady()
{
	SetFocusWindow(lstEmail);
}

// ----------------------------------------------------------------------
// CreateEmailListWindow()
// ----------------------------------------------------------------------

function CreateEmailListWindow()
{
	local MenuUIScrollAreaWindow winScroll;

	winScroll = CreateScrollAreaWindow(winClient);
	winScroll.SetPos(  11 * dxEnhancedGUIScaleMultiplier, 
					   22 * dxEnhancedGUIScaleMultiplier);
	winScroll.SetSize(373 * dxEnhancedGUIScaleMultiplier, 
					   73 * dxEnhancedGUIScaleMultiplier);

	lstEmail = MenuUIListWindow(winScroll.clipWindow.NewChild(Class'MenuUIListWindow'));
	lstEmail.EnableMultiSelect(False);
	lstEmail.EnableAutoExpandColumns(False);
	lstEmail.EnableHotKeys(False);

	lstEmail.SetNumColumns(3);
	lstEMail.HideColumn(2);
	lstEmail.SetColumnType(2, COLTYPE_Float);

	lstEmail.SetColumnWidth(0, 123 * dxEnhancedGUIScaleMultiplier);
	lstEmail.SetColumnWidth(1, 250 * dxEnhancedGUIScaleMultiplier);
	lstEmail.SetSortColumn(0, bFromSortOrder);
}

// ----------------------------------------------------------------------
// CreateEmailViewWindow()
// ----------------------------------------------------------------------

function CreateEmailViewWindow()
{
	local MenuUIScrollAreaWindow winScroll;

	winScroll = CreateScrollAreaWindow(winClient);
	winScroll.SetPos(11 * dxEnhancedGUIScaleMultiplier, 136 * dxEnhancedGUIScaleMultiplier);
	winScroll.SetSize(373 * dxEnhancedGUIScaleMultiplier, 239 * dxEnhancedGUIScaleMultiplier);

	winEmail = MenuUINormalLargeTextWindow(winScroll.ClipWindow.NewChild(Class'MenuUINormalLargeTextWindow'));
	winEmail.SetTextMargins(4 * dxEnhancedGUIScaleMultiplier, 1 * dxEnhancedGUIScaleMultiplier);
	winEmail.SetWordWrap(True);
	winEmail.SetTextAlignments(HALIGN_Left, VALIGN_Top);
}

// ----------------------------------------------------------------------
// CreateEmailHeaders()
// ----------------------------------------------------------------------

function CreateEmailHeaders()
{
	local MenuUILabelWindow newLabel;

	// First create the headers
	newLabel = CreateMenuLabel( 12 * dxEnhancedGUIScaleMultiplier, 
							   104 * dxEnhancedGUIScaleMultiplier, EmailFromHeader, winClient);
	newLabel.SetFont(Font'FontMenuTitle');

	newLabel = CreateMenuLabel(212 * dxEnhancedGUIScaleMultiplier, 
							   104 * dxEnhancedGUIScaleMultiplier, EmailToHeader, winClient);
	newLabel.SetFont(Font'FontMenuTitle');

	newLabel = CreateMenuLabel( 12 * dxEnhancedGUIScaleMultiplier, 
							   118 * dxEnhancedGUIScaleMultiplier, EmailSubjectHeader, winClient);
	newLabel.SetFont(Font'FontMenuTitle');

	winEmailCCHeader = CreateMenuLabel(212 * dxEnhancedGUIScaleMultiplier, 
									   118 * dxEnhancedGUIScaleMultiplier, 
											 EmailCarbonCopyHeader, winClient);
											 
	winEmailCCHeader.SetFont(Font'FontMenuTitle');
	winEmailCCHeader.Hide();

	// Now create the text fields
	winEmailFrom    = CreateSmallMenuLabel(  50 * dxEnhancedGUIScaleMultiplier, 
											105 * dxEnhancedGUIScaleMultiplier, 
												  "", winClient);
	winEmailTo      = CreateSmallMenuLabel( 240 * dxEnhancedGUIScaleMultiplier, 
											105 * dxEnhancedGUIScaleMultiplier, 
												  "", winClient);
	winEmailSubject = CreateSmallMenuLabel(  50 * dxEnhancedGUIScaleMultiplier, 
											119 * dxEnhancedGUIScaleMultiplier, 
												  "", winClient);
	winEmailCC      = CreateSmallMenuLabel(240 * dxEnhancedGUIScaleMultiplier, 
										   119 * dxEnhancedGUIScaleMultiplier, "", winClient);
}

// ----------------------------------------------------------------------
// CreateHeaderButtons()
// ----------------------------------------------------------------------

function CreateHeaderButtons()
{
	btnHeaderFrom    = CreateHeaderButton( 10 * dxEnhancedGUIScaleMultiplier,  
											3 * dxEnhancedGUIScaleMultiplier, 
										  121 * dxEnhancedGUIScaleMultiplier, HeaderFromLabel, winClient);
	btnHeaderSubject = CreateHeaderButton(134 * dxEnhancedGUIScaleMultiplier, 
											3 * dxEnhancedGUIScaleMultiplier, 
										  187 * dxEnhancedGUIScaleMultiplier, HeaderSubjectLabel, winClient);
}

// ----------------------------------------------------------------------
// SetNetworkTerminal()
// ----------------------------------------------------------------------

function SetNetworkTerminal(NetworkTerminal newTerm)
{
	Super.SetNetworkTerminal(newTerm);

	if (winTerm.AreSpecialOptionsAvailable())
	{
		btnSpecial = winButtonBar.AddButton(ButtonLabelSpecial, HALIGN_Left);
		CreateLeftEdgeWindow();
	}

	// Create the Hack Accounts window (will only be created
	// if the user hacked into the computer)

	winTerm.CreateHackAccountsWindow();
}

// ----------------------------------------------------------------------
// SetCompOwner()
// ----------------------------------------------------------------------

function SetCompOwner(ElectronicDevices newCompOwner)
{
	local String emailName;
	local String missionNumber;
	local DeusExLevelInfo info;
	local int emailInfoIndex;
	local int rowId;

	Super.SetCompOwner(newCompOwner);

	info = player.GetLevelInfo();

	// hack for the DX.DX splash level
	if (info != None) 
	{
		if (info.MissionNumber < 10)
			MissionNumber = "0" $ String(info.MissionNumber);
		else
			MissionNumber = String(info.MissionNumber);
	}

	// Open the email menu based on the login id
	// or if it's been hacked, use the first account in the list
	emailName = MissionNumber $ "_EmailMenu_" $ winTerm.GetUserName();

	ProcessDeusExText(StringToName(emailName));

	ProcessScriptEmail();

	if (emailIndex != -1)
	{
		// Now populate our list
		for(emailInfoIndex=0; emailInfoIndex<=emailIndex; emailInfoIndex++)
			lstEmail.AddRow(emailInfo[emailInfoIndex].emailFrom $ ";" $ 
			                emailInfo[emailInfoIndex].emailSubject $ ";" $ 
							emailInfoIndex);

		// Select the first row
		rowId = lstEmail.IndexToRowId(0);
		lstEmail.SetRow(rowId, True);
	}
	else
	{
		// No Email, so just print a "No Email Today!" message
		winEmail.SetText(NoEmailTodayText);
		winEmail.SetTextAlignments(HALIGN_Center, VALIGN_Center);
	}
}

// ----------------------------------------------------------------------
// ButtonActivated()
// ----------------------------------------------------------------------

function bool ButtonActivated( Window buttonPressed )
{
	local bool bHandled;

	bHandled = True;

	switch( buttonPressed )
	{
		case btnHeaderFrom:
			bFromSortOrder = !bFromSortOrder;
			lstEmail.SetSortColumn(0, bFromSortOrder);
			lstEmail.Sort();
			break;

		case btnHeaderSubject:
			bSubjectSortOrder = !bSubjectSortOrder;
			lstEmail.SetSortColumn(1, bSubjectSortOrder);
			lstEmail.Sort();
			break;

		case btnLogout:
			CloseScreen("EXIT");
			break;

		case btnSpecial:
			CloseScreen("SPECIAL");
			break;

		default:
			bHandled = False;
			break;
	}

	if (bHandled)
		return True;
	else
		return Super.ButtonActivated(buttonPressed);
}

// ----------------------------------------------------------------------
// ListSelectionChanged() 
//
// Show the appropriate bulletin
// ----------------------------------------------------------------------

event bool ListSelectionChanged(window list, int numSelections, int focusRowId)
{
	local int emailInfoIndex;

	emailInfoIndex = Int(lstEmail.GetField(focusRowId, 2));

	// Generate the email header
	winEmailFrom.SetText(emailInfo[emailInfoIndex].emailFrom);
	winEmailTo.SetText(emailInfo[emailInfoIndex].emailTo);
	winEmailSubject.SetText(emailInfo[emailInfoIndex].emailSubject);

	if (emailInfo[emailInfoIndex].emailCC != "")
	{
		winEmailCCHeader.Show();
		winEmailCC.SetText(emailInfo[emailInfoIndex].emailCC);
	}
	else
	{
		winEmailCCHeader.Hide();
	}

	// Process the body
	winEmail.SetText("");
	if(emailInfo[emailInfoIndex].emailName != '')
		ProcessDeusExText(emailInfo[emailInfoIndex].emailName, winEmail);
	else
		ProcessScriptEmail(emailInfoIndex, winEmail);
}

// ----------------------------------------------------------------------
// ChangeAccount()
//
// If the account changes, the reload this screen, baby!
// ----------------------------------------------------------------------

function ChangeAccount()
{
	Super.ChangeAccount();
	CloseScreen("EMAIL");
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     bFromSortOrder=True
     NoEmailTodayText="No Email Today!"
     EmailFromHeader="From:"
     EmailToHeader="To:"
     EmailCarbonCopyHeader="CC:"
     EmailSubjectHeader="Subj:"
     HeaderFromLabel="From"
     HeaderSubjectLabel="Subject"
     escapeAction="LOGOUT"
     Title="Email"
     ClientWidth=395
     ClientHeight=412
     clientTextures(0)=Texture'DeusExUI.UserInterface.ComputerEmailBackground_1'
     clientTextures(1)=Texture'DeusExUI.UserInterface.ComputerEmailBackground_2'
     clientTextures(2)=Texture'DeusExUI.UserInterface.ComputerEmailBackground_3'
     clientTextures(3)=Texture'DeusExUI.UserInterface.ComputerEmailBackground_4'
     textureRows=2
     textureCols=2
     statusPosY=383
     defaultStatusLeftOffset=12
     ComputerNodeFunctionLabel="Email"
}
