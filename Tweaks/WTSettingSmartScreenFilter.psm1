###############################################
# WinTweaker WTSettingSmartScreenFilter class #
# created at: 2023-01-27                      #
# author: Piotr Gludkowski, VillageTech       #
###############################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTSettingSmartScreenFilter : WTTweakBase {
    WTSettingSmartScreenFilter() {
        $this.Name = "SettingSmartScreenFilter"
        $this.Alias = "SmartScreenFilter"
        $this.Description = "SmartScreen anti-phishing filter"
        $this.AllowedOperations = [WTTweakActions]::Enable +
                                  [WTTweakActions]::Disable
        $this.Categories        = [WTTweakCategories]::System,
                                  [WTTweakCategories]::Privacy,
                                  [WTTweakCategories]::Security
    }

    [bool]EnableTweak() {
        # SmartScreenFilter
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableSmartScreen" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" -Name "EnabledV9" -ErrorAction SilentlyContinue

        return $true
    }

    [bool]DisableTweak() {
        # SmartScreenFilter
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableSmartScreen" -Type DWord -Value 0

        [WTTweakBase]::CreateRegistryHive("HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter")
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" -Name "EnabledV9" -Type DWord -Value 0

        return $true
    }
}
