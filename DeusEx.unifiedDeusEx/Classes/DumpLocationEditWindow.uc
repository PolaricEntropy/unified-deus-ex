//=============================================================================
// DumpLocationEditWindow
//=============================================================================
class DumpLocationEditWindow expands DumpLocationBaseWindow;

Enum EEditMode
{
    EM_Edit, 
	EM_Add
};

// Windows 
var ToolButtonWindow btnSubmit;   
var ToolButtonWindow btnCancel; 

// Edit wndows
var ToolEditWindow editID;
var ToolEditWindow editMapName;
var ToolEditWindow editGameVersion;
var ToolEditWindow editUser;
var ToolEditWindow editLocation;
var ToolEditWindow editViewRotation;
var ToolEditWindow editTitle;
var ToolEditWindow editDescription;

// Other stuff
var EEditMode	 dumpEditMode;
var String       username;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();

	// Center this window	
	SetSize(444 * dxEnhancedGUIScaleMultiplier, 410 * dxEnhancedGUIScaleMultiplier);
	SetTitle("Add Dump Location");
}

// ----------------------------------------------------------------------
// VisibilityChanged()
// ----------------------------------------------------------------------

event VisibilityChanged(bool bNewVisibility)
{
	Super.VisibilityChanged(bNewVisibility);

	// Check to make sure the currentUser variable is set.
	if ((dumpLoc != None) && (dumpLoc.CurrentUser == ""))
	{
		DisplayUserError();
		DestroyDumpLoc();
	}
}

// ----------------------------------------------------------------------
// DisplayUserError()
// ----------------------------------------------------------------------

function DisplayUserError()
{
	root.ToolMessageBox(
		"CurrentUser not defined!", 
		"The CurrentUser setting in your User.ini file is not valid.  Please fix this before trying to use the DumpLocation functionality.", 
		1, True, Self);
}

// ----------------------------------------------------------------------
// DisplayLevelInfoError()
// ----------------------------------------------------------------------

function DisplayLevelInfoError()
{
	root.ToolMessageBox(
		"DeusExLevelInfo Not Found!", 
		"This map does NOT contain a DeusExLevelInfo object.  DumpLocation will not work if this object is missing.", 
		1, True, Self);
}

// ----------------------------------------------------------------------
// CreateControls()
// ----------------------------------------------------------------------

function CreateControls()
{
	// Edit Controls
	CreateToolLabel(16 * dxEnhancedGUIScaleMultiplier, 33 * dxEnhancedGUIScaleMultiplier, "Dump Location ID:");
	editID = CreateToolEditWindow(16 * dxEnhancedGUIScaleMultiplier, 48 * dxEnhancedGUIScaleMultiplier, 160 * dxEnhancedGUIScaleMultiplier, 64 * dxEnhancedGUIScaleMultiplier);
	editID.SetSensitivity(False);

	CreateToolLabel(16 * dxEnhancedGUIScaleMultiplier, 73 * dxEnhancedGUIScaleMultiplier, "Map Name:");
	editMapName = CreateToolEditWindow(16 * dxEnhancedGUIScaleMultiplier, 88 * dxEnhancedGUIScaleMultiplier, 160 * dxEnhancedGUIScaleMultiplier, 64 * dxEnhancedGUIScaleMultiplier);
	editMapName.SetSensitivity(False);

	CreateToolLabel(16 * dxEnhancedGUIScaleMultiplier, 113 * dxEnhancedGUIScaleMultiplier, "User:");
	editUser = CreateToolEditWindow(16 * dxEnhancedGUIScaleMultiplier, 128 * dxEnhancedGUIScaleMultiplier, 160 * dxEnhancedGUIScaleMultiplier, 32 * dxEnhancedGUIScaleMultiplier);
	editUser.SetSensitivity(False);

	CreateToolLabel(200 * dxEnhancedGUIScaleMultiplier, 33 * dxEnhancedGUIScaleMultiplier, "Game Version:");
	editGameVersion = CreateToolEditWindow(200 * dxEnhancedGUIScaleMultiplier, 48 * dxEnhancedGUIScaleMultiplier, 205 * dxEnhancedGUIScaleMultiplier, 64 * dxEnhancedGUIScaleMultiplier);
	editGameVersion.SetSensitivity(False);

	CreateToolLabel(200 * dxEnhancedGUIScaleMultiplier, 73 * dxEnhancedGUIScaleMultiplier, "Player Location:");
	editLocation = CreateToolEditWindow(200 * dxEnhancedGUIScaleMultiplier, 88 * dxEnhancedGUIScaleMultiplier, 205 * dxEnhancedGUIScaleMultiplier, 64 * dxEnhancedGUIScaleMultiplier);
	editLocation.SetSensitivity(False);

	CreateToolLabel(200 * dxEnhancedGUIScaleMultiplier, 113 * dxEnhancedGUIScaleMultiplier, "Player View Rotation:");
	editViewRotation = CreateToolEditWindow(200 * dxEnhancedGUIScaleMultiplier, 128 * dxEnhancedGUIScaleMultiplier, 205 * dxEnhancedGUIScaleMultiplier, 64 * dxEnhancedGUIScaleMultiplier);
	editViewRotation.SetSensitivity(False);

	CreateToolLabel(16 * dxEnhancedGUIScaleMultiplier, 153 * dxEnhancedGUIScaleMultiplier, "Title:");
	editTitle = CreateToolEditWindow(16 * dxEnhancedGUIScaleMultiplier, 168 * dxEnhancedGUIScaleMultiplier, 410 * dxEnhancedGUIScaleMultiplier, 128 * dxEnhancedGUIScaleMultiplier);

	CreateToolLabel(16 * dxEnhancedGUIScaleMultiplier, 193 * dxEnhancedGUIScaleMultiplier, "Description:");
	editDescription = CreateToolEditWindow(16 * dxEnhancedGUIScaleMultiplier, 208 * dxEnhancedGUIScaleMultiplier, 410 * dxEnhancedGUIScaleMultiplier, 2047, 150 * dxEnhancedGUIScaleMultiplier);
	editDescription.EnableSingleLineEditing(False);
	editDescription.SetTextAlignments(HAlign_Left, VAlign_Top);

	// Buttons
	btnSubmit = CreateToolButton(350 * dxEnhancedGUIScaleMultiplier, 370 * dxEnhancedGUIScaleMultiplier, "|&Submit");
	btnCancel = CreateToolButton(270 * dxEnhancedGUIScaleMultiplier, 370 * dxEnhancedGUIScaleMultiplier, "|&Cancel");
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
		case btnSubmit:
			SubmitDump();
			break;

		case btnCancel:
			root.PopWindow();
			break;

		default:
			bHandled = False;
			break;
	}

	if ( !bHandled ) 
		bHandled = Super.ButtonActivated( buttonPressed );

	return bHandled;
}

