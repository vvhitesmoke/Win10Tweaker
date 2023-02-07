#########################################
# WinTweaker WTSettingMapUpdates class  #
# created at: 2023-01-29                #
# author: Piotr Gludkowski, VillageTech #
#########################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTSettingMapUpdates : WTTweakBase {
    WTSettingMapUpdates() {
        $this.Name        = "SettingMapUpdates"
        $this.Alias       = "MapUpdates"
        $this.Description = "Automatic Maps updates"
        $this.AllowedOperations = [WTTweakActions]::Enable +
                                  [WTTweakActions]::Disable
        $this.Categories        = [WTTweakCategories]::WindowsApp,
                                  [WTTweakCategories]::SpacePreservation
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
