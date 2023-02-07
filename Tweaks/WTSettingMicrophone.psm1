#########################################
# WinTweaker WTSettingMicrophone class  #
# created at: 2023-01-29                #
# author: Piotr Gludkowski, VillageTech #
#########################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTSettingMicrophone : WTTweakBase {
    WTSettingMicrophone() {
        $this.Name        = "SettingMicrophone"
        $this.Alias       = "Microphone"
        $this.Description = "Access to microphone"
        $this.AllowedOperations = [WTTweakActions]::Enable +
                                  [WTTweakActions]::Disable
        $this.Categories        = [WTTweakCategories]::System,
                                  [WTTweakCategories]::Privacy,
                                  [WTTweakCategories]::Security
    }

    [bool]EnableTweak() {
        # Microphone
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessMicrophone" -ErrorAction SilentlyContinue

        return $true
    }

    [bool]DisableTweak() {
        # Microphone
    	[WTTweakBase]::CreateRegistryHive("HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessMicrophone" -Type DWord -Value 2

        return $true
    }
}
