##################################################
# WinTweaker WTFeatureBingHealthAndFitness class #
# created at: 2023-01-23                         #
# author: Piotr Gludkowski, VillageTech          #
##################################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTFeatureBingHealthAndFitness : WTTweakBase {
    WTFeatureBingHealthAndFitness() {
        $this.Name        = "BingHealthAndFitness"
        $this.Alias       = "HealthAndFitness"
        $this.Description = "Health & Fitness"
        $this.AllowedOperations = [WTTweakActions]::Remove
        $this.Categories        = [WTTweakCategories]::BingApp
    }

    [bool]RemoveTweak() {
        # BingHealthAndFitness
        Get-AppxPackage -AllUsers Microsoft.BingHealthAndFitness | Remove-AppxPackage
        return $true
    }
}
