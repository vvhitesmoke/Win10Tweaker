##############################################
# WinTweaker WTSettingAdvertisingInfo class  #
# created at: 2023-01-29                     #
# author: Piotr Gludkowski, VillageTech      #
##############################################

Using module .\WTTweakBase.psm1

class WTSettingAdvertisingInfo : WTTweakBase {
    WTSettingAdvertisingInfo() {
        $this.Name        = "SettingAdvertisingInfo"
        $this.Alias       = "AdvertisingInfo"
        $this.Description = "Advertising info (by group policy)"
        $this.AllowedOperations = @( "Enable", "Disable" )
    }

    [bool]EnableTweak() {
        # AdvertisingInfo
    	Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -ErrorAction SilentlyContinue
        
        return $true
    }

    [bool]DisableTweak() {
        # AdvertisingInfo
    	if (!(Test-Path "HKCU:\Software\Policies\Microsoft\Windows\CloudContent")) {
		    New-Item -Path "HKCU:\Software\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
    	}
	    Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -Type DWord -Value 1
        
        return $true
    }
}
