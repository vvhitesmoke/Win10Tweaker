############################################
# WinTweaker WTSettingUWPCallHistory class #
# created at: 2023-02-07                   #
# author: Piotr Gludkowski, VillageTech    #
############################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTSettingUWPCallHistory : WTTweakBase {
    WTSettingUWPCallHistory() {
        $this.Name        = "SettingUWPCallHistory"
        $this.Alias       = "UWPCallHistory"
        $this.Description = "Access to call history from UWP apps."
        $this.AllowedOperations = [WTTweakActions]::Enable +
                                  [WTTweakActions]::Disable
        $this.Categories        = [WTTweakCategories]::System,
                                  [WTTweakCategories]::Security,
                                  [WTTweakCategories]::Privacy,
                                  [WTTweakCategories]::UWP
    }

    [bool]EnableTweak() {
        # UWPCallHistory
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessCallHistory" -ErrorAction SilentlyContinue

        return $true
    }

    [bool]DisableTweak() {
        # UWPCallHistory
        [WTTweakBase]::CreateRegistryHive("HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessCallHistory" -Type DWord -Value 2

        return $true
    }
}
