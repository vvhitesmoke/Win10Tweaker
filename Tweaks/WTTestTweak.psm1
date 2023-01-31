#########################################
# WinTweaker WTTestTweak class          #
# created at: 2023-01-31                #
# author: Piotr Gludkowski, VillageTech #
#########################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

Using module ..\WTOut.psm1

class WTTestTweak : WTTweakBase {
    WTTestTweak() {
        $this.Name        = "TestTweak"
        $this.Alias       = "Test"
        $this.Description = "Test."
        $this.AllowedOperations = [WTTweakActions]::Enable + [WTTweakActions]::Disable + [WTTweakActions]::Remove
        $this.Categories        = [WTTweakCategories]::Test
    }

    [bool]EnableTweak() {
        # Test

        [WTOut]::Info("EnableTweak() called.");
        
        return $true
    }

    [bool]DisableTweak() {
        # Test
        
        [WTOut]::Info("DisableTweak() called.");
        
        return $true
    }

    [bool]RemoveTweak() {
        # Test
        
        [WTOut]::Info("RemoveTweak() called.");
        
        return $false
    }
}
