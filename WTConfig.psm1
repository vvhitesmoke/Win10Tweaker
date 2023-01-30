#########################################
# WinTweaker WTConfig class             #
# created at: 2023-01-29                #
# author: Piotr Gludkowski, VillageTech #
#########################################

Using module .\WTTweakerModes.psm1

class WTConfig {
    hidden static [WTTweakerModes]$_mode = [WTTweakerModes]::Error
    hidden static [string]$_name         = ""
    hidden static [string]$_param        = ""

    static [void] Initialize([string]$tweakName, [string]$operationName, [string]$recipeName, [string]$tweakRegex, [bool]$listMode) {
        [WTConfig]::_mode  = [WTTweakerModes]::Error
        [WTConfig]::_name  = ""
        [WTConfig]::_param = ""

        if ($tweakName -and $operationName) {

            if ($recipeName -or $tweakRegex -or $listMode) {
                return
            }

            [WTConfig]::_mode  = [WTTweakerModes]::Tweak
            [WTConfig]::_name  = $tweakName
            [WTConfig]::_param = $operationName

        } elseif ($recipeName) {

            if ($tweakName -or $operationName -or $tweakRegex -or $listMode) {
                return
            }

            [WTConfig]::_mode = [WTTweakerModes]::Recipe
            [WTConfig]::_name = $recipeName

        } elseif ($tweakRegex) {

            if ($tweakName -or $operationName -or $recipeName -or $listMode) {
                return
            }
            
            [WTConfig]::_mode = [WTTweakerModes]::Info
            [WTConfig]::_name = $tweakRegex

        } elseif ($listMode) {

            if ($tweakName -or $operationName -or $recipeName -or $tweakName) {
                return
            }

            [WTConfig]::_mode = [WTTweakerModes]::List        
        }
    }

    # getters

    static [WTTweakerModes] GetTweakerMode() {
        return [WTConfig]::_mode
    }

    static [string] GetName() {
        return [WTConfig]::_name
    }

    static [string] GetParam() {
        return [WTConfig]::_param
    }
}
