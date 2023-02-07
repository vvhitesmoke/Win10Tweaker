##################################################
# WinTweaker WTSettingTailoredExperiences class  #
# created at: 2023-01-29                         #
# author: Piotr Gludkowski, VillageTech          #
##################################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTSettingTailoredExperiences : WTTweakBase {
    WTSettingTailoredExperiences() {
        $this.Name        = "SettingTailoredExperiences"
        $this.Alias       = "TailoredExperiences"
        $this.Description = "Cloud content tailored experiences with diagnostic data"
        $this.AllowedOperations = [WTTweakActions]::Enable +
                                  [WTTweakActions]::Disable
        $this.Categories        = [WTTweakCategories]::System,
                                  [WTTweakCategories]::Privacy
    }

    [bool]EnableTweak() {
        # TailoredExperiences
        Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -ErrorAction SilentlyContinue

        return $true
    }

    [bool]DisableTweak() {
        # TailoredExperiences
    	[WTTweakBase]::CreateRegistryHive("HKCU:\Software\Policies\Microsoft\Windows\CloudContent")
        Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -Type DWord -Value 1

        return $true
    }
}
