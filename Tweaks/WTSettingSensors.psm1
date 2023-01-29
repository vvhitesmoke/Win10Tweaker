#########################################
# WinTweaker WTSettingSensors class     #
# created at: 2023-01-29                #
# author: Piotr Gludkowski, VillageTech #
#########################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTSettingSensors : WTTweakBase {
    WTSettingSensors() {
        $this.Name        = "SettingSensors"
        $this.Alias       = "Sensors"
        $this.Description = "Sensors features, such as screen auto rotation"
        $this.AllowedOperations = [WTTweakActions]::Enable + [WTTweakActions]::Disable
    }

    [bool]EnableTweak() {
        # Sensors
    	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableSensors" -ErrorAction SilentlyContinue
        
        return $true
    }

    [bool]DisableTweak() {
        # Sensors
    	if (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors")) {
	    	New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Force | Out-Null
    	}
	    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableLocation" -Type DWord -Value 1
    	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableLocationScripting" -Type DWord -Value 1
        
        return $true
    }
}
