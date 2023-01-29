#################################################
# WinTweaker WTFeatureMicrosoftOneConnect class #
# created at: 2023-01-23                        #
# author: Piotr Gludkowski, VillageTech         #
#################################################

Using module .\WTTweakBase.psm1

class WTFeatureMicrosoftOneConnect : WTTweakBase {
    WTFeatureMicrosoftOneConnect() {
        $this.Name        = "MicrosoftOneConnect"
        $this.Alias       = "OneConnect"
        $this.Description = "Microsoft OneConnect"
        $this.AllowedOperations = @( "Remove" )
    }

    [bool]RemoveTweak() {
        # MicrosoftOneConnect
        Get-AppxPackage -AllUsers Microsoft.OneConnect | Remove-AppxPackage
        return $true
    }
}
