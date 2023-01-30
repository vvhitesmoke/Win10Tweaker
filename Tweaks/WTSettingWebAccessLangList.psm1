###############################################
# WinTweaker WTSettingWebAccessLangList class #
# created at: 2023-01-29                      #
# author: Piotr Gludkowski, VillageTech       #
###############################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTSettingWebAccessLangList : WTTweakBase {
    WTSettingWebAccessLangList() {
        $this.Name        = "SettingWebAccessLangList"
        $this.Alias       = "WebAccessLangList"
        $this.Description = "Website Access to Language List"
        $this.AllowedOperations = [WTTweakActions]::Enable + [WTTweakActions]::Disable
        $this.Categories        = [WTTweakCategories]::System,
                                  [WTTweakCategories]::Privacy,
                                  [WTTweakCategories]::Security,
                                  [WTTweakCategories]::Web
    }

    [bool]EnableTweak() {
        # WebAccessLangList
    	Remove-ItemProperty -Path "HKCU:\Control Panel\International\User Profile" -Name "HttpAcceptLanguageOptOut" -ErrorAction SilentlyContinue
        
        return $true
    }

    [bool]DisableTweak() {
        # WebAccessLangList
    	Set-ItemProperty -Path "HKCU:\Control Panel\International\User Profile" -Name "HttpAcceptLanguageOptOut" -Type DWord -Value 1
        
        return $true
    }
}
