##################################################
# WinTweaker WTFeatureBingHealthAndFitness class #
# created at: 2023-01-23                         #
# author: Piotr Gludkowski, VillageTech          #
##################################################

Using module .\WTTweakBase.psm1

class WTFeatureBingHealthAndFitness : WTTweakBase {
    WTFeatureBingHealthAndFitness() {
        $this.Name        = "BingHealthAndFitness"
        $this.Alias       = "HealthAndFitness"
        $this.Description = "Health & Fitness"
        $this.AllowedOperations = @( "Remove" )
    }

    [bool]RemoveTweak() {
        # BingHealthAndFitness
        Get-AppxPackage -AllUsers Microsoft.BingHealthAndFitness | Remove-AppxPackage
        return $true
    }
}
