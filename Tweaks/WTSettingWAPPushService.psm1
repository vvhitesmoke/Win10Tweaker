##############################################
# WinTweaker WTSettingWAPPushService class #
# created at: 2023-01-30                     #
# author: Piotr Gludkowski, VillageTech      #
##############################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTSettingWAPPushService : WTTweakBase {
    WTSettingWAPPushService() {
        $this.Name        = "SettingWAPPushService"
        $this.Alias       = "WAPPushService"
        $this.Description = "Device Management Wireless Application Protocol (WAP) Push Service (NOTE: needed for Microsoft Intune interoperability)."
        $this.AllowedOperations = [WTTweakActions]::Enable +
                                  [WTTweakActions]::Disable
        $this.Categories        = [WTTweakCategories]::System,
                                  [WTTweakCategories]::Privacy,
                                  [WTTweakCategories]::Performance,
                                  [WTTweakCategories]::WiFi
    }

    [bool]EnableTweak() {
        # WAPPushService
        Set-Service "dmwappushservice" -StartupType Automatic
        Start-Service "dmwappushservice" -WarningAction SilentlyContinue
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\dmwappushservice" -Name "DelayedAutoStart" -Type DWord -Value 1

        return $true
    }

    [bool]DisableTweak() {
        # WAPPushService
        Stop-Service "dmwappushservice" -WarningAction SilentlyContinue
        Set-Service "dmwappushservice" -StartupType Disabled

        return $true
    }
}
