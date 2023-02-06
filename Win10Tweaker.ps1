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

function Use-WTRecipe {
    [OutputType([int])]
    param (
        [Parameter(Mandatory)]
        [string]$recipeFile
    )

    [WTOut]::Info("Processing recipe file: '$recipeFile'...`n")

    [int]$result   = [WTExitCodes]::Success
    [int]$lineCtr  = 0
    [int]$tweakCtr = 0

    foreach($line in Get-Content $recipeFile) {
        $lineCtr++

        # remove comments
        [string[]]$items = $line -split '#'
        [string]$tweak = $items[0].Trim()

        # ignore empty or comment-only lines
        if (! $tweak) {
            continue
        }

        [WTOut]::Trace("Tweak: $tweak")

        $items = ($tweak -split ':').Trim()
        if ($items.Count -ne 2) {
            [WTOut]::Error("Invalid line format: [$lineCtr] '$line'`n")
            $result = [WTExitCodes]::RecipeFormatError
            break
        }

        [WTOut]::Trace("Tweak items: $items`n")

        [string]$tweakName      = $items[0]
        [string]$tweakOperation = $items[1]

        if (! $tweakName) {
            [WTOut]::Error("Tweak name can't be empty, line: [$lineCtr] '$line'`n")
            $result = [WTExitCodes]::RecipeFormatError
            break
        }

        if (! $tweakOperation) {
            [WTOut]::Error("Tweak operation can't be empty, line: [$lineCtr] '$line'`n")
            $result = [WTExitCodes]::InvalidOperation
            break
        }

        $result = (Use-WTTweak $tweakName $tweakOperation)
        if (! $result) {
            break
        }
    }

    $result
}

function Use-WTTweak {
    [OutputType([int])]
    param (
        [Parameter(Mandatory)]
        [string]$tweakName,

        [Parameter(Mandatory)]
        [string]$tweakOperation
    )

    [int]$result = [WTExitCodes]::Success

    if (Test-IsAdmin) {
        [WTTweakBase]$tweak = [WTTweaksRepository]::GetTweak($tweakName)
        if ($tweak) {
            [bool]$tweakResult = $tweak.PerformTweakOperation($tweakOperation)
            if ($tweakResult) {
                [WTOut]::Info("Operation: '$tweakOperation' on tweak: '$tweakName' succeeded.`n")
            } else {
                [WTOut]::Warning("Operation: '$tweakOperation' on tweak: '$tweakName' failed!`n")
            }
        } else {
            [WTOut]::Error("Can't find tweak: '$tweakName'`n")
            $result = [WTExitCodes]::TweakNotFound
        }    
    } else {
        [WTOut]::Error("Executing requires admin rights!`n")
        $result = [WTExitCodes]::InsufficientRights
    }

    $result
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

function Test-IsAdmin {
    [Security.Principal.WindowsPrincipal]$principal = [Security.Principal.WindowsIdentity]::GetCurrent()

	$principal.IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")
}

function Show-WTUsage {
    [WTOut]::Print(@"
Usage:
  .\Win10Tweaker.ps1 [-tweak] <tweak_name> [-operation] <tweak_operation> [-verbose | -silent]
  .\Win10Tweaker.ps1 -recipe <recipe_name> [-verbose | -silent]
  .\Win10Tweaker.ps1 -list [-verbose]
  .\Win10Tweaker.ps1 -info <tweak_name_regex> [-verbose]

"@)
}

#########################################

# Main

[WTOut]::Print("`nWin10Tweaker v.$WT_VERSION, (c)VillageTech 2023`n")

[WTOut]::Trace("Mode: $([WTConfig]::GetTweakerMode())`n")

[int]$exitCode = [WTExitCodes]::Success

switch ([WTConfig]::GetTweakerMode()) {
    ([WTTweakerModes]::Tweak) {
        Initialize-WTTweaks

        [WTOut]::Trace("Name: '$([WTConfig]::GetName())'")
        [WTOut]::Trace("Operation: '$([WTConfig]::GetParam())'`n")

        $exitCode = (Use-WTTweak ([WTConfig]::GetName()) ([WTConfig]::GetParam()))
    }

    ([WTTweakerModes]::Recipe) {
        [WTOut]::Trace("Name: $([WTConfig]::GetName())`n")

        [string]$recipeFile = (Resolve-WTRecipe "$([WTConfig]::GetName())")
        if (! $recipeFile) {
            [WTOut]::Error("Recipe: '$([WTConfig]::GetName())' does not exist!`n")
            Exit [WTExitCodes]::RecipeNotFound
        }

        Initialize-WTTweaks

        $exitCode = (Use-WTRecipe $recipeFile)
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
            $exitCode = [WTExitCodes]::TweakNotFound
        }    
    }

    default {
        Show-WTUsage
        Exit [WTExitCodes]::ArgsError
    }
}

[int]$warningsCount = [WTOut]::GetWarningsCount()
[int]$errorsCount   = [WTOut]::GetErrorsCount()

if ($errorsCount -gt 0) {
    
    if ($exitCode -eq [WTExitCodes]::Success) {
        $exitCode = [WTExitCodes]::OtherError
    }
    
    if ($warningsCount -gt 0) {
        [WTOut]::Info("Errors count: $errorsCount, warnings count: $warningsCount`n")
    } else {
        [WTOut]::Info("Errors count: $errorsCount`n")
    }

} elseif ($warningsCount -gt 0) {

    [WTOut]::Info("Warnings count: $warningsCount`n")

}

[WTOut]::Trace("ExitCode: $exitCode`n")

Exit $exitCode

# EOF
