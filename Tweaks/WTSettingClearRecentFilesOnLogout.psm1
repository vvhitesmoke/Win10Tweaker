######################################################
# WinTweaker WTSettingClearRecentFilesOnLogout class #
# created at: 2023-01-30                             #
# author: Piotr Gludkowski, VillageTech              #
######################################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTSettingClearRecentFilesOnLogout : WTTweakBase {
    WTSettingClearRecentFilesOnLogout() {
        $this.Name        = "SettingClearRecentFilesOnLogout"
        $this.Alias       = "ClearRecentFilesOnLogout"
        $this.Description = "Empties most recently used (MRU) items lists such as 'Recent Items' menu on the Start menu, jump lists, and shortcuts at the bottom of the 'File' menu in applications during every logout."
        $this.AllowedOperations = [WTTweakActions]::Enable +
                                  [WTTweakActions]::Disable
        $this.Categories        = [WTTweakCategories]::System,
                                  [WTTweakCategories]::Privacy
    }

    [bool]EnableTweak() {
        # ClearRecentFilesOnLogout
        [WTTweakBase]::CreateRegistryHive("HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer")
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "ClearRecentDocsOnExit" -Type DWord -Value 1

        return $true
    }

    [bool]DisableTweak() {
        # ClearRecentFilesOnLogout
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "ClearRecentDocsOnExit" -ErrorAction SilentlyContinue

        return $true
    }
}
