###############################################
# WinTweaker WTSettingSmartScreenFilter class #
# created at: 2023-01-27                      #
# author: Piotr Gludkowski, VillageTech       #
###############################################

Using module .\WTTweakBase.psm1

class WTSettingSmartScreenFilter : WTTweakBase {
    WTSettingSmartScreenFilter() {
        $this.Name = "SettingSmartScreenFilter"
        $this.Alias = "SmartScreenFilter"
        $this.Description = "SmartScreen Filter"
        $this.AllowedOperations = @( "Enable", "Disable" )
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
	
        if (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter")) {
		    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" -Force | Out-Null
	    }
	    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" -Name "EnabledV9" -Type DWord -Value 0
        
        return $true
    }
}
