//=============================================================================
// HUDActiveAug
//=============================================================================

class HUDActiveAug extends HUDActiveItemBase;

var Color colBlack;
var Color colAugActive;
var Color colAugInactive;

var int    hotKeyNum;
var String hotKeyString;

// ----------------------------------------------------------------------
// DrawHotKey()
// ----------------------------------------------------------------------

function DrawHotKey(GC gc) // DJ: Not sure precisely what this is for yet
{
	gc.SetAlignments(HALIGN_Right, VALIGN_Top);
	gc.SetFont(Font'FontTiny');
	
	// Draw Dropshadow
	gc.SetTextColor(colBlack);
	gc.DrawText(16 * dxEnhancedGUIScaleMultiplier, 1 * dxEnhancedGUIScaleMultiplier, 
				15 * dxEnhancedGUIScaleMultiplier, 8 * dxEnhancedGUIScaleMultiplier, hotKeyString);

	// Draw Dropshadow
	gc.SetTextColor(colText);
	gc.DrawText(17 * dxEnhancedGUIScaleMultiplier, 0, 15 * dxEnhancedGUIScaleMultiplier, 
				 8 * dxEnhancedGUIScaleMultiplier, hotKeyString);
}

// ----------------------------------------------------------------------
// SetObject()
//
// Had to write this because SetClientObject() is FINAL in Extension
// ----------------------------------------------------------------------

function SetObject(object newClientObject)
{
	if (newClientObject.IsA('Augmentation'))
	{
		// Get the function key and set the text
		SetKeyNum(Augmentation(newClientObject).GetHotKey());
		UpdateAugIconStatus();
	}
}

// ----------------------------------------------------------------------
// SetKeyNum()
// ----------------------------------------------------------------------

function SetKeyNum(int newNumber)
{
	// Get the function key and set the text
	hotKeyNum    = newNumber;
	hotKeyString = "F" $ String(hotKeyNum);
}

// ----------------------------------------------------------------------
// UpdateAugIconStatus()
// ----------------------------------------------------------------------

function UpdateAugIconStatus()
{
	local Augmentation aug;

	aug = Augmentation(GetClientObject());

	if (aug != None)
	{
		if (aug.IsActive())
			colItemIcon = colAugActive;
		else
			colItemIcon = colAugInactive;
	}
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     colAugActive=(R=255,G=255)
     colAugInactive=(R=100,G=100,B=100)
     colItemIcon=(B=0)
}
