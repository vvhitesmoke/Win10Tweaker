###################################################
# WinTweaker WTSettingWindowsErrorReporting class #
# created at: 2023-01-29                          #
# author: Piotr Gludkowski, VillageTech           #
###################################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTSettingWindowsErrorReporting : WTTweakBase {
    WTSettingWindowsErrorReporting() {
        $this.Name        = "SettingWindowsErrorReporting"
        $this.Alias       = "WindowsErrorReporting"
        $this.Description = "Windows error reporting"
        $this.AllowedOperations = [WTTweakActions]::Enable + [WTTweakActions]::Disable
        $this.Categories        = [WTTweakCategories]::System,
                                  [WTTweakCategories]::Privacy
    }

    [bool]EnableTweak() {
        # WindowsErrorReporting
    	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -ErrorAction SilentlyContinue
	    Enable-ScheduledTask -TaskName "Microsoft\Windows\Windows Error Reporting\QueueReporting" | Out-Null
        
        return $true
    }

    [bool]DisableTweak() {
        # WindowsErrorReporting
    	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Type DWord -Value 1
	    Disable-ScheduledTask -TaskName "Microsoft\Windows\Windows Error Reporting\QueueReporting" | Out-Null
        
        return $true
    }
}
