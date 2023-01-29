##############################################
# WinTweaker WTFeatureBingFoodAndDrink class #
# created at: 2023-01-22                     #
# author: Piotr Gludkowski, VillageTech      #
##############################################

Using module .\WTTweakBase.psm1

class WTFeatureBingFoodAndDrink : WTTweakBase {
    WTFeatureBingFoodAndDrink() {
        $this.Name        = "BingFoodAndDrink"
        $this.Alias       = "FoodAndDrink"
        $this.Description = "Food & Drink"
        $this.AllowedOperations = @( "Remove" )
    }

    [bool]RemoveTweak() {
        # BingFoodAndDrink
        Get-AppxPackage -AllUsers Microsoft.BingFoodAndDrink | Remove-AppxPackage
        return $true
    }
}
