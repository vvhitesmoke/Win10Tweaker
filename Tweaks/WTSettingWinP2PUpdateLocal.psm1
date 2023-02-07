###############################################
# WinTweaker WTSettingWinP2PUpdateLocal class #
# created at: 2023-01-30                      #
# author: Piotr Gludkowski, VillageTech       #
###############################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTSettingWinP2PUpdateLocal : WTTweakBase {
    WTSettingWinP2PUpdateLocal() {
        $this.Name        = "SettingWinP2PUpdateLocal"
        $this.Alias       = "WinP2PUpdateLocal"
        $this.Description = "Windows Update P2P delivery optimization to computers in local network (default since 1703)"
        $this.AllowedOperations = [WTTweakActions]::Enable +
                                  [WTTweakActions]::Disable
        $this.Categories        = [WTTweakCategories]::System,
                                  [WTTweakCategories]::SSDProtection,
                                  [WTTweakCategories]::SpacePreservation,
                                  [WTTweakCategories]::Security
    }

    [bool]EnableTweak() {
        # WinP2PUpdateLocal
        if ([System.Environment]::OSVersion.Version.Build -eq 10240) {
            # Method used in 1507
            [WTTWeakBase]::CreateRegistryHive("HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config")
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Name "DODownloadMode" -Type DWord -Value 1
        } elseif ([System.Environment]::OSVersion.Version.Build -le 14393) {
            # Method used in 1511 and 1607
            [WTTWeakBase]::CreateRegistryHive("HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization")
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" -Name "DODownloadMode" -Type DWord -Value 1
        } else {
            # Method used since 1703
            Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" -Name "DODownloadMode" -ErrorAction SilentlyContinue
        }

        return $true
    }

    [bool]DisableTweak() {
        # WinP2PUpdateLocal
        if ([System.Environment]::OSVersion.Version.Build -eq 10240) {
            # Method used in 1507
            [WTTWeakBase]::CreateRegistryHive("HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config")
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Name "DODownloadMode" -Type DWord -Value 0
        } else {
            # Method used since 1511
            [WTTWeakBase]::CreateRegistryHive("HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization")
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" -Name "DODownloadMode" -Type DWord -Value 100
        }

        return $true
    }
}
