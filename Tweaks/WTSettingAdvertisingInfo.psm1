##############################################
# WinTweaker WTSettingAdvertisingInfo class  #
# created at: 2023-01-29                     #
# author: Piotr Gludkowski, VillageTech      #
##############################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTSettingAdvertisingInfo : WTTweakBase {
    WTSettingAdvertisingInfo() {
        $this.Name        = "SettingAdvertisingInfo"
        $this.Alias       = "AdvertisingInfo"
        $this.Description = "Advertising info (by group policy)"
        $this.AllowedOperations = [WTTweakActions]::Enable +
                                  [WTTweakActions]::Disable
        $this.Categories        = [WTTweakCategories]::System,
                                  [WTTweakCategories]::Privacy
    }

    [bool]EnableTweak() {
        # AdvertisingInfo
        Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -ErrorAction SilentlyContinue

        return $true
    }

    [bool]DisableTweak() {
        # AdvertisingInfo
        [WTTweakBase]::CreateRegistryHive("HKCU:\Software\Policies\Microsoft\Windows\CloudContent")
        Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -Type DWord -Value 1

        return $true
    }
}
