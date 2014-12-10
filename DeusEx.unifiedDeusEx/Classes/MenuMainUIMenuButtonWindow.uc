//=============================================================================
// MenuMainUIMenuButtonWindow
//=============================================================================

class MenuMainUIMenuButtonWindow extends MenuUIMenuButtonWindow;

// ----------------------------------------------------------------------
// kocmo: unscaling MenuMain back to original dimensions
// ----------------------------------------------------------------------
function ScaleDimensions() {
	if (player.dxEnhancedGUIScaleMultiplier > 1) { // for MenuMain we're using unscaled button textures in all cases
		buttonLights[0] = Texture'DeusExUI.UserInterface.MenuMainLight_Normal_unscaled';
		buttonLights[1] = Texture'DeusExUI.UserInterface.MenuMainLight_Focus_unscaled';
		buttonLights[2] = Texture'DeusExUI.UserInterface.MenuMainLight_Focus_unscaled';
		buttonLights[3] = Texture'DeusExUI.UserInterface.MenuMainLight_Normal_unscaled';

		Left_Textures[0].tex = Texture'DeusExUI.UserInterface.MenuMainButtonNormal_Left_unscaled';
		Left_Textures[1].tex = Texture'DeusExUI.UserInterface.MenuMainButtonPressed_Left_unscaled';
		Right_Textures[0].tex = Texture'DeusExUI.UserInterface.MenuMainButtonNormal_Right_unscaled';
		Right_Textures[1].tex = Texture'DeusExUI.UserInterface.MenuMainButtonPressed_Right_unscaled';
		Center_Textures[0].tex = Texture'DeusExUI.UserInterface.MenuMainButtonNormal_Center_unscaled';
		Center_Textures[1].tex = Texture'DeusExUI.UserInterface.MenuMainButtonPressed_Center_unscaled';
	}

	dxEnhancedGUIScaleMultiplier = 1;	
}

defaultproperties
{
}
