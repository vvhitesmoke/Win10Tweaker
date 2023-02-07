##########################################
# WinTweaker WTSettingUWPMessaging class #
# created at: 2023-02-08                 #
# author: Piotr Gludkowski, VillageTech  #
##########################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTSettingUWPMessaging : WTTweakBase {
    WTSettingUWPMessaging() {
        $this.Name        = "SettingUWPMessaging"
        $this.Alias       = "UWPMessaging"
        $this.Description = "Access to messaging (SMS, MMS) from UWP apps."
        $this.AllowedOperations = [WTTweakActions]::Enable +
                                  [WTTweakActions]::Disable
        $this.Categories        = [WTTweakCategories]::System,
                                  [WTTweakCategories]::Security,
                                  [WTTweakCategories]::Privacy,
                                  [WTTweakCategories]::UWP
    }

    [bool]EnableTweak() {
        # UWPMessaging
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessMessaging" -ErrorAction SilentlyContinue

        return $true
    }

    [bool]DisableTweak() {
        # UWPMessaging
        [WTTweakBase]::CreateRegistryHive("HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessMessaging" -Type DWord -Value 2

        return $true
    }
}
