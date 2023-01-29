#########################################
# WinTweaker WTFeature3DBuilder class   #
# created at: 2023-01-23                #
# author: Piotr Gludkowski, VillageTech #
#########################################

Using module .\WTTweakBase.psm1

class WTFeature3DBuilder : WTTweakBase {
    WTFeature3DBuilder() {
        $this.Name        = "Feature3DBuilder"
        $this.Alias       = "3DBuilder"
        $this.Description = "3DBuilder application"
        $this.AllowedOperations = @( "Remove" )
    }

    [bool]RemoveTweak() {
        # 3DBuilder
        Get-AppxPackage -AllUsers *3dbuilder* | Remove-AppxPackage
        return $true
    }
}
