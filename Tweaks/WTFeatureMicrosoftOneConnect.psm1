#################################################
# WinTweaker WTFeatureMicrosoftOneConnect class #
# created at: 2023-01-23                        #
# author: Piotr Gludkowski, VillageTech         #
#################################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTFeatureMicrosoftOneConnect : WTTweakBase {
    WTFeatureMicrosoftOneConnect() {
        $this.Name        = "MicrosoftOneConnect"
        $this.Alias       = "OneConnect"
        $this.Description = "Microsoft OneConnect"
        $this.AllowedOperations = [WTTweakActions]::Remove
        $this.Categories        = [WTTweakCategories]::WindowsApp
    }

    [bool]RemoveTweak() {
        # MicrosoftOneConnect
        [WTTweakBase]::RemoveAppxPackage("Microsoft.OneConnect")

        return $true
    }
}
