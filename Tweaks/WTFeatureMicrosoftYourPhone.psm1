################################################
# WinTweaker WTFeatureMicrosoftYourPhone class #
# created at: 2023-01-23                       #
# author: Piotr Gludkowski, VillageTech        #
################################################

Using module .\WTTweakBase.psm1

class WTFeatureMicrosoftYourPhone : WTTweakBase {
    WTFeatureMicrosoftYourPhone() {
        $this.Name        = "MicrosoftYourPhone"
        $this.Alias       = "PhoneLink"
        $this.Description = "Microsoft Your Phone application"
        $this.AllowedOperations = @( "Remove" )
    }

    [bool]RemoveTweak() {
        # MicrosoftYourPhone
        Get-AppxPackage -AllUsers Microsoft.YourPhone | Remove-AppxPackage
        return $true
    }
}
