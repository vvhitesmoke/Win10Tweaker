################################################
# WinTweaker WTFeatureMicrosoftYourPhone class #
# created at: 2023-01-23                       #
# author: Piotr Gludkowski, VillageTech        #
################################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTFeatureMicrosoftYourPhone : WTTweakBase {
    WTFeatureMicrosoftYourPhone() {
        $this.Name        = "MicrosoftYourPhone"
        $this.Alias       = "PhoneLink"
        $this.Description = "Microsoft Your Phone application"
        $this.AllowedOperations = [WTTweakActions]::Remove
        $this.Categories        = [WTTweakCategories]::WindowsApp
    }

    [bool]RemoveTweak() {
        # MicrosoftYourPhone
        [WTTweakBase]::RemoveAppxPackage("Microsoft.YourPhone")

        return $true
    }
}
