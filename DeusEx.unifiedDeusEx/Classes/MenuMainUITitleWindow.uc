//=============================================================================
// MenuMainUITitleWindow
//=============================================================================

class MenuMainUITitleWindow extends MenuUITitleWindow;

// kocmo: unscaling MenuMain back to original dimensions, and using unscaled textures
function ScaleDimensions() {
	if (player.dxEnhancedGUIScaleMultiplier > 1) { // for MenuMain we're using unscaled button textures in all cases
		textureAppIcon = Texture'DeusExUI.UserInterface.MenuIcon_DeusEx_unscaled';
		titleTexture_Left = Texture'DeusExUI.UserInterface.MenuTitleBar_Left_unscaled';
		titleTexture_Center = Texture'DeusExUI.UserInterface.MenuTitleBar_Center_unscaled';
		titleTexture_Right = Texture'DeusExUI.UserInterface.MenuTitleBar_Right_unscaled';
		titleTexture_LeftBottom = Texture'DeusExUI.UserInterface.MenuTitleBar_LeftBottom_unscaled';
		titleBubble_Left = Texture'DeusExUI.UserInterface.MenuTitleBubble_Left_unscaled';
		titleBubble_Center = Texture'DeusExUI.UserInterface.MenuTitleBubble_Center_unscaled';
		titleBubble_Right = Texture'DeusExUI.UserInterface.MenuTitleBubble_Right_unscaled';
	}

	dxEnhancedGUIScaleMultiplier = 1;	
}

defaultproperties
{
}
