#########################################
# WinTweaker WTFeature3DViewer class    #
# created at: 2023-01-23                #
# author: Piotr Gludkowski, VillageTech #
#########################################

Using module .\WTTweakBase.psm1

class WTFeature3DViewer : WTTweakBase {
    WTFeature3DViewer() {
        $this.Name        = "Feature3DViewer"
        $this.Alias       = "3DViewer"
        $this.Description = "3DViewer application"
        $this.AllowedOperations = @( "Remove" )
    }

    [bool]RemoveTweak() {
        # 3DViewer
        Get-AppxPackage -AllUsers *3dviewer* | Remove-AppxPackage
        return $true
    }
}
