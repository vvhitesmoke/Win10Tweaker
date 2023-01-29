#########################################
# WinTweaker WTSettingMicrophone class  #
# created at: 2023-01-29                #
# author: Piotr Gludkowski, VillageTech #
#########################################

Using module .\WTTweakBase.psm1

class WTSettingMicrophone : WTTweakBase {
    WTSettingMicrophone() {
        $this.Name        = "SettingMicrophone"
        $this.Alias       = "Microphone"
        $this.Description = "Access to microphone"
        $this.AllowedOperations = @( "Enable", "Disable" )
    }

    [bool]EnableTweak() {
        # Microphone
    	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessMicrophone" -ErrorAction SilentlyContinue
        
        return $true
    }

    [bool]DisableTweak() {
        # Microphone
	    if (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
		    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
    	}
	    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessMicrophone" -Type DWord -Value 2
        
        return $true
    }
}
