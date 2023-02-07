############################################
# WinTweaker WTSettingErrorReporting class #
# created at: 2023-02-07                   #
# author: Piotr Gludkowski, VillageTech    #
############################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTSettingErrorReporting : WTTweakBase {
    WTSettingErrorReporting() {
        $this.Name        = "SettingErrorReporting"
        $this.Alias       = "ErrorReporting"
        $this.Description = "Error reporting"
        $this.AllowedOperations = [WTTweakActions]::Enable +
                                  [WTTweakActions]::Disable
        $this.Categories        = [WTTweakCategories]::System,
                                  [WTTweakCategories]::Privacy,
                                  [WTTweakCategories]::Security
    }

    [bool]EnableTweak() {
        # ErrorReporting
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -ErrorAction SilentlyContinue
        Enable-ScheduledTask -TaskName "Microsoft\Windows\Windows Error Reporting\QueueReporting" | Out-Null

        return $true
    }

    [bool]DisableTweak() {
        # ErrorReporting
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Type DWord -Value 1
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Windows Error Reporting\QueueReporting" | Out-Null

        return $true
    }
}
