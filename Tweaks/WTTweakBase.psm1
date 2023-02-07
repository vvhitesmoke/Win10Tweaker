#########################################
# WinTweaker tweak class base           #
# created at: 2023-01-22                #
# author: Piotr Gludkowski, VillageTech #
#########################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakCategories.psm1
Using module ..\WTOut.psm1

class WTTweakBase {
    [ValidateNotNullOrEmpty()][string]$Name        = "Base"
    [ValidateNotNullOrEmpty()][string]$Alias       = "Base"
    [ValidateNotNullOrEmpty()][string]$Description = "Base"

    [WTTweakActions]$AllowedOperations = [WTTweakActions]::None
    [WTTweakCategories[]]$Categories = [WTTweakCategories]::Unknown
    
    [bool] PerformTweakOperation([string]$Operation) {
        [bool]$ret = $false
        [WTTweakActions]$action = $this.GetOperationFromString($Operation)

        [WTOut]::Trace("Operation: '$action'")

        switch ($action) {
            ([WTTweakActions]::Enable) {
                $ret = $this.EnableTweak()
            }

            ([WTTweakActions]::Disable) {
                $ret = $this.DisableTweak()
            }

            ([WTTweakActions]::Remove) {
                $ret = $this.RemoveTweak()
            }

            default {
                [WTOut]::Error("Invalid operation: '$Operation'")
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

    static [void] RemoveAppxPackage([string]$package) {
        Get-AppxPackage -AllUsers $package | Remove-AppxPackage
    }

    static [void] CreateRegistryHive([string]$hive) {
    	if (!(Test-Path $hive)) {
		    New-Item -Path $hive -Force | Out-Null
    	}
    }

    hidden [WTTweakActions] GetOperationFromString([string]$operationName) {
        [WTTweakActions]$action = [WTTweakActions]::None
        [string[]]$operations = (([string]$this.AllowedOperations) -split ',').Trim()
        if ($operationName -in $operations) {
            $action = [WTTWeakActions]$operationName
        }

        return $action
    }
}
