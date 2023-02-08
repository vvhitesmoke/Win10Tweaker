#########################################
# WinTweaker WTSettingUWPSwapFile class #
# created at: 2023-02-08                #
# author: Piotr Gludkowski, VillageTech #
#########################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTSettingUWPSwapFile : WTTweakBase {
    WTSettingUWPSwapFile() {
        $this.Name        = "SettingUWPSwapFile"
        $this.Alias       = "UWPSwapFile"
        $this.Description = " Creation and use of swapfile.sys."
        $this.AllowedOperations = [WTTweakActions]::Enable +
                                  [WTTweakActions]::Disable
        $this.Categories        = [WTTweakCategories]::System,
                                  [WTTweakCategories]::Security,
                                  [WTTweakCategories]::SpacePreservation,
                                  [WTTweakCategories]::SSDProtection,
                                  [WTTweakCategories]::Performance,
                                  [WTTweakCategories]::Privacy,
                                  [WTTweakCategories]::UWP
    }

    [bool]EnableTweak() {
        # UWPSwapFile
        Remove-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "SwapfileControl" -ErrorAction SilentlyContinue

        return $true
    }

    [bool]DisableTweak() {
        # UWPSwapFile
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "SwapfileControl" -Type Dword -Value 0

        return $true
    }
}
