#########################################
# WinTweaker WTFeature3DViewer class    #
# created at: 2023-01-23                #
# author: Piotr Gludkowski, VillageTech #
#########################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTFeature3DViewer : WTTweakBase {
    WTFeature3DViewer() {
        $this.Name        = "Feature3DViewer"
        $this.Alias       = "3DViewer"
        $this.Description = "3DViewer application"
        $this.AllowedOperations = [WTTweakActions]::Remove
        $this.Categories        = [WTTweakCategories]::WindowsApp
    }

    [bool]RemoveTweak() {
        # 3DViewer
        [WTTweakBase]::RemoveAppxPackage("*3dviewer*")

        return $true
    }
}
