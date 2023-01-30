#########################################
# Win10Tweaker main script              #
# created at: 2023-01-22                #
# author: Piotr Gludkowski, VillageTech #
#########################################

Using module .\WTConfig.psm1
Using module .\WTExitCodes.psm1
Using module .\WTOut.psm1
Using module .\WTTweakerModes.psm1
Using module .\WTTweaksRepository.psm1

Using module .\Tweaks\WTTweakBase.psm1

#########################################

param ([string]$tweak, [string]$operation, [string]$recipe, [string]$info, [switch]$list, [switch]$silent, [switch]$verbose)

[WTConfig]::Initialize($tweak.Trim(), $operation.Trim(), $recipe.Trim(), $info.Trim(), $list)
[WTOut]::Initialize($verbose, $silent)

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
    [OutputType([string])]
    param (
        [Parameter(Mandatory)]
        [string]$recipeName
    )

    # check extension exists, add if needed
    if ($recipeName -notmatch "$RECIPES_FILE_NAME_EXTENSION$") {
        $recipeName += $RECIPES_FILE_NAME_EXTENSION
    }

    # make absolute path
    if (! [IO.Path]::IsPathRooted($recipeName)) {
        $recipeDir  = [IO.Path]::Combine($PSScriptRoot, $RECIPES_SUB_DIR)
        $recipeName = [IO.Path]::Combine($recipeDir, $recipeName)
    }

    [WTOut]::Trace("Recipe file to check: $recipeName`n")

    # check file exists
    if (! [IO.File]::Exists($recipeName)) {
        $recipeName = ""
    }

    $recipeName
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
  .\Win10Tweaker.ps1 -tweak <tweak_name> -operation <tweak_operation> [-verbose | -silent]
  .\Win10Tweaker.ps1 -recipe <recipe_name> [-verbose | -silent]
  .\Win10Tweaker.ps1 -list [-verbose]
  .\Win10Tweaker.ps1 -info <tweak_name_regex> [-verbose]

"@)
}

#########################################

# Main

[WTOut]::Print("`nWin10Tweaker v.$WT_VERSION, (c)VillageTech 2023`n")

[WTOut]::Trace("Mode: $([WTConfig]::GetTweakerMode())`n")

switch ([WTConfig]::GetTweakerMode()) {
    ([WTTweakerModes]::Tweak) {
    }

    ([WTTweakerModes]::Recipe) {
        [WTOut]::Trace("Name: $([WTConfig]::GetName())`n")

        [string]$recipeFile = (Resolve-WTRecipe "$([WTConfig]::GetName())")
        if (! $recipeFile) {
            [WTOut]::Error("Recipe: '$([WTConfig]::GetName())' does not exist!`n")
            Exit [WTExitCodes]::InvalidRecipe
        }

        Initialize-WTTweaks


    }

    ([WTTweakerModes]::List) {
        Initialize-WTTweaks

        [WTOut]::Print("List of registered tweaks:")
        [WTOut]::Print("--------------------------`n")

        [WTTweaksRepository]::ShowTweaksList()

        [WTOut]::Print("Total: $([WTTweaksRepository]::GetTweaksCount()) tweaks.`n")
    }

    ([WTTweakerModes]::Info) {
        Initialize-WTTweaks

        [WTOut]::Trace("Name: $([WTConfig]::GetName())`n")

        [WTTweakBase[]]$tweaks = [WTTweaksRepository]::GetMatchingTweaks([WTConfig]::GetName())
        if ($tweaks) {
            [WTOut]::Print("Found: $($tweaks.Length) matching tweaks.`n")
            [WTOut]::Print("List of matching tweaks:")
            [WTOut]::Print("------------------------`n")

            $tweaks.ForEach({
                [WTTweaksRepository]::ShowTweak($_)
            })
        } else {
            [WTOut]::Error("Can't find tweak matching to: '$([WTConfig]::GetName())'`n")
        }    
    }

    default {
        Show-WTUsage
        Exit [WTExitCodes]::ArgsError
    }
}

if ([WTOut]::GetErrorsCount() -gt 0) {
    [WTOut]::Info("Other errors count: $([WTOut]::GetErrorsCount())`n")
    Exit [WTExitCodes]::OtherError
} else {
    Exit [WTExitCodes]::Success
}

# EOF
