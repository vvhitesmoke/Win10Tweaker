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
    
    [bool] SwitchFeature([string]$Operation) {
        [bool]$ret = $false
        [WTTweakActions]$action = $this.GetOperationFromString($Operation)
        switch ($action) {
            [WTTweakActions]::Enable {
                $ret = $this.EnableFeature()
            }

            [WTTweakActions]::Disable {
                $ret = $this.DisableFeature()
            }

            [WTTweakActions]::Remove {
                $ret = $this.RemoveFeature()
            }

            default {
                [WTOut]::Error("Invalid operation: $Operation")
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

    hidden [WTTweakActions] GetOperationFromString([string]$operationName) {
        [WTTweakActions]$operation = [WTTweakActions]::None
        if (([string[]]$this.AllowedOperations).Contains($operationName)) {
            $operation = [WTTWeakActions]$operationName
        }

        return $operation
    }
}
