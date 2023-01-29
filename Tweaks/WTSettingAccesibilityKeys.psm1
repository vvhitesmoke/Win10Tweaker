##############################################
# WinTweaker WTSettingAccesibilityKeys class #
# created at: 2023-01-27                     #
# author: Piotr Gludkowski, VillageTech      #
##############################################

Using module .\WTTweakBase.psm1

class WTSettingAccesibilityKeys : WTTweakBase {
    WTSettingAccesibilityKeys() {
        $this.Name        = "SettingAccesibilityKeys"
        $this.Alias       = "AccesibilityKeys"
        $this.Description = "Accesibility keys"
        $this.AllowedOperations = @( "Enable", "Disable" )
    }

    [bool]EnableTweak() {
        # AccesibilityKeys
        #Get-AppxPackage -AllUsers Microsoft.549981C3F5F10 | Remove-AppxPackage
        return $true
    }

    [bool]DisableTweak() {
        # AccesibilityKeys
        Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Type String -Value "506"
        Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\ToggleKeys" -Name "Flags" -Type String -Value "58"
        Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\Keyboard Response" -Name "Flags" -Type String -Value "122"
        return $true
    }
}
