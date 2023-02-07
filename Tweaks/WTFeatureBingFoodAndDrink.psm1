##############################################
# WinTweaker WTFeatureBingFoodAndDrink class #
# created at: 2023-01-22                     #
# author: Piotr Gludkowski, VillageTech      #
##############################################

Using module .\WTTweakActions.psm1
Using module .\WTTweakBase.psm1
Using module .\WTTweakCategories.psm1

class WTFeatureBingFoodAndDrink : WTTweakBase {
    WTFeatureBingFoodAndDrink() {
        $this.Name        = "BingFoodAndDrink"
        $this.Alias       = "FoodAndDrink"
        $this.Description = "Food & Drink"
        $this.AllowedOperations = [WTTweakActions]::Remove
        $this.Categories        = [WTTweakCategories]::BingApp
    }

    [bool]RemoveTweak() {
        # BingFoodAndDrink
        [WTTweakBase]::RemoveAppxPackage("Microsoft.BingFoodAndDrink")

        return $true
    }
}
