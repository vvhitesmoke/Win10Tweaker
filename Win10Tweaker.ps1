#########################################
# Win10Tweaker main script              #
# created at: 2023-01-22                #
# author: Piotr Gludkowski, VillageTech #
#########################################

Using module .\WTConfig.psm1
Using module .\WTExitCodes.psm1
Using module .\WTOut.psm1
Using module .\WTTweaksRepository.psm1

#########################################

param ([string]$recipe, [switch]$silent, [switch]$verbose, [switch]$list)

[WTConfig]::SetRecipeName($recipe.Trim())
[WTConfig]::SetSilentSwitch($silent)
[WTConfig]::SetVerboseSwitch($verbose)
[WTConfig]::SetListSwitch($list)

#########################################

New-Variable -Option Constant -Name WT_VERSION -Value "0.1"

New-Variable -Option Constant -Name TWEAK_MODULES_SUB_DIR   -Value "Tweaks"
New-Variable -Option Constant -Name TWEAK_MODULES_NAME_MASK -Value "WT*.psm1"
New-Variable -Option Constant -Name NO_TWEAK_MODULE_REGEX   -Value "WTTweak.*\.psm1"

New-Variable -Option Constant -Name RECIPES_SUB_DIR             -Value "Recipes"
New-Variable -Option Constant -Name RECIPES_FILE_NAME_EXTENSION -Value ".wtr"

#########################################

$Env:PSModulePath = $Env:PSModulePath + ";" + $PSScriptRoot

Import-Module -Force -Name ./WTTweaksRepository.psm1

#########################################

function Resolve-WTRecipe {
    [string]$recipeName = [WTConfig]::GetRecipeName()

    # check extension exists, add if needed
    if ($recipeName -notmatch "$RECIPES_FILE_NAME_EXTENSION$") {
        $recipeName += $RECIPES_FILE_NAME_EXTENSION
    }

    # make absolute path

    # check file exists

}

function Initialize-WTTweaks {
    [WTOut]::Print("Registering tweaks...")

    [WTTweaksRepository]::Initialize()
    Get-ChildItem -Path "$PSScriptRoot\$TWEAK_MODULES_SUB_DIR" -Filter $TWEAK_MODULES_NAME_MASK -File -Name | ForEach-Object {
        if ($_ -notmatch "$NO_TWEAK_MODULE_REGEX$") {
            $moduleName = [IO.Path]::GetFileNameWithoutExtension($_)
            [WTTweaksRepository]::RegisterTweakModule($TWEAK_MODULES_SUB_DIR, $moduleName)
        }
    }

    [WTOut]::Print("Registered: $([WTTweaksRepository]::GetTweaksCount()) tweaks.`n")
}

function Show-WTUsage {
    [WTOut]::Print(@"
Usage:
  .\Win10Tweaker.ps1 [-recipe] <recipe_name> [-verbose | -silent]
  .\Win10Tweaker.ps1 -list [-verbose]

"@)
}

#########################################

# Main

[WTOut]::Initialize()

[WTOut]::Print("`nWin10Tweaker v.$WT_VERSION, (c)VillageTech 2023`n")

[WTOut]::Trace("Verbose: $([WTConfig]::GetVerboseSwitch())")

if (! [WTConfig]::GetListSwitch()) {
    [WTOut]::Trace("Recipe : $([WTConfig]::GetRecipeName())")
    
    if (! [bool][WTConfig]::GetRecipeName()) {
        Show-WTUsage
        Exit [WTExitCodes]::ArgsError
    }

    Resolve-WTRecipe "$([WTConfig]::GetRecipeName())"
    if (! [WTConfig]::GetIsValid) {
        [WTOut]::Error("Recipe: $([WTConfig]::GetRecipeName()) does not exist!")
        Exit [WTExitCodes]::InvalidRecipe
    }
}

Initialize-WTTweaks

if ([WTConfig]::GetListSwitch()) {
    [WTOut]::Print("List of registered tweaks:")
    [WTOut]::Print("--------------------------`n")

    [WTTweaksRepository]::ShowTweaksList()

    [WTOut]::Print("Total: $([WTTweaksRepository]::GetTweaksCount()) tweaks.`n")
} else {







}

if ([WTOut]::GetErrorsCount() -gt 0) {
    [WTOut]::Print("`nOther errors count: $([WTOut]::GetErrorsCount())`n")
    Exit [WTExitCodes]::OtherError
} else {
    Exit [WTExitCodes]::Success
}

# EOF
