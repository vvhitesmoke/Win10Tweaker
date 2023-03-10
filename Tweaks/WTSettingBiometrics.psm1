#########################################
# WinTweaker WTSettingBiometrics class  #
# created at: 2023-01-29                #
# author: Piotr Gludkowski, VillageTech #
#########################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTSettingBiometrics : WTTweakBase {
    WTSettingBiometrics() {
        $this.Name        = "SettingBiometrics"
        $this.Alias       = "Biometrics"
        $this.Description = "Biometric features (fingerprint, Windows Hello etc.)"
        $this.AllowedOperations = [WTTweakActions]::Enable +
                                  [WTTweakActions]::Disable
        $this.Categories        = [WTTweakCategories]::System,
                                  [WTTweakCategories]::Privacy,
                                  [WTTweakCategories]::Security
    }

    [bool]EnableTweak() {
        # Biometrics
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Biometrics" -Name "Enabled" -ErrorAction SilentlyContinue

        return $true
    }

    [bool]DisableTweak() {
        # Biometrics
    	[WTTweakBase]::CreateRegistryHive("HKLM:\SOFTWARE\Policies\Microsoft\Biometrics")
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Biometrics" -Name "Enabled" -Type DWord -Value 0

        return $true
    }
}
