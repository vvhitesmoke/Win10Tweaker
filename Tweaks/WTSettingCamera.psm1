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
        $this.AllowedOperations = [WTTweakActions]::Enable +
                                  [WTTweakActions]::Disable
        $this.Categories        = [WTTweakCategories]::System,
                                  [WTTweakCategories]::Privacy,
                                  [WTTweakCategories]::Security
    }

    [bool]EnableTweak() {
        # Camera
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessCamera" -ErrorAction SilentlyContinue

        return $true
    }

    [bool]DisableTweak() {
        # Camera
    	[WTTweakBase]::CreateRegistryHive("HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessCamera" -Type DWord -Value 2

        return $true
    }
}
