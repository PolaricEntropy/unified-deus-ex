//=============================================================================
// LoadMapWindow
//=============================================================================
class LoadMapWindow expands ToolWindow;

// Windows 
var ToolListWindow		lstMaps;
var ToolButtonWindow	btnLoad;    
var ToolButtonWindow	btnCancel;  
var ToolCheckboxWindow	chkTravel;

// List of files
var GameDirectory mapDir;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();

	// Create our Map Directory class
	mapDir = new(None) Class'GameDirectory';
	mapDir.SetDirType(mapDir.EGameDirectoryTypes.GD_Maps);
	mapDir.GetGameDirectory();

	// Center this window	
	SetSize(370 * dxEnhancedGUIScaleMultiplier, 430 * dxEnhancedGUIScaleMultiplier);
	SetTitle("Load Map");

	// Create the controls
	CreateControls();
	PopulateMapList();
}

// ----------------------------------------------------------------------
// DestroyWindow()
// ----------------------------------------------------------------------

event DestroyWindow()
{
	CriticalDelete( mapDir );
	mapDir = None;
}

// ----------------------------------------------------------------------
// CreateControls()
// ----------------------------------------------------------------------

function CreateControls()
{
	// Flags list box
	CreateMapList();
	
	// Checkbox
	chkTravel = ToolCheckboxWindow(winContainer.NewChild(Class'ToolCheckboxWindow'));
	chkTravel.SetPos(280 * dxEnhancedGUIScaleMultiplier, 66 * dxEnhancedGUIScaleMultiplier);
	chkTravel.SetSize(75 * dxEnhancedGUIScaleMultiplier, 50 * dxEnhancedGUIScaleMultiplier);
	chkTravel.SetText("|&Travel");
	chkTravel.SetToggle(True);

	// Buttons
	btnLoad   = CreateToolButton(280 * dxEnhancedGUIScaleMultiplier, 362 * dxEnhancedGUIScaleMultiplier, "|&Load Map");
	btnCancel = CreateToolButton(280 * dxEnhancedGUIScaleMultiplier, 387 * dxEnhancedGUIScaleMultiplier, "|&Cancel");
}

// ----------------------------------------------------------------------
// CreateMapList()
// ----------------------------------------------------------------------

function CreateMapList()
{
	// Now create the List Window
	lstMaps = CreateToolList(15 * dxEnhancedGUIScaleMultiplier, 38 * dxEnhancedGUIScaleMultiplier, 255 * dxEnhancedGUIScaleMultiplier, 372 * dxEnhancedGUIScaleMultiplier);
	lstMaps.EnableMultiSelect(False);
	lstMaps.EnableAutoExpandColumns(True);
}

// ----------------------------------------------------------------------
// PopulateMapList()
// ----------------------------------------------------------------------

function PopulateMapList()
{
	local int mapIndex;
	local String mapFileName;

	lstMaps.DeleteAllRows();

	// Loop through all the files, but only display travelmaps if 
	// the TravelMap checkbox is enabled

	for( mapIndex=0; mapIndex<mapDir.GetDirCount(); mapIndex++)
	{
		mapFileName = mapDir.GetDirFilename(mapIndex);
		lstMaps.AddRow( left(mapFileName, len(mapFileName) - 3) );
	}

	// Sort the maps by name
	lstMaps.Sort();

	EnableButtons();
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
		case btnLoad:
			LoadMap(lstMaps.GetSelectedRow());
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
// ListSelectionChanged() 
//
// When the user clicks on an item in the list, update the buttons
// appropriately
// ----------------------------------------------------------------------

event bool ListSelectionChanged(window list, int numSelections, int focusRowId)
{
	EnableButtons();

	return true;
}

// ----------------------------------------------------------------------
// ListRowActivated()
// ----------------------------------------------------------------------

event bool ListRowActivated(window list, int rowId)
{
	LoadMap(rowID);

	return true;
}

// ----------------------------------------------------------------------
// LoadMap()
// ----------------------------------------------------------------------

function LoadMap(int rowID)
{
	local String mapFileName;
	local DeusExPlayer localPlayer;
	local Bool bTravel;

	localPlayer = player;

	// If a travel map is selected, then we need to set a flag in 
	// the player before loading the map

	mapFileName = lstMaps.GetField(rowID, 0);

	mapFileName = mapFileName $ ".dx";
	bTravel = chkTravel.GetToggle();

	root.ClearWindowStack();

	if (bTravel)
		localPlayer.ClientTravel(mapFileName$"?Difficulty="$localPlayer.combatDifficulty, TRAVEL_Relative, True);
	else
		localPlayer.ConsoleCommand("Open" @ mapFileName $ "?loadonly");
}

// ----------------------------------------------------------------------
// EnableButtons()
//
// Checks the state of the list control and updates the pushbuttons
// appropriately
// ----------------------------------------------------------------------

function EnableButtons()
{
	btnLoad.SetSensitivity( lstMaps.GetNumSelectedRows() > 0 );
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
}
