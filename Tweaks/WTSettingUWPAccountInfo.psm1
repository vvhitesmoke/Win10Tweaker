############################################
# WinTweaker WTSettingUWPAccountInfo class #
# created at: 2023-02-07                   #
# author: Piotr Gludkowski, VillageTech    #
############################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTSettingUWPAccountInfo : WTTweakBase {
    WTSettingUWPAccountInfo() {
        $this.Name        = "SettingUWPAccountInfo"
        $this.Alias       = "UWPAccountInfo"
        $this.Description = "Access to account info from UWP apps."
        $this.AllowedOperations = [WTTweakActions]::Enable +
                                  [WTTweakActions]::Disable
        $this.Categories        = [WTTweakCategories]::System,
                                  [WTTweakCategories]::Security,
                                  [WTTweakCategories]::Privacy,
                                  [WTTweakCategories]::UWP
    }

    [bool]EnableTweak() {
        # UWPAccountInfo
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessAccountInfo" -ErrorAction SilentlyContinue

        return $true
    }

    [bool]DisableTweak() {
        # UWPAccountInfo
        [WTTweakBase]::CreateRegistryHive("HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessAccountInfo" -Type DWord -Value 2

        return $true
    }
}
