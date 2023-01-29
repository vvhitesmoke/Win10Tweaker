#########################################
# WinTweaker WTSettingMapUpdates class  #
# created at: 2023-01-29                #
# author: Piotr Gludkowski, VillageTech #
#########################################

Using module .\WTTweakBase.psm1

class WTSettingMapUpdates : WTTweakBase {
    WTSettingMapUpdates() {
        $this.Name        = "SettingMapUpdates"
        $this.Alias       = "MapUpdates"
        $this.Description = "Automatic Maps updates"
        $this.AllowedOperations = @( "Enable", "Disable" )
    }

    [bool]EnableTweak() {
        # MapUpdates
    	Remove-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -ErrorAction SilentlyContinue
        
        return $true
    }

    [bool]DisableTweak() {
        # MapUpdates
    	Set-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -Type DWord -Value 0
        
        return $true
    }
}
