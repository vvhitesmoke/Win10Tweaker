###############################################
# WinTweaker WTSettingUWPBackgroundApps class #
# created at: 2023-02-07                      #
# author: Piotr Gludkowski, VillageTech       #
###############################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTSettingUWPBackgroundApps : WTTweakBase {
    WTSettingUWPBackgroundApps() {
        $this.Name        = "SettingUWPBackgroundApps"
        $this.Alias       = "UWPBackgroundApps"
        $this.Description = "UWP apps background access (if UWP apps can download data or update themselves when they aren't used)."
        $this.AllowedOperations = [WTTweakActions]::Enable +
                                  [WTTweakActions]::Disable
        $this.Categories        = [WTTweakCategories]::System,
                                  [WTTweakCategories]::Performance,
                                  [WTTweakCategories]::Privacy,
                                  [WTTweakCategories]::UWP
    }

    [bool]EnableTweak() {
        # UWPBackgroundApps
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsRunInBackground" -ErrorAction SilentlyContinue
        Get-ChildItem -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" | ForEach-Object {
            Remove-ItemProperty -Path $_.PsPath -Name "Disabled" -ErrorAction SilentlyContinue
            Remove-ItemProperty -Path $_.PsPath -Name "DisabledByUser" -ErrorAction SilentlyContinue
        }

        return $true
    }

    [bool]DisableTweak() {
        # UWPBackgroundApps
        if ([System.Environment]::OSVersion.Version.Build -ge 17763) {
            [WTTweakBase]::CreateRegistryHive("HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsRunInBackground" -Type DWord -Value 2
        } else {
            Get-ChildItem -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Exclude "Microsoft.Windows.Cortana*", "Microsoft.Windows.ShellExperienceHost*" | ForEach-Object {
                Set-ItemProperty -Path $_.PsPath -Name "Disabled" -Type DWord -Value 1
                Set-ItemProperty -Path $_.PsPath -Name "DisabledByUser" -Type DWord -Value 1
            }
        }

        return $true
    }
}
