#########################################
# WinTweaker WTFeature3DBuilder class   #
# created at: 2023-01-23                #
# author: Piotr Gludkowski, VillageTech #
#########################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTFeature3DBuilder : WTTweakBase {
    WTFeature3DBuilder() {
        $this.Name        = "Feature3DBuilder"
        $this.Alias       = "3DBuilder"
        $this.Description = "3DBuilder application"
        $this.AllowedOperations = [WTTweakActions]::Remove
        $this.Categories        = [WTTweakCategories]::WindowsApp
    }

    [bool]RemoveTweak() {
        # 3DBuilder
        [WTTweakBase]::RemoveAppxPackage("*3dbuilder*")

        return $true
    }
}
