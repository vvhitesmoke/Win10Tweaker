﻿#####################################################
# WinTweaker WTSettingUWPSyncWithOtherDevices class #
# created at: 2023-02-08                            #
# author: Piotr Gludkowski, VillageTech             #
#####################################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTSettingUWPSyncWithOtherDevices : WTTweakBase {
    WTSettingUWPSyncWithOtherDevices() {
        $this.Name        = "SettingUWPSyncWithOtherDevices"
        $this.Alias       = "UWPSyncWithOtherDevices"
        $this.Description = "Access to other devices (unpaired, beacons, TVs etc.) from UWP apps."
        $this.AllowedOperations = [WTTweakActions]::Enable +
                                  [WTTweakActions]::Disable
        $this.Categories        = [WTTweakCategories]::System,
                                  [WTTweakCategories]::Security,
                                  [WTTweakCategories]::Privacy,
                                  [WTTweakCategories]::UWP
    }

    [bool]EnableTweak() {
        # UWPSyncWithOtherDevices
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsSyncWithDevices" -ErrorAction SilentlyContinue

        return $true
    }

    [bool]DisableTweak() {
        # UWPSyncWithOtherDevices
        [WTTweakBase]::CreateRegistryHive("HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsSyncWithDevices" -Type DWord -Value 2

        return $true
    }
}
