//=============================================================================
// MenuUICustomMessageBoxWindow
//=============================================================================

class MenuUICustomMessageBoxWindow expands MenuUIMessageBoxWindow;

event bool BoxOptionSelected(Window button, int buttonNumber) {
	root.PopWindow(); // Destroy the msgbox!  
	if (buttonNumber == 0) 
		root.ExitGame();
	return true;
}

defaultproperties
{
}
