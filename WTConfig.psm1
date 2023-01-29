#########################################
# WinTweaker WTConfig class             #
# created at: 2023-01-29                #
# author: Piotr Gludkowski, VillageTech #
#########################################

class WTConfig {
    hidden static [bool]$_isValid = $false
    hidden static [bool]$_verbose = $false
    hidden static [bool]$_silent  = $true
    hidden static [bool]$_list    = $false

    hidden static [string]$_recipeName     = ""
    hidden static [string]$_recipeFileName = ""

    # setters

    static [void] SetIsValid([bool]$isValid) {
        [WTConfig]::_isValid = $isValid
    }

    static [void] SetVerboseSwitch([bool]$verbose) {
        [WTConfig]::_verbose = $verbose
    }

    static [void] SetSilentSwitch([bool]$silent) {
        [WTConfig]::_silent = $silent
    }

    static [void] SetListSwitch([bool]$list) {
        [WTConfig]::_list = $list
    }

    static [void] SetRecipeName([string]$recipeName) {
        [WTConfig]::_recipeName = $recipeName
    }

    static [void] SetRecipeFileName([string]$recipeFileName) {
        [WTConfig]::_recipeFileName = $recipeFileName
    }

    # getters

    static [bool] GetIsValid() {
        return [WTConfig]::_isValid
    }

    static [bool] GetVerboseSwitch() {
        return [WTConfig]::_verbose -and ! [WTConfig]::_silent
    }

    static [bool] GetSilentSwitch() {
        return [WTConfig]::_silent
    }

    static [bool] GetListSwitch() {
        return [WTConfig]::_list
    }

    static [string] GetRecipeName() {
        return [WTConfig]::_recipeName
    }

    static [string] GetRecipeFileName() {
        return [WTConfig]::_recipeFileName
    }
}
