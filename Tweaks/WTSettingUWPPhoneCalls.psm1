###########################################
# WinTweaker WTSettingUWPPhoneCalls class #
# created at: 2023-02-07                  #
# author: Piotr Gludkowski, VillageTech   #
###########################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTSettingUWPPhoneCalls : WTTweakBase {
    WTSettingUWPPhoneCalls() {
        $this.Name        = "SettingUWPPhoneCalls"
        $this.Alias       = "UWPPhoneCalls"
        $this.Description = "Access to phone calls from UWP apps."
        $this.AllowedOperations = [WTTweakActions]::Enable +
                                  [WTTweakActions]::Disable
        $this.Categories        = [WTTweakCategories]::System,
                                  [WTTweakCategories]::Security,
                                  [WTTweakCategories]::Privacy,
                                  [WTTweakCategories]::UWP
    }

    [bool]EnableTweak() {
        # UWPPhoneCalls
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessPhone" -ErrorAction SilentlyContinue

        return $true
    }

    [bool]DisableTweak() {
        # UWPPhoneCalls
        [WTTweakBase]::CreateRegistryHive("HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessPhone" -Type DWord -Value 2

        return $true
    }
}
