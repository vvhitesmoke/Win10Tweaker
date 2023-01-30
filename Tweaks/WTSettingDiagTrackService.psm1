##############################################
# WinTweaker WTSettingDiagTrackService class #
# created at: 2023-01-30                     #
# author: Piotr Gludkowski, VillageTech      #
##############################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTSettingDiagTrackService : WTTweakBase {
    WTSettingDiagTrackService() {
        $this.Name        = "SettingDiagTrackService"
        $this.Alias       = "DiagTrackService"
        $this.Description = "Connected User Experiences and Telemetry (previously named Diagnostics Tracking Service)."
        $this.AllowedOperations = [WTTweakActions]::Enable + [WTTweakActions]::Disable
        $this.Categories        = [WTTweakCategories]::System,
                                  [WTTweakCategories]::Privacy, 
                                  [WTTweakCategories]::Performance
    }

    [bool]EnableTweak() {
        # DiagTrackService
    	Set-Service "DiagTrack" -StartupType Automatic
	    Start-Service "DiagTrack" -WarningAction SilentlyContinue
        
        return $true
    }

    [bool]DisableTweak() {
        # DiagTrackService
    	Stop-Service "DiagTrack" -WarningAction SilentlyContinue
	    Set-Service "DiagTrack" -StartupType Disabled
        
        return $true
    }
}