// ----------------------------------------------------------------------
// EnableButtons()
//
// Checks the state of the list control and updates the pushbuttons
// appropriately
// ----------------------------------------------------------------------

function EnableButtons()
{
	if (dumpEditMode == EM_Edit)
		btnSubmit.SetSensitivity(False);
	else if (Len(editTitle.GetText()) > 0)
		btnSubmit.SetSensitivity(True);
}

// ----------------------------------------------------------------------
// TextChanged()
//
// Don't allow the OK button to be enabled if there's no text in 
// the edit box
// ----------------------------------------------------------------------

event bool TextChanged(window edit, bool bModified)
{
	EnableButtons();

	return false;
}

// ----------------------------------------------------------------------
// SetEditMode()
// ----------------------------------------------------------------------

function bool SetEditMode(String newUsername, int locationID)
{
	username = newUsername;
	dumpEditMode = EM_Edit;

	// Attempt to load the info from disk
	if (dumpLoc.OpenDumpFile(username) == False)
		return False;

	if (dumpLoc.SelectDumpFileLocation(locationID) == False)
		return False;

	editID.SetText(String(locationID));
	editMapName.SetText(dumpLoc.currentDumpLocation.MapName);
	editGameVersion.SetText(dumpLoc.currentDumpLocation.GameVersion);
	editUser.SetText(newUsername);
	editLocation.SetText(GetLocationString(dumpLoc.currentDumpLocation.Location));
	editViewRotation.SetText(GetViewRotationString(dumpLoc.currentDumpLocation.ViewRotation));
	editTitle.SetText(dumpLoc.currentDumpLocation.Title);
	editDescription.SetText(dumpLoc.currentDumpLocation.Desc);

	// Make the Title and Desc fields read only
	editTitle.SetSensitivity(False);
	editDescription.SetSensitivity(False);

	btnCancel.SetButtonText("Close");
}

// ----------------------------------------------------------------------
// SetAddMode()
// ----------------------------------------------------------------------

function bool SetAddMode(optional String newUsername)
{
	local DeusExLevelInfo dxInfo;

	username = newUsername;
	dumpEditMode = EM_Add;

	// Attempt to open the appropriate file
	if (dumpLoc.OpenDumpFile(dumpLoc.GetCurrentUser()) == False)
		return False;

	foreach player.AllActors(class'DeusExLevelInfo', dxInfo)
		break;

	if (dxInfo != None)
	{
		// Setup the fields with default values.  
		editID.SetText(String(dumpLoc.GetNextDumpFileLocationID()));
		editMapName.SetText(dxInfo.mapName);
		editGameVersion.SetText(player.GetDeusExVersion());
		editUser.SetText(dumpLoc.GetCurrentUser());
		editLocation.SetText(GetLocationString(player.Location));
		editViewRotation.SetText(GetViewRotationString(player.ViewRotation));

		btnCancel.SetButtonText("Cancel");

	}
	else
	{
		DisplayLevelInfoError();
	}
}

// ----------------------------------------------------------------------
// GetLocationString()
// ----------------------------------------------------------------------

function String GetLocationString(Vector inLocation)
{
	return "X=" $ String(inLocation.x) $ 
	       ", Y=" $ String(inLocation.y) $ 
		   ", Z=" $ String(inLocation.z);
}

// ----------------------------------------------------------------------
// GetViewRotationString()
// ----------------------------------------------------------------------

function String GetViewRotationString(Rotator inRotator)
{
	return "pitch=" $ String(inRotator.pitch) $ 
	       ", yaw=" $ String(inRotator.yaw) $ 
		   ", roll=" $ String(inRotator.roll);
}

// ----------------------------------------------------------------------
// SubmitDump()
// ----------------------------------------------------------------------

function SubmitDump()
{
	dumpLoc.AddDumpFileLocation(dumpLoc.GetCurrentUser(), editTitle.GetText(), editDescription.GetText());
	root.PopWindow();
}

// ----------------------------------------------------------------------
// BoxOptionSelected()
// ----------------------------------------------------------------------

event bool BoxOptionSelected(Window msgBoxWindow, int buttonNumber)
{
	// Nuke the msgbox
	root.PopWindow();
	root.PopWindow();
	return true;
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
}
