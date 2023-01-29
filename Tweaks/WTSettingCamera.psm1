#########################################
# WinTweaker WTSettingCamera class      #
# created at: 2023-01-29                #
# author: Piotr Gludkowski, VillageTech #
#########################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTSettingCamera : WTTweakBase {
    WTSettingCamera() {
        $this.Name        = "SettingCamera"
        $this.Alias       = "Camera"
        $this.Description = "Access to camera"
        $this.AllowedOperations = [WTTweakActions]::Enable + [WTTweakActions]::Disable
    }

    [bool]EnableTweak() {
        # Camera
    	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessCamera" -ErrorAction SilentlyContinue
        
        return $true
    }

    [bool]DisableTweak() {
        # Camera
    	if (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
	    	New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
    	}
	    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessCamera" -Type DWord -Value 2
        
        return $true
    }
}
