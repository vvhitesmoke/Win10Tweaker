#########################################
# WinTweaker WTSettingWebSearch class   #
# created at: 2023-01-27                #
# author: Piotr Gludkowski, VillageTech #
#########################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTSettingWebSearch : WTTweakBase {
    WTSettingWebSearch() {
        $this.Name = "SettingWebSearch"
        $this.Alias = "WebSearch"
        $this.Description = "Bing Web Search in Start Menu"
        $this.AllowedOperations = [WTTweakActions]::Enable + [WTTweakActions]::Disable
    }

    [bool]EnableTweak() {
        # WebSearchInStartMenu
    	Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -Type DWord -Value 1
    	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "DisableWebSearch" -ErrorAction SilentlyContinue
        
        return $true
    }

    [bool]DisableTweak() {
        # WebSearchInStartMenu
    	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -Type DWord -Value 0

        if (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "DisableWebSearch" -Type DWord -Value 1
        
        return $true
    }
}
