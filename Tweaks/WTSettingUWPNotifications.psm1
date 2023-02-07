##############################################
# WinTweaker WTSettingUWPNotifications class #
# created at: 2023-02-07                     #
# author: Piotr Gludkowski, VillageTech      #
##############################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTSettingUWPNotifications : WTTweakBase {
    WTSettingUWPNotifications() {
        $this.Name        = "SettingUWPNotifications"
        $this.Alias       = "UWPNotifications"
        $this.Description = "Access to notifications from UWP apps."
        $this.AllowedOperations = [WTTweakActions]::Enable +
                                  [WTTweakActions]::Disable
        $this.Categories        = [WTTweakCategories]::System,
                                  [WTTweakCategories]::Performance,
                                  [WTTweakCategories]::Privacy,
                                  [WTTweakCategories]::UWP
    }

    [bool]EnableTweak() {
        # UWPNotifications
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessNotifications" -ErrorAction SilentlyContinue

        return $true
    }

    [bool]DisableTweak() {
        # UWPNotifications
        [WTTweakBase]::CreateRegistryHive("HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessNotifications" -Type DWord -Value 2

        return $true
    }
}
