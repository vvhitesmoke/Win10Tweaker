#########################################
# WinTweaker tweak class base           #
# created at: 2023-01-22                #
# author: Piotr Gludkowski, VillageTech #
#########################################

Using module ..\WTOut.psm1

class WTTweakBase {
    [ValidateNotNullOrEmpty()][string]$Name        = "Base"
    [ValidateNotNullOrEmpty()][string]$Alias       = "Base"
    [ValidateNotNullOrEmpty()][string]$Description = "Base"

    [string[]]$AllowedOperations = @()
    
    [bool] SwitchFeature([string]$Operation) {
        [bool]$ret = $false

        if (-not $this.AllowedOperations.Contains($Operation)) {
            [WTOut]::Error("Invalid operation: $Operation")
        }

        switch ($Operation) {
            "Enable" {
                $ret = $this.EnableFeature()
            }

            "Disable" {
                $ret = $this.DisableFeature()
            }

            "Remove" {
                $ret = $this.RemoveFeature()
            }
        }

        return $ret
    }

    [bool] EnableTweak() {
        [WTOut]::Fail("Method not implemented")
        return $false
    }

    [bool] DisableTweak() {
        [WTOut]::Fail("Method not implemented")
        return $false
    }

    [bool] RemoveTweak() {
        [WTOut]::Fail("Method not implemented")
        return $false
    }
}
