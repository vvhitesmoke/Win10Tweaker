################################################
# WinTweaker WTSettingUWPVoiceActivation class #
# created at: 2023-02-07                       #
# author: Piotr Gludkowski, VillageTech        #
################################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTSettingUWPVoiceActivation : WTTweakBase {
    WTSettingUWPVoiceActivation() {
        $this.Name        = "SettingUWPVoiceActivation"
        $this.Alias       = "UWPVoiceActivation"
        $this.Description = "Access to voice activation from UWP apps."
        $this.AllowedOperations = [WTTweakActions]::Enable +
                                  [WTTweakActions]::Disable
        $this.Categories        = [WTTweakCategories]::System,
                                  [WTTweakCategories]::Security,
                                  [WTTweakCategories]::Performance,
                                  [WTTweakCategories]::Privacy,
                                  [WTTweakCategories]::UWP
    }

    [bool]EnableTweak() {
        # UWPVoiceActivation
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsActivateWithVoice" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsActivateWithVoiceAboveLock" -ErrorAction SilentlyContinue

        return $true
    }

    [bool]DisableTweak() {
        # UWPVoiceActivation
        [WTTweakBase]::CreateRegistryHive("HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsActivateWithVoice" -Type DWord -Value 2
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsActivateWithVoiceAboveLock" -Type DWord -Value 2

        return $true
    }
}
