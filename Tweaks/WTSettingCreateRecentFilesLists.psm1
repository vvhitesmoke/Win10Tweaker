####################################################
# WinTweaker WTSettingCreateRecentFilesLists class #
# created at: 2023-01-30                           #
# author: Piotr Gludkowski, VillageTech            #
####################################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTSettingCreateRecentFilesLists : WTTweakBase {
    WTSettingCreateRecentFilesLists() {
        $this.Name        = "SettingCreateRecentFilesLists"
        $this.Alias       = "CreateRecentFilesLists"
        $this.Description = "Creating most recently used (MRU) items lists such as 'Recent Items' menu on the Start menu, jump lists, and shortcuts at the bottom of the 'File' menu in applications."
        $this.AllowedOperations = [WTTweakActions]::Enable +
                                  [WTTweakActions]::Disable
        $this.Categories        = [WTTweakCategories]::System,
                                  [WTTweakCategories]::Privacy
    }

    [bool]EnableTweak() {
        # CreateRecentFilesLists
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoRecentDocsHistory" -ErrorAction SilentlyContinue
        
        return $true
    }

    [bool]DisableTweak() {
        # CreateRecentFilesLists
        [WTTweakBase]::CreateRegistryHive("HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer")
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoRecentDocsHistory" -Type DWord -Value 1

        return $true
    }
}
