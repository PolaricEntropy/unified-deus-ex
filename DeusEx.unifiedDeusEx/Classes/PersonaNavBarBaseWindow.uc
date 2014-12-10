//=============================================================================
// PersonaNavBarBaseWindow
//=============================================================================
class PersonaNavBarBaseWindow expands PersonaBaseWindow;

var PersonaButtonBarWindow winNavButtons;
var PersonaButtonBarWindow winNavExit;

var PersonaNavButtonWindow btnExit;

var Texture texBackgrounds[3];
var Texture texBorders[3];

var int backgroundOffsetX;
var int backgroundOffsetY;

var localized String ExitButtonLabel;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();

	SetSize(640 * dxEnhancedGUIScaleMultiplier, 64 * dxEnhancedGUIScaleMultiplier);

	CreateButtonWindows();
	CreateButtons();
}

function ScaleDimensions() {
	Super.ScaleDimensions();

	backgroundOffsetX *= dxEnhancedGUIScaleMultiplier;
	backgroundOffsetY *= dxEnhancedGUIScaleMultiplier;
}

// ----------------------------------------------------------------------
// DrawBackground()
// ----------------------------------------------------------------------

function DrawBackground(GC gc)
{
	gc.SetStyle(backgroundDrawStyle);
	gc.SetTileColor(colBackground);
	gc.DrawTexture(backgroundOffsetX,       backgroundOffsetY, 
				   256 * dxEnhancedGUIScaleMultiplier, 21 * dxEnhancedGUIScaleMultiplier, 0, 0, texBackgrounds[0]);
	gc.DrawTexture(backgroundOffsetX + (256 * dxEnhancedGUIScaleMultiplier), backgroundOffsetY, 
				   256 * dxEnhancedGUIScaleMultiplier, 21 * dxEnhancedGUIScaleMultiplier, 0, 0, texBackgrounds[1]);
	gc.DrawTexture(backgroundOffsetX + (512 * dxEnhancedGUIScaleMultiplier), backgroundOffsetY,  
				   97 * dxEnhancedGUIScaleMultiplier,  21 * dxEnhancedGUIScaleMultiplier, 0, 0, texBackgrounds[2]);
}

// ----------------------------------------------------------------------
// DrawBorder()
// ----------------------------------------------------------------------

function DrawBorder(GC gc)
{
	if (bDrawBorder)
	{
		gc.SetStyle(borderDrawStyle);
		gc.SetTileColor(colBorder);
		
		gc.DrawTexture(  0, 0, 256 * dxEnhancedGUIScaleMultiplier, height, 0, 0, texBorders[0]);
		gc.DrawTexture(256 * dxEnhancedGUIScaleMultiplier, 0, 256 * dxEnhancedGUIScaleMultiplier, height, 0, 0, texBorders[1]);
		gc.DrawTexture(512 * dxEnhancedGUIScaleMultiplier, 0, 175 * dxEnhancedGUIScaleMultiplier, height, 0, 0, texBorders[2]);
	}
}

// ----------------------------------------------------------------------
// CreateButtonWindow()
// ----------------------------------------------------------------------

function CreateButtonWindows()
{
	// Create the Inventory Items window
	winNavButtons = PersonaButtonBarWindow(NewChild(Class'PersonaButtonBarWindow'));

	winNavButtons.SetPos(  23 * dxEnhancedGUIScaleMultiplier,  8 * dxEnhancedGUIScaleMultiplier);
	winNavButtons.SetSize(534 * dxEnhancedGUIScaleMultiplier, 16 * dxEnhancedGUIScaleMultiplier);
	winNavButtons.Lower();

	// Create the Inventory Items window
	winNavExit = PersonaButtonBarWindow(NewChild(Class'PersonaButtonBarWindow'));

	winNavExit.SetPos(573 * dxEnhancedGUIScaleMultiplier, 8 * dxEnhancedGUIScaleMultiplier);
	winNavExit.SetSize(48 * dxEnhancedGUIScaleMultiplier, 16 * dxEnhancedGUIScaleMultiplier);
	winNavExit.Lower();
}

// ----------------------------------------------------------------------
// CreateButtons()
// ----------------------------------------------------------------------

function CreateButtons()
{
	btnExit = CreateNavButton(winNavExit, ExitButtonLabel);
}

// ----------------------------------------------------------------------
// CreateNavButton()
// ----------------------------------------------------------------------

function PersonaNavButtonWindow CreateNavButton(Window winParent, string buttonLabel)
{
	local PersonaNavButtonWindow newButton;

	newButton = PersonaNavButtonWindow(winParent.NewChild(Class'PersonaNavButtonWindow'));
	newButton.SetButtonText(buttonLabel);

	return newButton;
}

// ----------------------------------------------------------------------
// ButtonActivated()
// ----------------------------------------------------------------------

function bool ButtonActivated( Window buttonPressed )
{
	local bool bHandled;

	bHandled = True;

	switch(buttonPressed)
	{
		case btnExit:
			PersonaScreenBaseWindow(GetParent()).SaveSettings();
			root.PopWindow();	
			break;

		default:
			bHandled = False;
			break;
	}

	if (bHandled)
		return bHandled;
	else
		return Super.ButtonActivated(buttonPressed);
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     texBackgrounds(0)=Texture'DeusExUI.UserInterface.PersonaNavBarBackground_1'
     texBackgrounds(1)=Texture'DeusExUI.UserInterface.PersonaNavBarBackground_2'
     texBackgrounds(2)=Texture'DeusExUI.UserInterface.PersonaNavBarBackground_3'
     texBorders(0)=Texture'DeusExUI.UserInterface.PersonaNavBarBorder_1'
     texBorders(1)=Texture'DeusExUI.UserInterface.PersonaNavBarBorder_2'
     texBorders(2)=Texture'DeusExUI.UserInterface.PersonaNavBarBorder_3'
     backgroundOffsetX=17
     backgroundOffsetY=6
     ExitButtonLabel="E|&xit"
}
