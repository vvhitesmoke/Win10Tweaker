#########################################
# WinTweaker WTFeatureCortana class     #
# created at: 2023-01-22                #
# author: Piotr Gludkowski, VillageTech #
#########################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTFeatureCortana : WTTweakBase {
    WTFeatureCortana() {
        $this.Name        = "FeatureCortana"
        $this.Alias       = "Cortana"
        $this.Description = "Cortana appliaction"
        $this.AllowedOperations = [WTTweakActions]::Remove
        $this.Categories        = [WTTweakCategories]::System,
                                  [WTTweakCategories]::Privacy
    }

    [bool]RemoveTweak() {
        # Cortana
        [WTTweakBase]::CreateRegistryHive("HKCU:\Software\Microsoft\Personalization\Settings")
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Type DWord -Value 0

        [WTTweakBase]::CreateRegistryHive("HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore")
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Type DWord -Value 0

        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Type DWord -Value 0

        Set-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\Experience\AllowCortana" -Name "Value" -Type DWord -Value 0

        [WTTweakBase]::CreateRegistryHive("HKLM:\Software\Policies\Microsoft\Windows\Windows Search")
        Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Type DWord -Value 0

        [WTTweakBase]::CreateRegistryHive("HKLM:\Software\Policies\Microsoft\InputPersonalization")
        Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\InputPersonalization" -Name "AllowInputPersonalization" -Type DWord -Value 0

        [WTTweakBase]::RemoveAppxPackage("Microsoft.549981C3F5F10")

        return $true
    }
}
