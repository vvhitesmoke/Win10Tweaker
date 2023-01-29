##################################################
# WinTweaker WTSettingTailoredExperiences class  #
# created at: 2023-01-29                         #
# author: Piotr Gludkowski, VillageTech          #
##################################################

Using module .\WTTweakBase.psm1

class WTSettingTailoredExperiences : WTTweakBase {
    WTSettingTailoredExperiences() {
        $this.Name        = "SettingTailoredExperiences"
        $this.Alias       = "TailoredExperiences"
        $this.Description = "Cloud content tailored experiences with diagnostic data"
        $this.AllowedOperations = @( "Enable", "Disable" )
    }

    [bool]EnableTweak() {
        # TailoredExperiences
    	Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -ErrorAction SilentlyContinue
        
        return $true
    }

    [bool]DisableTweak() {
        # TailoredExperiences
    	if (!(Test-Path "HKCU:\Software\Policies\Microsoft\Windows\CloudContent")) {
		    New-Item -Path "HKCU:\Software\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
    	}
	    Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -Type DWord -Value 1
        
        return $true
    }
}
