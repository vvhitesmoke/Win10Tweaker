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
    }

    [bool]RemoveTweak() {
        # Cortana
    	if (!(Test-Path "HKCU:\Software\Microsoft\Personalization\Settings")) {
	    	New-Item -Path "HKCU:\Software\Microsoft\Personalization\Settings" -Force | Out-Null
    	}
	    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Type DWord -Value 0

    	if (!(Test-Path "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore")) {
	    	New-Item -Path "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore" -Force | Out-Null
    	}
	    Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Type DWord -Value 1
    	Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Type DWord -Value 1
	    Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Type DWord -Value 0

    	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Type DWord -Value 0

	    Set-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\Experience\AllowCortana" -Name "Value" -Type DWord -Value 0

    	if (!(Test-Path "HKLM:\Software\Policies\Microsoft\Windows\Windows Search")) {
	    	New-Item -Path "HKLM:\Software\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null
    	}
	    Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Type DWord -Value 0

    	if (!(Test-Path "HKLM:\Software\Policies\Microsoft\InputPersonalization")) {
	    	New-Item -Path "HKLM:\Software\Policies\Microsoft\InputPersonalization" -Force | Out-Null
    	}
	    Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\InputPersonalization" -Name "AllowInputPersonalization" -Type DWord -Value 0

        Get-AppxPackage -AllUsers Microsoft.549981C3F5F10 | Remove-AppxPackage

        return $true
    }
}
